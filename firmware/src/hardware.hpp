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

#define SCALE(X) decltype(xtd::units::make_unity_valued<(X).count()>((X)))::scale

using namespace xtd::unit_literals;

// We wrap all the functions as static methods in a struct intended to be passed
// as a template parameter to functionality that needs to access the hardware.
//
// We do this is order to be able to mock out the hardware for unit tests with a zero
// runtime cost.
//
namespace HAL {
#ifdef ENABLE_TEST
  extern std::ostream& uart;
#else
  extern xtd::ostream<xtd::uart_stream_tag> uart;
#endif

  using namespace xtd::units;
  using xtd::ratio;
  using xtd::ratio_divide;
  using xtd::ratio_invert;
  using xtd::ratio_multiply;
  using overflow_callback_t = void (*)(void);

  constexpr auto aref = 5_V;                                           // ADC reference voltage
  constexpr auto f_cpu = frequency<long, xtd::mega>(F_CPU / 1000000);  // CPU frequency
  constexpr auto ntc_c = 100_nF;        // Nominal capacitance on NTC filter
  constexpr auto ntc_r_max = 100_kOhm;  // Max value of NTC in measurement range
  constexpr auto sense_period = 1_h;    // How frequently to sense the moisture
  constexpr auto use_watchdog = false;  // Whether or not the WDT should be used
  using cycles = time<uint32_t, ratio_invert<SCALE(f_cpu)>>;

  constexpr auto rc_c_max = 100_pF;
  constexpr auto rc_f_max = f_cpu / xtd::units::scale<long, ratio<100>>(1);
  constexpr auto rc_r = 1000_kOhm;  // The resistance used in the RC timing circuit
  constexpr auto rc_counts = 256;

  using one_over_two_ln_two = ratio<1970, 2731>;  // 1/(2*log(2)) = 0.72135 ~= 1970/2731
  using rc_capacitance =
      capacitance<int32_t, ratio_divide<one_over_two_ln_two, SCALE(rc_r* f_cpu* rc_counts)>>;

  static_assert(xtd::units::scale<long, one_over_two_ln_two>(1) <= rc_r * rc_c_max * rc_f_max,
                "RC net parameters incompatible! R too small or F_RC_max/C_RC_max too big!");
  static_assert(rc_capacitance(11_nF) > 10_nF,
                "rc_capacitance must be able to represent more than 10_nF");
  static_assert(rc_capacitance(100_fF) < 1_pF,
                "rc_capacitance must be able to represent less than 1_pF");

  // F = 1 / (2*ln(2)*R*C), F = 2^16/cycles => C = cycles / (2*ln(2)*R*2^16)

  // Voltage quantity with scale such that the left aligned ADC output converts
  // directly to counts of the quantity to get the correct voltage.
  using adc_voltage = voltage<uint32_t, ratio_divide<SCALE(aref), ratio<1023UL * (1 << 6)>>>;

  using kelvin = temperature<int32_t, xtd::centi>;
  using moisture = scale<int16_t, xtd::milli>;

  enum error_code : char { error_reset_during_pumping, dry_overflow };

  static_assert(kelvin(0x7FFFF) > 373_K, "kelvin type must be able to represent more than 100 C");
  static_assert(kelvin(0x80000) > 173_K, "kelvin type must be able to represent less than -100 C");

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
  rc_capacitance sense_capacitance();

  // Senses the temperature at the tip of the co-planar capacitor
  // Returns a raw reading from the ADC, it may be filtered for noise.
  adc_voltage sense_ntc_drop();

  // Senses the voltage drop across the overflow electrodes.
  // A drop of Aref V indicates disconnection and a drop of 0 V indicates a shortcircuit.
  // Typically we expect around 3/4*Aref during a short circuit.
  bool sense_overflow();

  // Connects the overflow sensor to analog comparator IRQ.
  // When the overflow sensor detects water, the ANALOG_COMP_vect ISR will run.
  // May not be active when sense_rc_delay() is called.
  void sense_overflow_enable_irq(overflow_callback_t cb);

  // Disable the overflow sensor ISR.
  void sense_overflow_disable_irq();
}  // namespace HAL

#undef SCALE
#endif
