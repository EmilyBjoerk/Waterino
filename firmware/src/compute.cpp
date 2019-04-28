#include "compute.hpp"

HAL::kelvin compute_temperature(HAL::adc_voltage ntc_drop) {

  /*
     Octave:
m = 33897.0890130402; k = -0.158635382266597; kf=sscanf(rats(k), "%d/%d"); mf=sscanf(rats(m), "%d/%d"); cm = lcm(kf(2), mf(2)); a=mf(1)*cm/mf(2); b=kf(1)*cm/kf(2); printf("\nAs a fractional line:\ny = (a + b*x)/c\n\nauto a=%dL;\nauto b=%dL;\nauto c=%dL;\n", a, b, cm), a_bits = ceil(log(abs(a))/log(2)), b_bits = ceil(log(abs(b))/log(2)), cm_bits = ceil(log(abs(cm))/log(2)); printf("Max bits of result: %d\nMax intermediate bits: %d\n", a_bits-cm_bits, max(a_bits, 16 + b_bits)), printf("Range: [%f, %f] celsius.\n", (a+b*hex2dec("FFFF"))/cm/100-273.15, a/cm/100 - 273.15)

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
  auto ans = (a + b*ntc_drop.count())/c;
  return HAL::kelvin{static_cast<uint16_t>(ans)};
}

HAL::moisture compute_moisture(HAL::kelvin /*temperature*/, HAL::rc_capacitance c) {
  return HAL::moisture{(c - HAL::rc_c_free_air) / (HAL::rc_c_water - HAL::rc_c_free_air)};
}
