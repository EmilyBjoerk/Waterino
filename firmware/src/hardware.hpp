#ifndef GUARD_WATERINO_HARDWARE_HPP
#define GUARD_WATERINO_HARDWARE_HPP

#include "xtd_uc/avr.hpp"
#include "xtd_uc/chrono.hpp"
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
  enum error_code : char { error_reset_during_pumping, dry_overflow, adc_in_use };

#ifdef ENABLE_TEST
  using ostream = std::ostream;
  extern ostream& uart;
#else
  using ostream = xtd::ostream<xtd::uart_stream_tag>;
  extern ostream uart;
#endif
  using overflow_callback_t = void (*)(void);

  constexpr auto sense_period = 1_h;   // How frequently to sense the moisture
  constexpr auto use_watchdog = true;  // Whether or not the WDT should be used
  constexpr auto aref = 5_V;           // ADC reference voltage
  constexpr auto f_cpu = xtd::units::frequency<long long>(F_CPU);  // CPU frequency
  constexpr auto ntc_c = 100_nF;               // Nominal capacitance on NTC filter
  constexpr auto ntc_r_max = 100_kOhm;         // Max value of NTC in measurement range
  constexpr auto rc_c_max = 500_pF;            // Max design Cap. for RC timing net
  constexpr auto rc_f_max = f_cpu / 100;       // Max design Freq. for RC timing net
  constexpr auto rc_r = 100_kOhm;              // The resistance used in the RC timing circuit
  constexpr auto rc_counts = 1 << 15;          // How many RC cycles per measurement
  constexpr auto max_overflow_delay = 10_min;  // How long after pumping to stop overflow sens

  // An approximation of: 1/(2*log(2)) = 0.72135 ~= 1970/2731 as a ratio.
  using one_over_two_ln_two = xtd::ratio<1970, 2731>;

  // Type for counting time in CPU cycles. A value of 1 is 1/F_CPU seconds.
  using cycles = xtd::units::time<int32_t, xtd::ratio_invert<SCALE(f_cpu)>>;

  // Type for converting a RC measurement into a capacitance value.
  // NB: Frc = 1 / (2*ln(2)*R*C) <=> C = 1 / (2*ln(2)*R*Frc)
  // Frc = rc_counts / s, Fclock = clock_counts / s =>
  // clock_counts / Fclock = rc_counts / Frc <=> Frc = rc_counts * Fclock / clock_counts
  // => C = clock_counts / (2*ln(2)*R*rc_counts*Fclock).
  // NB2: Fclock is 1 / xtd::chrono::steady_clock::scale.
  // => C = clock_counts * xtd::chrono::steady_clock::scale / (2*ln(2)*R*rc_counts).
  using rc_capacitance = xtd::units::capacitance<
      int32_t, xtd::ratio_multiply<
                   xtd::ratio_divide<xtd::chrono::steady_clock::scale, SCALE(rc_r* rc_counts)>,
                   one_over_two_ln_two>>;

  // Type for measuring ADC voltage.
  using adc_voltage =
      xtd::units::voltage<uint16_t, xtd::ratio_divide<SCALE(aref), xtd::ratio<1023UL>>>;

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
  void fatal(error_code code);

  // Senses the capacitance over the probes co-planar capacitor
  // Returns our best estimate of the true capacitance.
  //
  // NOTE: May not be called while sensing NTC drop or when overflow detection is active
  rc_capacitance sense_capacitance();

  // Senses the temperature at the NTC temperature sensor.
  // Returns a raw reading from the ADC, it may be filtered for noise.
  //
  // NOTE: May not be called while the sensing capacitance or when the overflow detection is active
  adc_voltage sense_ntc_drop();

  // Senses the voltage drop across the overflow electrodes.
  // A drop of Aref V indicates disconnection and a drop of 0 V indicates a shortcircuit.
  // Typically we expect around 3/4*Aref during a short circuit.
  //
  // NOTE: May not be called while sensing ntc or capacitance or while the overflow detection is
  // active
  bool sense_overflow();

  // Connects the overflow sensor to analog comparator IRQ.
  // When the overflow sensor detects water, the ANALOG_COMP_vect ISR will run.
  //
  // NOTE: May not be enabled while sensing the NTC drop or capacitance
  void sense_overflow_enable_irq(overflow_callback_t cb);

  // Checks whether we're currently sensing for overflow.
  bool sense_overflow_enabled();

  // Disable the overflow sensor ISR.
  void sense_overflow_disable_irq();

  // Will put the MCU into a low power state that wakes on any IRQ.
  // Returns after such an IRQ has been received. Note, this could also
  // be an overflow from the system clock timer meaning that the amount
  // of time this will sleep is bunded by the system clock timer wrap-around.
  void sleep_until_irq();

  //
  // Static sanity checks on the types.
  //
  static_assert(kelvin(xtd::numeric_limits<kelvin::value_type>::max()) > 373_K,
                "kelvin type must be able to represent more than 100 C");
  static_assert(kelvin(xtd::numeric_limits<kelvin::value_type>::min()) < 173_K,
                "kelvin type must be able to represent less than -100 C");
  static_assert(xtd::units::scale<int32_t, one_over_two_ln_two>(1) <= rc_r * rc_c_max * rc_f_max,
                "RC net parameters incompatible! R too small or F_RC_max/C_RC_max too big!");
  static_assert(rc_capacitance(xtd::numeric_limits<rc_capacitance::value_type>::max()) > 10_nF,
                "rc_capacitance must be able to represent more than 10_nF");
  static_assert(rc_capacitance(1) < 50_fF,
                "rc_capacitance must be able to represent less than 10_fF");
}  // namespace HAL

#undef SCALE
#endif
