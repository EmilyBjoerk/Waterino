#include "compute.hpp"

#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/units.hpp"

using namespace xtd::unit_literals;

constexpr HAL::kelvin c_25_celsius = 298150_mK;
xtd::eemem<HAL::kelvin> EEMEM ee_t_water{c_25_celsius};
xtd::eemem<HAL::rc_capacitance> EEMEM ee_c_water{300_pF};
xtd::eemem<HAL::rc_capacitance> EEMEM ee_c_air{10_pF};

void set_cal_point_water(HAL::kelvin k, HAL::rc_capacitance c) {
  ee_t_water = k;
  ee_c_water = c;
}

void set_cal_point_air(HAL::rc_capacitance c) { ee_c_air = c; }

HAL::kelvin compute_temperature(HAL::adc_voltage ntc_drop) {
  /*
   NTC:
   10k Ohm @ 25.0 C
   25/50C: B = 4067 Kelvin
   Imax = 0.31 mA

   Resistor divider with 10k resistor on top, Imax bounded by top resistor: <= 5/10k = 0.5mA.

   R(NTC) = R(T0)*e^(B*(1/T - 1/T0))
   V(NTC) = V(ref) * R(NTC) / (R(NTC) + R(top))
   -->
   R(T0)*e^(B*(1/T - 1/T0)) = V(NTC)*R(top)/(V(ref) - V(NTC))
   T = 1/(ln(V(NTC)*R(top)/((V(ref) - V(NTC))* R(T0)))/B + 1/T0)

   Pick: T0 = 25 C, V(ref) = 5V
   Then: R(T0) = 10k Ohm

   We do a taylor series expansion around T=25C (273.15 + 25 = 298.15 K),
   where V(NTC) = 0.5*V(ref) due to the divider. In the below let: V(NTC) = V.

   f(V) = T0 + T'(V(ref)/2)*(V-V(ref)/2)

   T'(V) = (1/(V*R(top)) + 1/((V(ref) - V)* R(T0))) /
           (B*(ln(V*R(top)/((V(ref) - V)* R(T0)))/B + 1/T0)^2)

   Let: R(top) = R(T0) and then:
   T'(V(ref)/2) = -4*T0^2/(B*V(ref))

   [Note: B has unit K, so the above has K/V unit and when multiplied by V in the
    taylor expansion will have the correct unit]

   f(V) = T0 - T0^2*(4*V-10)/(B*5) = T0*(1 + T0/(B*5)*(10-4*V))
        = 29815/100*(1 + 29815/100*(10-4*V)/(5*4069))
        = 29815/100*(1 + 5963/100*(10-4*V)/4069)

   In centidegrees kelvin:
   f(V) = 29815*(1 + 5963*(10-4*V)/406900)

   406900 = 2 x 2 x 5 x 5 x 13 x 313
   29815 = 5 x 67 x 89

   f(V) = 29815 + 5963^2*(10-4*V)/81380

   Convert V from [0,5V] to [0,1023], Vx = 1023*V/5, Vx*5/1023 = V
   f(Vx) = 29815 + 5963^2*(1023 - 2*Vx)/(8138*1023)

   "Round" 1023 to 1024 to be able to simplify a bit more:
   f(Vx) = 29815 + 5963^2*(512 - Vx)/(8138*512)

  */

  auto count = ntc_drop.count();
  auto ans = 29815L + 5963L * 5963L * (512L - count) / (8138L * 512L);
  return HAL::kelvin{static_cast<HAL::kelvin::value_type>(ans)};
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

  auto dt_cal = (ee_t_water.get() - c_25_celsius).count();
  auto dt = (t - c_25_celsius).count();

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
