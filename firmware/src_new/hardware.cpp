#include "sensors.hpp"

#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/atomic.h>

volatile uint16_t g_timer_overflows;

constexpr uint16_t c_timer_max_overflows = 0xFF;
constexpr auto c_rc_exc = xtd::gpio_pin(xtd::gpio_port_d, 5);
constexpr auto c_rc_en = xtd::gpio_pin(xtd::gpio_port_b, 0);
constexpr auto c_temperature_exc = xtd::gpio_pin(xtd::gpio_port_b, 1);
constexpr uint8_t c_temperature_adc_ch = 6;
constexpr uint8_t c_overflow_adc_ch = 3;

void timer1_stop() { xtd::clr_bit(TCCR1B, CS10); }

void timer1_start() {
  g_timer_overflows = 0;
  xtd::set_bit(TCCR1B, CS10);
}

void timer1_running() { xtd::test_bit(TCCR1B, CS10); }

void timer1_setup() {
  xtd::clr_bit(PRR, PRTIM1);  // Power on Timer 1

  TCCR1A = 0;            // No OC outputs and no waveform generation
  TCCR1B = _BV(ICNC1) |  // Input noise canceller from comparator
           _BV(ICES1);   // Capture on falling edge, and stop timer
  TCCR1C = 0;            // No force output bits
  TCNT1H = 0;            // Reset counter
  TCNT1L = 0;
  TIMSK1 = _BV(ICIE1) |  // We need IRQ on input capture to wake from sleep
           _BV(TOIE1);   // IRQ on counter overflow
  TIFR1 = 0xFF;          // Clear all IRQ flags
}

void ancmp_setup() {
  ACSR = _BV(ACIC);  // Enable comparator and output to the capture unit of timer1.
}

ISR(TIMER1_OVF_vect) {
  g_timer_overflows++;
  if (g_timer_overflows == c_timer_max_overflows) {
    timer1_stop();  // Maximum delay exceeded
  }
}

ISR(TIMER1_CAPT_vect) {
  timer1_stop();

  // Technically Capture and Overflow IRQs can be raised at the same clock cycle.
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
  // Clear the IRQ flag to prevent the overflow ISR from being ran when we return.
  xtd::set_bit(TIFR1, TOV1);
}

void sense_initialize() {
  // Put sense related hardware into it's default, powered down state.
  DIDR1 = _BV(AIN1D) | _BV(AIN0D);  // Disable digital inputs on AIN0/1
  DIDR0 = _BV(ADC3D);               // Disable digital inputs on overflow sense (temp has no DIO)

  xtd::gpio_config(c_temperature_exc, xtd::tristate);  // Stop exciting NTC
  xtd::gpio_config(c_rc_exc, xtd::tristate);           // Power down RC_REF
  xtd::gpio_config(c_rc_en, xtd::tristate);            // Stop charging C_sense and disconnect it

  ADCSRA = _BV(ADIF);        // Clear pending IRQs and disable ADC
  xtd::set_bit(PRR, PRADC);  // Then power down

  xtd::clr_bit(ADCSRB, ACME);  // Do not use ADC inputs for comparator
  xtd::clr_bit(ACSR, ACIE);    // Disable IRQs for comparator to IRQs during power down
  xtd::set_bit(ACSR, ACD);     // Power down analog comparator

  TCCR1B = 0;                 // Stop timer if it was running and then...
  xtd::set_bit(PRR, PRTIM1);  // ...power down the timer
}

cycles sense_rc_delay() {
  xtd::gpio_config(c_rc_exc, xtd::output, false);  // Power RC_REF
  xtd::gpio_config(c_rc_en, xtd::output, false);   // Start drainig C_sense
  xtd::sleep(c_rc_r * c_rc_c_max * 5, true);       // Wait 5RC for drain to complete

  cli();
  ancmp_setup();
  timer1_setup();
  set_sleep_mode(SLEEP_IDLE);
  sleep_enable();

  timer1_start();                  // Start measuring
  xtd::gpio_write(c_rc_en, true);  // Start charging
  while (timer1_running()) {
    sei();
    sleep_cpu();  // Sleep to reduce noise
    cli();
  }
  sleep_disable();

  TCCR1B = 0;                                   // Disable IRQs for timer1
  sei();                                        // *THEN* enable global IRQs again
  xtd::set_bit(ADCSR, ACD);                     // Power down analog comparator
  xtd::gpio_config(c_rc_exc, xtd::tristate);    // Power down RC_REF
  xtd::gpio_write(c_rc_en, xtd::tristate);      // Stop charging C_sense and disconnect it
  uint32_t ticks = (c_timer_overflows << 16) |  // Compute result before powering down the timer
                   ICR1L | (ICR1H << 8);        //
  xtd::set_bit(PRR, PRTIM1);                    // Power down the timer

  // Check if we terminated due to timeout
  if (g_timer_overflows == c_timer_max_overflows) {
    return c_time_error;
  }

  return cycles(ticks);
}

uint16_t slow_adc_read(uint8_t ch) {
  adc_enable(1_Hz,                   // We're measuring a DC signal, pick slowest speed possible
             false,                  // Not MSB a ligned
             xtd::adc_internal_vcc,  // Vcc as Aref
             ch);

  uint16_t result = 0;
  for (uint8_t i = 0; i < (1 << 6); ++i) {
    result += adc_read_single_low_noise();
  }

  adc_disable();
  return result;
}

adc_voltage sense_temperature_raw() { return adc_voltage(slow_adc_read(c_temperature_adc_ch)); }

adc_voltage sense_overflow() { return adc_voltage(slow_adc_read(c_overflow_adc_ch)); }

void sense_overflow_enable_irq(){}

void sense_overflow_disable_irq(){

}
