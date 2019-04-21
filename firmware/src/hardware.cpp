#include "hardware.hpp"

#include "xtd_uc/adc.hpp"
#include "xtd_uc/blink.hpp"
#include "xtd_uc/gpio.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/wdt.hpp"

#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/atomic.h>

volatile uint16_t g_timer_overflows;
volatile HAL::callback_void_t g_overflow_cb = nullptr;

constexpr uint16_t c_timer_max_overflows = HAL::cycles(HAL::rc_r * HAL::rc_c_max * 5).count() >> 14;

// ADC channels
constexpr auto ach_dbg_a0 = uint8_t(1);
constexpr auto ach_dbg_a1 = uint8_t(0);
constexpr auto ach_abg_a2 = uint8_t(7);
constexpr auto ach_pump = uint8_t(2);
constexpr auto ach_overflow_sense = uint8_t(3);
constexpr auto ach_twi_sda = uint8_t(4);
constexpr auto ach_twi_scl = uint8_t(5);
constexpr auto ach_temperature = uint8_t(6);

// Port B
constexpr auto pin_rc_en = xtd::gpio_pin(xtd::port_b, 0);
constexpr auto pin_temperature_exc = xtd::gpio_pin(xtd::port_b, 1);
constexpr auto pin_nc_0 = xtd::gpio_pin(xtd::port_b, 2);
constexpr auto pin_spi_mosi = xtd::gpio_pin(xtd::port_b, 3);
constexpr auto pin_spi_miso = xtd::gpio_pin(xtd::port_b, 4);
constexpr auto pin_spi_sck = xtd::gpio_pin(xtd::port_b, 5);
// constexpr auto pin_pump_led = xtd::gpio_pin(xtd::port_b, 6);
constexpr auto pin_pump_led = xtd::gpio_pin(xtd::port_c, 1);

// Port C
constexpr auto pin_dbg_a1 = xtd::gpio_pin(xtd::port_c, 0);
constexpr auto pin_dbg_a0 = xtd::gpio_pin(xtd::port_c, 1);
constexpr auto pin_pump = xtd::gpio_pin(xtd::port_c, 2);
constexpr auto pin_overflow_sense = xtd::gpio_pin(xtd::port_c, 3);
constexpr auto pin_twi_sda = xtd::gpio_pin(xtd::port_c, 4);
constexpr auto pin_twi_scl = xtd::gpio_pin(xtd::port_c, 5);
constexpr auto pin_reset = xtd::gpio_pin(xtd::port_c, 6);

// Port D
constexpr auto pin_rx = xtd::gpio_pin(xtd::port_d, 0);
constexpr auto pin_tx = xtd::gpio_pin(xtd::port_d, 1);
constexpr auto pin_nc_1 = xtd::gpio_pin(xtd::port_b, 2);
constexpr auto pin_nc_2 = xtd::gpio_pin(xtd::port_b, 3);
constexpr auto pin_nc_3 = xtd::gpio_pin(xtd::port_b, 4);
constexpr auto pin_rc_exc = xtd::gpio_pin(xtd::port_d, 5);
constexpr auto pin_rc_ref = xtd::gpio_pin(xtd::port_d, 6);
constexpr auto pin_c_sense = xtd::gpio_pin(xtd::port_d, 7);

uint16_t slow_adc_read(uint8_t ch) {
  xtd::adc_enable(1_Hz,   // We're measuring a DC signal, pick slowest speed possible
                  false,  // Not MSB a ligned
                  xtd::adc_internal_vcc,  // Vcc as Aref
                  ch);

  uint16_t result = 0;
  for (uint8_t i = 0; i < (1 << 6); ++i) {
    result += xtd::adc_read_single_low_noise();
  }

  xtd::adc_disable();
  return result;
}

// -----------------------------------------------------------------------------
//
// Pump management
//
// -----------------------------------------------------------------------------

namespace HAL {

  xtd::ostream<xtd::uart_stream_tag> uart;

  void pump_led_on() { xtd::gpio_write(pin_pump_led, true); }

  void pump_led_off() { xtd::gpio_write(pin_pump_led, false); }

  void pump_activate() { xtd::gpio_write(pin_pump, true); }

  void pump_stop() { xtd::gpio_write(pin_pump, false); }

  void alert() {}

  void fatal(error_code /*code*/, const xtd::pstr& msg) {
    // TODO: Signal over I2C
    uart << xtd::pstr(PSTR("FATAL: ")) << msg << '\n';
    while (true) {
      pump_led_on();
      xtd::delay(200_ms);
      pump_led_off();
      xtd::delay(200_ms);
    }
  }

