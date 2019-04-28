#ifndef GUARD_WATERINO_HARDWARE_HPP
#define GUARD_WATERINO_HARDWARE_HPP

#include "xtd_uc/avr.hpp"
#include "xtd_uc/chrono_noclock.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/limits.hpp"
#include "xtd_uc/ratio.hpp"
#include "xtd_uc/type_traits.hpp"
#include "xtd_uc/units.hpp"

#ifdef ENABLE_TEST
#include <iostream>
#else
#include "xtd_uc/uart.hpp"
#endif

#define make_scale(X) decltype(xtd::units::make_unity_valued<(X).count()>((X)))::scale

using namespace xtd::unit_literals;

/*
 *   Measuring capacitance
 * -------------------------------------------------------------------------------
 * We have an RC net where R is known and we're measuring C. The output of the RC net
 * is passed to an analog comparator together with RC_REF = K*Vcc. We measure the time
 * it takes charge C to RC_REF, and the comparator switches which raises an IRQ and
 * ends the measurement.
 *
 * The time it takes to charge C to RC_REF is: t = -R*C*ln(1-K) or conversely if we
 * measure t seconds, we determine C as:
 *
 *    C = -t/(R*ln(1-K)).
 *
 * Let Z = -1/ln(1-K), then we get:
 *
 *    C = t*Z/R
 *
 * By using undivided timers on the MCU we get t = cycles/F_CPU. And thus we get:
 *
 *    C = cycles*Z/(F_CPU*R)
 *
 * and the precision of the measurement is determined by the CPU clock perion, 1/F_CPU:
 *
 *    dC = Z/(F_CPU*R).
 *
 * The range of values we can measure is thus [dC, dC*2^n] where n is the number of bits
 * in the timer we use to measure t.
 *
 * We pick K=0.75, which gives:
 *
 *    Z = 1/ln(4) ~= 0.721347520444482 ~= 1970/2731 = 0.721347491761260
 *
 * Assume R=1M and F=8 MHz (internal RC osc.) then dC ~= 90 fF. And pick 24 bits for the counter
 * (16 overflow software counter and 8 for hardware), we get a range of C in [90pF, 1.5 µF].
 *
 * Preliminary tests of the probe geometry indicate a range of [0.5nF, 2.2nF] is appropriate.
 */

// We wrap all the functions as static methods in a struct intended to be passed
// as a template parameter to functionality that needs to access the hardware.
//
// We do this is order to be able to mock out the hardware for unit tests with a zero
// runtime cost.
//
namespace HAL {
  constexpr auto aref = 5_V;            // ADC reference voltage
  constexpr auto f_cpu = xtd::units::frequency<long, xtd::mega>(F_CPU/1000000);        // CPU frequency
  constexpr auto ntc_c = 100_nF;        // Nominal capacitance on NTC filter
  constexpr auto ntc_r_max = 100_kOhm;  // Max value of NTC in measurement range
  constexpr auto rc_r = 100_kOhm;       // The resistance used in the RC timing circuit
  constexpr auto rc_c_max = 10_nF;       // The maximum capacitance that can be measured
  constexpr auto rc_c_free_air = 504_pF; // At 38 rH 21C
  constexpr auto rc_c_water = 2_nF;     // The capacitance of water as measured by probe
  constexpr auto sense_period = 5_s;    // How frequently to sense the moisture
  constexpr auto use_watchdog = false;  // Whether or not the WDT should be used

  using f_cpu_scale = make_scale(f_cpu);
  using cycles = xtd::units::time<uint32_t, xtd::ratio_invert<f_cpu_scale>>;

  // Measured time it takes to charge the RC net with C disconnected, compensates for software
  // overhead when starting and stopping the timer as well as gate capacitance on the analog
  // comparator and on board parasitics.
  constexpr auto rc_time_offset = cycles(132);
  constexpr auto time_error = cycles(0xFFFFFFFF);

  // Capacitance quantity with scale appropriate for conversion factor so that
  // the number of clock cycles needed to charge the RC net can be directly
  // taken as the count() for this type to get the capacitance.
  using rc_r_scale = make_scale(rc_r);
  using rc_z_scale = xtd::ratio<1970, 2731>;  // Approximation of Z (above) for K=0.75
  using rc_c_scale = xtd::ratio_divide<rc_z_scale, xtd::ratio_multiply<f_cpu_scale, rc_r_scale>>;
  using rc_capacitance = xtd::units::capacitance<int32_t, rc_c_scale>;

  // Voltage quantity with scale such that the left aligned ADC output converts
  // directly to counts of the quantity to get the correct voltage.
  using adc_volt_scale = xtd::ratio_divide<make_scale(aref), xtd::ratio<1023UL * (1 << 6)>>;
  using adc_voltage = xtd::units::voltage<uint32_t, adc_volt_scale>;

  using kelvin = xtd::units::temperature<uint16_t, xtd::centi>;
  using moisture = xtd::units::scale<int16_t, xtd::milli>;
  using callback_void_t = void (*)(void);

  enum error_code : char { error_reset_during_pumping, dry_overflow };

#ifdef ENABLE_TEST
  extern std::ostream& uart;
#else
  extern xtd::ostream<xtd::uart_stream_tag> uart;
#endif

  // Sets up default state for the hardware, must be called prior to calling any other functions
  // here.
  void hardware_initialize();

  // Light the PUMP_LED.
  void pump_led_on();

  // Turn off the PUMP_LED.
  void pump_led_off();

  // Activates the pump until stopped, synchronization between shared pump users
  // must be done else where.
  void pump_activate();

  // Stop the pump.
  void pump_stop();

  // Get the user's attention.
  void alert();

  // Halts the MCU after sending error message over UART and giving a LED blink pattern based on the
  // error code.
  void fatal(error_code code, const xtd::pstr& msg);

  // Senses the capacitance over the probes co-planar capacitor
  // Returns our best estimate of the true capacitance.
  cycles sense_rc_delay();

  // Senses the temperature at the tip of the co-planar capacitor
  // Returns a raw reading from the ADC, it may be filtered for noise.
  adc_voltage sense_ntc_drop();

  // Senses the voltage drop across the overflow electrodes.
  // A drop of Aref V indicates disconnection and a drop of 0 V indicates a shortcircuit.
  // Typically we expect around 3/4*Aref during a short circuit.
  adc_voltage sense_overflow();

  // Connects the overflow sensor to analog comparator IRQ.
  // When the overflow sensor detects water, the ANALOG_COMP_vect ISR will run.
  // May not be active when sense_rc_delay() is called.
  void sense_overflow_enable_irq(callback_void_t cb);

  // Disable the overflow sensor ISR.
  void sense_overflow_disable_irq();
}  // namespace HAL

#undef make_type
#endif
