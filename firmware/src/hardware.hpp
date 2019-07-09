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

// This macro takes an xtd::quantity<...> object and produces a xtd::ratio<> such that
// X == xtd::quantity<X::value_type, X::units, RATIO>(1). I.e. converts the input to a
// an xtd::ratio.
#define SCALE(X) decltype(xtd::units::make_unity_valued<(X).count()>((X)))::scale

// Yes, using namespace is a bad practice but we use the unit literals everywhere
// and this is the only way of using them for constants in headers.
using namespace xtd::unit_literals;

// In order to facilitate mocking out manipulation of the hardware for the purpose of
// testing we create a Hardware Abstraction Layer (HAL) that the unit tests can implement
// using mocks. Other code should never directly manipulate the hardware.
namespace HAL {
  // Various error code status that can be reported back to the root node.
  enum error_code : char { error_reset_during_pumping, dry_overflow };

#ifdef ENABLE_TEST
  using ostream = std::ostream;
  extern ostream& uart;
#else
  using ostream = xtd::ostream<xtd::uart_stream_tag>;
  extern ostream uart;
#endif
  using overflow_callback_t = void (*)(void);

  constexpr auto sense_period = 1_h;    // How frequently to sense the moisture
  constexpr auto use_watchdog = false;  // Whether or not the WDT should be used
  constexpr auto aref = 5_V;            // ADC reference voltage
  constexpr auto f_cpu = xtd::units::frequency<long long>(F_CPU);  // CPU frequency
  constexpr auto ntc_c = 100_nF;          // Nominal capacitance on NTC filter
  constexpr auto ntc_r_max = 100_kOhm;    // Max value of NTC in measurement range
  constexpr auto rc_c_max = 100_pF;       // Max design Cap. for RC timing net
  constexpr auto rc_f_max = f_cpu / 100;  // Max design Freq. for RC timing net
  constexpr auto rc_r = 100_kOhm;         // The resistance used in the RC timing circuit
  constexpr auto rc_counts = 1 << 8;      // How many RC cycles per measurement

  // An approximation of: 1/(2*log(2)) = 0.72135 ~= 1970/2731 as a ratio.
  using one_over_two_ln_two = xtd::ratio<1970, 2731>;

  // Type for counting time in CPU cycles. A value of 1 is 1/F_CPU seconds.
  using cycles = xtd::units::time<uint32_t, xtd::ratio_invert<SCALE(f_cpu)>>;

  // Type for converting a RC measurement into a capacitance value.
  // NB: F = 1 / (2*ln(2)*R*C), F = rc_counts/cycles => C = cycles / (2*ln(2)*R*rc_counts)
  using rc_capacitance = xtd::units::capacitance<
      int32_t, xtd::ratio_divide<one_over_two_ln_two, SCALE(rc_r* f_cpu* rc_counts)>>;

  // Type for measuring ADC voltage (left aligned).
  using adc_voltage =
      xtd::units::voltage<uint32_t, xtd::ratio_divide<SCALE(aref), xtd::ratio<1023UL * (1 << 6)>>>;

  // Type for measuring temperature in centi kelvin.
  using kelvin = xtd::units::temperature<int32_t, xtd::centi>;

  // Type for measuring moisture. Where: 0.0 is dry and 1.0 is submerged in water.
  using moisture = xtd::units::scale<int32_t, xtd::milli>;

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

  //
  // Static sanity checks on the types.
  //

  static_assert(kelvin(0x7FFFF) > 373_K, "kelvin type must be able to represent more than 100 C");
  static_assert(kelvin(0x80000) > 173_K, "kelvin type must be able to represent less than -100 C");
  static_assert(xtd::units::scale<long, one_over_two_ln_two>(1) <= rc_r * rc_c_max * rc_f_max,
                "RC net parameters incompatible! R too small or F_RC_max/C_RC_max too big!");
  static_assert(rc_capacitance(11_nF) > 10_nF,
                "rc_capacitance must be able to represent more than 10_nF");
  static_assert(rc_capacitance(100_fF) < 1_pF,
                "rc_capacitance must be able to represent less than 1_pF");
}  // namespace HAL

#undef SCALE
#endif
