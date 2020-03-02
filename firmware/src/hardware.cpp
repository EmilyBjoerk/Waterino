/*
 * Both ends of a 1:2 ratio voltage divider are connected to GPIO pins.
 * The midpoint of the voltage divider is connected to the positive pin
 * of the analog comparator. The top pin is charging an RC net and the
 * output of the RC net is the negative pin of the analog comparator.
 *
 * When the divider is positively oriented (top pin +, bottom pin -) then
 * the positive pin of the comparator is 2/3 VCC and the RC net is being
 * charged from 0 to VCC. One the output of the RC net crosses 2/3 VCC
 * The analog comparator raises an IRQ, swapping the top and bottom pin
 * voltages, changing the positive pin voltage to 1/3 VCC and the RC
 * net starts to discharge from 2/3 VCC to 1/3 VCC and the IRQ trips again
 * swapping the pins and so the output of the RC net will oscillate between
 * 1/3 and 2/3 VCC. This is analoguous to a 555 timer in astable 50% duty
 * cycle mode.
 *
 * On the discharge and charge IRQ from the analog comparator we will toggle
 * the T1 pin manually to cause the TIMER/COUNTER1 (which has been suitably
 * configured) to count up one.
 *
 * On TIMER/COUNTER1 overflow we will stop the the counter, break the
 * charge/discharge cycle, and measure how many CPU clockcycles it took for
 * TIMER/COUNTER1 (which is a 16 bit timer) to overflow. Based on this we
 * know the frequency that the RC net oscillated with.
 *
 * The number of CPU clock cycles it took to count up 2^16 relates to the
 * frequency, F, like so: F = 2^16/cycles.
 *
 * This gives the sensed capacitance as F = 1 / (2*ln(2)*R*C)
 * or C = cycles / (2*ln(2)*R*2^16). (#1)
 *
 * We'll assume that the influence of noise on the RC net is low enough to
 * not affect the frequency of the output.
 *
 * The capacitance of the RC net will consist of a parasitic capacitance
 * to the ground plane along the trace to the sensort track and behind
 * the sensor track. We assume this parasitic capacitance has a negligible
 * temperatur dependency compared to the other parts of the sensor in
 * contact with water. This is motivated by the fact that water has around
 * 80 times higher dielectric constant than air and 20 times higher than FR4,
 * and that the separation from the ground plane is relatively high (1.6 mm).
 * A small part of the sensor track is above the ground and dependent on the
 * humidity and temperature. Again here we will assume that the variance
 * of this capacitance due to humidity and temperature will be dominated by
 * the variance of the capacitance of the sensor in contact with the soil
 * and water in the soil.
 *
 * For the above reasons we consider the total capacitance sensed as:
 * C(m,t) = Ck + Cs(m,t) where m is the soil moisture level and t is the
 * temperature of the soil. We know that capacitance is a linear function
 * of the dielectric value regardless of geometry. We know that the dielectric
 * of water depends on the temperature (non linearly).
 *
 * So we can express Cs(m,t) as: A + B*m*T(t). Where T is the temperature
 * dependency of the water's dielectric value. However we can bake A into
 * Ck and rename B as Cs and thus we get:
 *
 * C(m,t) = Ck + Cs*m*T(t)
 *
 * Let's take two calibration points at temperature: t = t_cal. We'll assume
 * that soil can never have less moisture content than the absolute humidity
 * of the air. So our "dry" reference is free air (at some humidity). And
 * our "wet" refrence is with the sensor submerged in water to the same level
 * as the soil will be when in use.
 *
 * Then we have: Cair = C(m_min, t_cal) and Cwater = C(m_max, t_cal).
 *
 * And if we have a measurement of C(m=M,t=t_cal) as C we can solve for 'm' as:
 *
 * m = (C - Cair) / (Cwater - Cair)
 *   = /Substitute and simplify/
 *   = (M*T(t=t_cal) - m_min*T(t_cal))/(m_max*T(t_cal) - m_min*T(t_cal))
 *   = (M*T(t=t_cal)/T(t_cal) - m_min)/(m_max - m_min)
 *
 * So if we let C' = C * T(t_cal)/T(t) and do the above exercise again but let
 * 't' be a free variable, we end up with:
 *
 * m = (M - m_min + E)/(m_max - m_min)
 * E = Ck/Cs*(T(t_cal)/T(t) -1)
 *
 * We know T(t) and can compute it. And because T(t) varies slowly with 't',
 * T(t_cal)/T(t) ~= 1 for t_cal close to 't' and Ck is small compared to Cs
 * using C' = instead of C will yield a smaller error for m than using C directly.
 *
 * Using (#1) above to convert from cycles to capacitance we can see that if
 * the calibration points are also taken as cycle counts, the constant factor
 * 1/(2*ln(2)*R*2^16) will cancel out.
 *
 * So the final formula for 'm':
 *
 * m = (cycles*T(t_cal)/T(t) - cycles_air) / (cycles_water - cycles_air), m = [0,1].
 *
 * Note that it is possible for m to be slightly outside the above ranget due
 * to the fact that we have ignored the (small) dependency on air moisture
 * and air temperature and the approximations made.
 *
 * The calibration points should be taken at the middle of the typical operating
 * temperature range for best accuracy.
 */