  // -----------------------------------------------------------------------------
  //
  // Sensing the RC network
  //
  // -----------------------------------------------------------------------------

  void sense_rc_enable() {
    DIDR1 = _BV(AIN1D) | _BV(AIN0D);  // Disable digital inputs on AIN0/1
    ACSR = _BV(ACD) |                 // Disable analog comparator until we're ready
           _BV(ACIC) |  // Enable output from comparator to input capture (1-2 cycles delay)
           _BV(ACI);    // Clear pending IRQs
    xtd::clr_bit(ADCSRB, ACME);  // Prevent ADC channels from being used for positive input

    xtd::gpio_config(pin_rc_exc, xtd::output, false);  // Power RC_REF
    xtd::gpio_config(pin_rc_en, xtd::output, false);   // Start drainig C_sense
    xtd::gpio_config(pin_c_sense, xtd::tristate);  // Digital inputs are disabled, don't drive pin
    xtd::gpio_config(pin_rc_ref, xtd::tristate);   // -||-

    xtd::delay(rc_r * rc_c_max * 5);  // Wait 5RC for drain to complete

    // Setup timer1 but no IRQs enabled
    xtd::clr_bit(PRR, PRTIM1);  // Power on Timer 1
  }

  void sense_rc_disable() {
    xtd::gpio_config(pin_rc_exc, xtd::tristate);
    xtd::gpio_config(pin_rc_en, xtd::output, false);  // Don't tristate as that will drain power
    // Disable Analog Comparator and clear pending IRQs
    ACSR = _BV(ACD) | _BV(ACI);

    xtd::set_bit(PRR, PRTIM1);  // Power down the timer
  }

  void sense_rc_begin() {
    set_sleep_mode(SLEEP_MODE_IDLE);
    sleep_enable();

    g_timer_overflows = 0;
    TCCR1A = 0;            // No OC outputs and no waveform generation
    TCCR1B = _BV(ICNC1);   // Input noise canceller from comparator, falling edge trigger
    TCCR1C = 0;            // No force output bits
    TIMSK1 = _BV(ICIE1) |  // We need IRQ on input capture to wake from sleep
             _BV(TOIE1);   // IRQ on counter overflow
    TIFR1 = 0xFF;

    TCNT1H = 0;  // Reset counter
    TCNT1L = 0;
    xtd::clr_bit(ACSR, ACD);           // Enable Analog comparator
    xtd::set_bit(TCCR1B, CS10);        // Start timing
    xtd::gpio_write(pin_rc_en, true);  // Start charging C_sense
  }

  void sense_rc_end() {
    // Disable timer1 and clear pending IRQs
    TCCR1A = 0;
    TCCR1B = 0;
    TCCR1C = 0;
    TIMSK1 = 0;
    TIFR1 = 0xFF;

    sleep_disable();
  }

  bool sense_rc_ongoing() { return xtd::test_bit(TCCR1B, CS10); }

  uint32_t sense_rc_compute_result() {
    return (uint32_t(g_timer_overflows) << 16) | (uint32_t(ICR1L)) | (uint32_t(ICR1H) << 8);
  }

  cycles sense_rc_delay() {
    // We need the pins if they are used by sense overflow.
    sense_overflow_disable_irq();

    sense_rc_enable();

    cli();
    sense_rc_begin();
    while (sense_rc_ongoing()) {
      sei();
      sleep_cpu();  // Sleep to reduce noise
      cli();
    }
    sei();

    uint32_t result = sense_rc_compute_result();
    /*
    xtd::gpio_config(pin_c_sense, xtd::output,
                     false);  // Digital inputs are disabled, don't drive pin
    cli();
    sense_rc_begin(pin_c_sense);
    while (sense_rc_ongoing()) {
      sei();
      sleep_cpu();  // Sleep to reduce noise
      cli();
    }
    sei();

    uint32_t overhead = sense_rc_compute_result();
    */
    constexpr auto overhead = 46;
    sense_rc_disable();

    // Check if we terminated due to timeout
    if (g_timer_overflows == c_timer_max_overflows) {
      return time_error;
    }
    return cycles(result - overhead);
  }

  // -----------------------------------------------------------------------------
  //
  // Sense voltage over NTC
  //
  // -----------------------------------------------------------------------------

  adc_voltage sense_ntc_drop() {
    xtd::gpio_config(pin_temperature_exc, xtd::output, false);
    xtd::delay(ntc_c * ntc_r_max * 5);  // Let filter cap charge/discharge through ntc/r

    auto ntc_vdrop = adc_voltage(slow_adc_read(ach_temperature));
    xtd::gpio_config(pin_temperature_exc, xtd::tristate);
    return ntc_vdrop;
  }

