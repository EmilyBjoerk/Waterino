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
m = 33897.0890130402; k = -0.158635382266597; kf=sscanf(rats(k), "%d/%d");
mf=sscanf(rats(m),"%d/%d"); cm = lcm(kf(2), mf(2)); a=mf(1)*cm/mf(2); b=kf(1)*cm/kf(2); printf("\nAs
a fractional line:\ny = (a + b*x)/c\n\nauto a=%dL;\nauto b=%dL;\nauto c=%dL;\n", a, b, cm), a_bits =
ceil(log(abs(a))/log(2)), b_bits = ceil(log(abs(b))/log(2)), cm_bits = ceil(log(abs(cm))/log(2));
printf("Max bits of result: %d\nMax intermediate bits: %d\n", a_bits-cm_bits, max(a_bits, 16 +
b_bits)), printf("Range: [%f, %f] celsius.\n", (a+b*hex2dec("FFFF"))/cm/100-273.15, a/cm/100 -
273.15)

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
  // We have taken the formula for water's dielectric,
  // changed variable for celsius to centi-kelvin,
  // and performed a taylor expansion around 25C and took
  // only the first order terms:
  // (Papers and math is doc/ folder)
  //
  // T(dt) ~= (626426750-284587*dt)/8000000
  // dt = t - t0; t0 = 25C

  constexpr auto t0 = 2982L;  // (273.15K + 25K * 10)
  auto dt_cal = (*ee_t_water).count() - t0;
  auto dt = t.count() - t0;

  auto moisture_scale = 1000L;
  auto scale_nom = (626426750L - 284587L * dt_cal);
  auto scale_den = (626426750L - 284587L * dt);

  // T(t_cal)/T(t)
  return HAL::moisture{(moisture_scale * scale_nom * c / scale_den - *ee_c_air * moisture_scale) /
                       (*ee_c_water - *ee_c_air)};
}