#include "hardware.hpp"

#include "xtd_uc/adc.hpp"
#include "xtd_uc/blink.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/gpio2.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/units.hpp"
#include "xtd_uc/utility.hpp"  // bit functions
#include "xtd_uc/wdt.hpp"

#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/sleep.h>
#include <util/atomic.h>

constexpr auto ach_overflow = uint8_t(3);
constexpr auto ach_temperature = uint8_t(6);
using pin_overflow_en = xtd::pin<xtd::port_c, 2>;
using pin_overflow_sense = xtd::pin<xtd::port_c, 3>;
using pin_temperature_en = xtd::pin<xtd::port_b, 1>;
using pin_pump_en = xtd::pin<xtd::port_c, 1>;
using pin_pump_led = xtd::pin<xtd::port_d, 5>;
using pin_rc_top = xtd::pin<xtd::port_b, 7>;
using pin_rc_bot = xtd::pin<xtd::port_b, 6>;
using pin_rc_ref = xtd::pin<xtd::port_d, 6>;
using pin_rc_sens = xtd::pin<xtd::port_d, 7>;
using pin_t1 = xtd::pin<xtd::port_d, 5>;

constexpr auto c_overflow_threshold = uint16_t(800 << 6);

volatile HAL::overflow_callback_t g_overflow_cb = nullptr;

ISR(ANALOG_COMP_vect, ISR_NAKED) {
  if (pin_rc_top::test()) {
    // We were charging, start discharging
    pin_rc_top::clr();
    pin_rc_bot::set();
    pin_t1::clr();
  } else {
    // We were discharging, start charging
    pin_rc_top::set();
    pin_rc_bot::clr();
    pin_t1::set();
  }
  reti();
}