  // -----------------------------------------------------------------------------
  //
  // Sense voltage over overflow electrodes
  //
  // -----------------------------------------------------------------------------

  adc_voltage sense_overflow() { return adc_voltage(slow_adc_read(ach_overflow_sense)); }

  void sense_overflow_enable_irq(callback_void_t cb) {
    cli();
    g_overflow_cb = cb;

    // The pullup from RC_REF should form a parallel resistance with
    // the top resistor of the RC_REF divider to put the reference voltage
    // higher.
    xtd::gpio_config(pin_rc_ref, xtd::pullup);
    xtd::gpio_config(pin_rc_exc, xtd::output, false);

    // ADC must be powered, but disabled to enable the ADC channels as inputs to the AC
    xtd::clr_bit(PRR, PRADC);
    ADCSRA = _BV(ADIF);              // Disable ADC and clear any IRQ flags, now ADCx channels
    ADCSRB = _BV(ACME);              // can be selected as inputs to AC when ACME is set by
    ADMUX = ach_overflow_sense;      // writing the channel to the mux.
    ACSR = _BV(ACI) |                // Clear pending IRQs
           _BV(ACIE) |               // Enable IRQs
           _BV(ACIS1) | _BV(ACIS0);  // IRQ on rising edge

    sei();
  }

  void sense_overflow_disable_irq() {
    cli();
    // Disable Analog Comparator and clear pending IRQs
    ACSR = _BV(ACD) | _BV(ACI);
    xtd::adc_disable();

    xtd::gpio_config(pin_rc_ref, xtd::tristate);
    xtd::gpio_config(pin_rc_exc, xtd::tristate);
    sei();
  }

  void hardware_initialize() {
    DIDR1 = _BV(AIN1D) | _BV(AIN0D);  // Disable digital inputs on AIN0/1
    DIDR0 = _BV(ADC3D);               // Disable digital inputs on overflow sense (temp has no DIO)

    // All inputs as pullups to start with, makes sure NC pins aren't left floating
    xtd::gpio_config(xtd::port_b, xtd::pullup);
    xtd::gpio_config(xtd::port_d, xtd::pullup);
    xtd::gpio_config(xtd::port_c, xtd::pullup);

    // Configure other pins so that no pin is floating and causing excessive switching
    xtd::gpio_config(pin_pump, xtd::output, false);        // Leave pump driven inactive
    xtd::gpio_config(pin_rc_en, xtd::output, false);       // No external pull, drive low
    xtd::gpio_config(pin_temperature_exc, xtd::tristate);  // Externally pulled to AVcc if tristated
    xtd::gpio_config(pin_pump_led, xtd::output, false);    // Leave LED pin driven inactive
    xtd::gpio_config(pin_rc_exc, xtd::tristate);           // Power down RC_REF

    xtd::clr_bit(ACSR, ACIE);    // Disable IRQs for comparator to IRQs during power down
    xtd::set_bit(ACSR, ACD);     // Power down analog comparator
    xtd::clr_bit(ADCSRB, ACME);  // Do not use ADC inputs for comparator
    xtd::adc_disable();

    xtd::set_bit(PRR, PRTIM1);  // ...power down the timer
  }
}  // namespace HAL

ISR(ANALOG_COMP_vect) {
  if (nullptr != g_overflow_cb) {
    g_overflow_cb();
  }
}

ISR(TIMER1_OVF_vect) {
  if (HAL::sense_rc_ongoing()) {
    // Don't count up if we get a suprious irq after timing is done
    return;
  }

  g_timer_overflows++;
  if (g_timer_overflows == c_timer_max_overflows) {
    HAL::sense_rc_end();
  }
}

ISR(TIMER1_CAPT_vect) {
  // Technically Capture and Overflow IRQs can be raised at the same clock cycle.
  //
  // AVR prioritizes IRQs based in their position in the IRQ table.
  // Timer1 Overflow has position 14 and Timer1 Capture has positon 11; Meaning
  // the capture ISR will execute before the overflow ISR and thus
  // g_timer_overflows may be one too low.
  if (xtd::test_bit(TIFR1, TOV1)) {
    // Overflow IRQ raised simultaneously with this IRQ or slightly after
    if (0 == ICR1L && 0 == ICR1H) {
      // It was simultaneously
      g_timer_overflows++;
    }
  }

  // We take the first IRQ requests so disable analog comparator output
  HAL::sense_rc_end();
}
