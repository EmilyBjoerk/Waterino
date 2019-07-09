#include "compute.hpp"

#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/units.hpp"

using namespace xtd::unit_literals;

xtd::eemem<HAL::kelvin> EEMEM ee_t_water{273_K + 25_K};
xtd::eemem<HAL::rc_capacitance> EEMEM ee_c_water{300_pF};
xtd::eemem<HAL::rc_capacitance> EEMEM ee_c_air{10_pF};

void set_cal_point_water(HAL::kelvin k, HAL::rc_capacitance c) {
  ee_t_water = k;
  ee_c_water = c;
}

void set_cal_point_air(HAL::rc_capacitance c) { ee_c_air = c; }

HAL::kelvin compute_temperature(HAL::adc_voltage ntc_drop) {
  /*
     Octave:
m = 33897.0890130402;
k = -0.158635382266597;
kf=sscanf(rats(k), "%d/%d");
mf=sscanf(rats(m),"%d/%d");
cm = lcm(kf(2), mf(2));
a=mf(1)*cm/mf(2);
b=kf(1)*cm/kf(2);

printf("\nAs a line:\ny = (a + b*x)/c\n\nauto a=%dL;\nauto b=%dL;\nauto c=%dL;\n", a, b, cm);

a_bits = ceil(log(abs(a))/log(2));
b_bits = ceil(log(abs(b))/log(2));
cm_bits = ceil(log(abs(cm))/log(2));

printf("Result Bits: %d\Intermediate bits: %d\n", a_bits-cm_bits, max(a_bits, 16 + b_bits));

printf("Range: [%f, %f] celsius.\n", (a+b*hex2dec("FFFF"))/cm/100-273.15, a/cm/100 -273.15);

As a fractional line:
y = (a + b*x)/c

auto a=874375460L;
auto b=-4092L;
auto c=25795L;
a_bits =  30
b_bits =  12
Max bits of result: 15
Max intermediate bits: 30
Range: [-38.140797, 65.820909] celsius.
  */

  auto a = 874375460L;
  auto b = -4092L;
  auto c = 25795L;
  auto ans = (a + b * ntc_drop.count()) / c;
  return HAL::kelvin{static_cast<uint16_t>(ans)};
}

HAL::moisture compute_moisture(HAL::kelvin t, HAL::rc_capacitance c) {
  // NB. Papers and proof in the 'doc/' folder.
  //
  // We have taken the formula for water's dielectric,
  // changed variable for celsius to centi-kelvin,
  // and performed a taylor expansion around 25C and took
  // only the first order terms:
  //
  // T(dt) ~= 5*(94188412 - 4279*t)/6014329
  // dt = t - t0; t0 = 25C
  //
  // Note: Water's dielectric coefficent drops with temperature.
  // So if at a lower temperature we still measure the same
  // capacitance, that means the water mass must have increased.

  constexpr auto t0 = HAL::kelvin(273150_mK + 25_K);
  auto dt_cal = (ee_t_water.get() - t0).count();
  auto dt = (t - t0).count();

  auto moisture_scale_num = HAL::moisture::scale::den;  // To not truncate the result we must
  auto moisture_scale_den = HAL::moisture::scale::num;  // apply the same scale as the end result.
  auto scale_nom = (94188412L - 4279L * dt_cal);  // Constant factors cancel out in the division
  auto scale_den = (94188412L - 4279L * dt);      // no need to include them and risk overflow.

  // T(t_cal)/T(t)
  auto part = moisture_scale_num * scale_nom * c / scale_den - ee_c_air.get() * moisture_scale_num;
  auto range = (ee_c_water.get() - ee_c_air.get()) * moisture_scale_den;
  auto ans = HAL::moisture{static_cast<HAL::moisture::value_type>((part / range).count())};
  return ans;
}