ISR(TIMER1_COMPA_vect/*TIMER1_OVF_vect*/) { TCCR1B = 0; }

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

  void pump_led_on() { pin_pump_led::output(true); }

  void pump_led_off() { pin_pump_led::clr(); }

  void pump_activate() { pin_pump_en::output(true); }

  void pump_stop() { pin_pump_en::clr(); }

  void alert() {}

  void fatal(error_code code) {
    // TODO: Signal over I2C
    uart << xtd::pstr(PSTR("FATAL: ")) << static_cast<int>(code) << '\n';
    while (true) {
      xtd::blink<pin_pump_led>(10, 200_ms);
      xtd::wdt_reset_timeout();
    }
  }

  // -----------------------------------------------------------------------------
  //
  // Sense voltage over NTC
  //
  // -----------------------------------------------------------------------------

  adc_voltage sense_ntc_drop() {
    pin_temperature_en::output(false);
    xtd::delay(ntc_c * ntc_r_max * 5);  // Let filter cap charge/discharge through ntc/r

    auto ntc_vdrop = adc_voltage(slow_adc_read(ach_temperature));
    pin_temperature_en::set();
    return ntc_vdrop;
  }

  // -----------------------------------------------------------------------------
  //
  // Sense voltage over overflow electrodes
  //
  // -----------------------------------------------------------------------------

  void sense_overflow_cb() {
    if (g_overflow_cb) {
      auto v = ADC;
      if (v < c_overflow_threshold) {
        g_overflow_cb();
        sense_overflow_disable_irq();
      }
    }
  }

  bool sense_overflow() {
    pin_overflow_en::output(true);
    pin_overflow_sense::tristate();
    auto v = slow_adc_read(ach_overflow);
    pin_overflow_en::clr();
    return v < c_overflow_threshold;
  }

  void sense_overflow_enable_irq(overflow_callback_t cb) {
    g_overflow_cb = cb;
    pin_overflow_en::output(true);
    pin_overflow_sense::tristate();
    xtd::adc_enable(1_Hz, /* msb_align_result= */ true, xtd::adc_internal_vcc, ach_overflow);
    xtd::adc_continuous_start(xtd::adc_free_running, sense_overflow_cb);
  }

  void sense_overflow_disable_irq() {
    xtd::adc_continuous_stop();
    xtd::adc_disable();
    pin_overflow_en::clr();
  }

  // -----------------------------------------------------------------------------
  //
  // Sense voltage over overflow electrodes
  //
  // -----------------------------------------------------------------------------

  void sense_rc_enable() {
    xtd::chrono::steady_clock::now();  // Make sure the clock is actually running the first time
    pin_t1::output(true);
    pin_rc_top::output(false);
    pin_rc_bot::output(false);
    pin_rc_ref::tristate();
    pin_rc_sens::tristate();

    xtd::delay(100_ms);
    xtd::clr_bit(PRR, PRTIM1);  // Power up TIMER/COUNTER1

    cli();
    xtd::clr_bit(ADCSRB, ACME);  // Use AIN1 for negative input to comparator
    ACSR = _BV(ACI);
    DIDR1 = 0x3;
    OCR1A = rc_counts - 1;
    TCCR1A = 0;
    TCCR1B = 0;
    TCCR1C = 0;
    TCNT1 = 0;
    TIMSK1 = _BV(OCIE1A); //_BV(TOIE1);
    TIFR1 = 0xFF;
    sei();
  }

  void sense_rc_disable() {
    cli();
    TCCR1B = 0;                 // Stop timer
    TIFR1 = 0xFF;               // Clear all IRQ flags
    xtd::set_bit(PRR, PRTIM1);  // Power down TIMER/COUNTER1

    xtd::clr_bit(ADCSRB, ACME);  // Disable analog comparator multiplexer if it was on
    ACSR = _BV(ACD) | _BV(ACI);  // Switch off analog comparator and clear pending IRQ

    pin_rc_top::clr();
    pin_rc_bot::clr();
    pin_t1::clr();
    sei();
  }

  rc_capacitance sense_capacitance() {
    sense_rc_enable();
    TCCR1B = _BV(WGM12) |                        // Select timer mode 4: CTC, TOP = OCR1A
             _BV(CS12) | _BV(CS11) | _BV(CS10);  // Clock on rising edge of pin T1
    ACSR |= _BV(ACIE);
    pin_rc_top::set();
    auto start = xtd::chrono::steady_clock::now();
    while (TCCR1B)
      ;
    auto end = xtd::chrono::steady_clock::now();
    sense_rc_disable();
    auto duration = end - start;
    return rc_capacitance(duration.count());
  }

  void hardware_initialize() {
    // The default pin state after boot is (0,0), i.e. hi-z inputs. NC pins will float and
    // spuriously flip the digital input. The below makes sure no pins are floating.
    // Most but not all (I2C, RESET, UART) pins can be driven low in their "idle" state.

    xtd::port<xtd::port_b>::output(/* pins= */ 0xFF, /* values= */ 0x00);  // Port B LOW
    xtd::port<xtd::port_c>::pullup(/* pins= */ 0xF0);  // I2C + RESET are pull-up for now
    xtd::port<xtd::port_c>::output(/* pins= */ 0x0F, /* values= */ 0x00);  // Rest LOW

    xtd::port<xtd::port_d>::output(/* pins= */ 0xFC, /* values= */ 0x00);
    xtd::port<xtd::port_d>::pullup(/* pins= */ 0x03);  // UART is pull-up for now

    // Disable digital input ciruitry where it is not used.
    DIDR1 = _BV(AIN1D) | _BV(AIN0D);                            // AIN0/1
    DIDR0 = _BV(ADC3D) | _BV(ADC2D) | _BV(ADC1D) | _BV(ADC0D);  // ADC pins
  }
}  // namespace HAL
