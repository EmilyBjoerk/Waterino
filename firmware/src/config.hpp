#ifndef GUARD_WATERINO_CONFIG_HPP
#define GUARD_WATERINO_CONFIG_HPP
/*
 This file contains hardware related constants and functions.

 It must be compilable on the host platform.

 -------------------------------------------------------------------------------
   Measuring capacitance
 -------------------------------------------------------------------------------
 We have an RC net where R is known and we're measuring C. The output of the RC net
 is passed to an analog comparator together with RC_REF = K*Vcc. We measure the time
 it takes charge C to RC_REF, and the comparator switches which raises an IRQ and
 ends the measurement.

 The time it takes to charge C to RC_REF is: t = -R*C*ln(1-K) or conversely if we
 measure t seconds, we determine C as:

    C = -t/(R*ln(1-K)).

 Let Z = -1/ln(1-K), then we get:

    C = t*Z/R

 By using undivided timers on the MCU we get t = cycles/F_CPU. And thus we get:

    C = cycles*Z/(F_CPU*R)

 and the precision of the measurement is determined by the CPU clock perion, 1/F_CPU:

    dC = Z/(F_CPU*R).

 The range of values we can measure is thus [dC, dC*2^n] where n is the number of bits
 in the timer we use to measure t.

 We pick K=0.75, which gives:

    Z = 1/ln(4) ~= 0.721347520444482 ~= 1970/2731 = 0.721347491761260

 Assume R=1M and F=8 MHz (internal RC osc.) then dC ~= 90 fF. And pick 24 bits for the counter
 (16 overflow software counter and 8 for hardware), we get a range of C in [90pF, 1.5 µF].

 Preliminary tests of the probe geometry indicate a range of [0.5nF, 2.2nF] is appropriate.

 -------------------------------------------------------------------------------
   Measuring temperature
 -------------------------------------------------------------------------------

*/

#include "xtd_uc/chrono_noclock.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/limits.hpp"
#include "xtd_uc/ratio.hpp"
#include "xtd_uc/type_traits.hpp"
#include "xtd_uc/units.hpp"
#define make_scale(X) decltype(xtd::units::make_unity_valued<(X).count()>((X)))::scale

using namespace xtd::unit_literals;
using xtd::chrono_literals::operator""_h;

constexpr auto c_use_watchdog = false;
constexpr auto c_aref = 5_V;
constexpr auto c_rc_r = 100_kOhm;
constexpr auto c_rc_c_max = 1_uF;
constexpr auto c_f_cpu = 16_MHz;

constexpr auto c_ntc_c = 100_nF;
constexpr auto c_ntc_r_max = 100_kOhm;

constexpr auto c_sense_period = 1_h;

//
// Compute scale factors appropriate for the quantities below
//

using f_cpu_scale = make_scale(c_f_cpu);
using adc_volt_scale = xtd::ratio_divide<make_scale(c_aref), xtd::ratio<1023UL * (1 << 6)>>;
using rc_r_scale = make_scale(c_rc_r);
using rc_z_scale = xtd::ratio<1970, 2731>;  // Approximation of Z (above) for K=0.75
using rc_c_scale = xtd::ratio_divide<rc_z_scale, xtd::ratio_multiply<f_cpu_scale, rc_r_scale>>;

// Capacitance quantity with scale appropriate for conversion factor so that
// the number of clock cycles needed to charge the RC net can be directly
// taken as the count() for this type to get the capacitance.
using rc_capacitance = xtd::units::capacitance<uint32_t, rc_c_scale>;

// Voltage quantity with scale such that the left aligned ADC output converts
// directly to counts of the quantity to get the correct voltage.
using adc_voltage = xtd::units::voltage<uint32_t, adc_volt_scale>;

// Quantity of time which maps cpu cycles to time.
using cycles = xtd::units::time<uint32_t, xtd::ratio_divide<xtd::ratio<1>, f_cpu_scale>>;

// Measured time it takes to charge the RC net with C disconnected, compensates for software
// overhead when starting and stopping the timer as well as gate capacitance on the analog
// comparator and on board parasitics.
constexpr cycles c_rc_time_offset = cycles(132);
constexpr cycles c_time_error = cycles(0xFFFFFFFF);

//
using kelvin = xtd::units::temperature<uint16_t, xtd::centi>;

using moisture = xtd::units::scale<uint16_t, xtd::centi>;

#undef make_type
#endif
