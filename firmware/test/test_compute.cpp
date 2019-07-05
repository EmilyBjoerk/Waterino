#include "../src/compute.hpp"

#include "util.hpp"
#include "xtd_uc/eeprom.hpp"

extern xtd::eemem<HAL::kelvin> ee_t_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_air;

// Test that the temperature computed is monotonic with the ADC voltage
// The temperature increases with lower resistance or voltage over the NTC.
TEST(TestCompute, TemperatureMonotonic) {
  HAL::adc_voltage curr_voltage = 0_V;
  HAL::kelvin prev_temperature = compute_temperature(curr_voltage);

  while (curr_voltage.count() < 0xFFFF) {
    curr_voltage = HAL::adc_voltage(curr_voltage.count() + 1);
    auto new_temperature = compute_temperature(curr_voltage);

    ASSERT_GE(prev_temperature, new_temperature);
  }
}

// Test that the temperature computed spans a large enough range
TEST(TestCompute, TemperatureRange) {
  auto min = compute_temperature(HAL::aref);  // It's NTC, min temperature at max voltage
  auto max = compute_temperature(0_V);
  ASSERT_LE(min, 273_K);  // ~0 C
  ASSERT_LE(333_K, max);  // ~60 C
}

// Test that the temperature computed doesn't suffer from quantization problems.
TEST(TestCompute, TemperatureResolution) {
  HAL::adc_voltage curr_voltage = 0_V;
  HAL::kelvin prev_temperature = compute_temperature(curr_voltage);
  HAL::kelvin max_step = 0_K;

  while (curr_voltage.count() < 0xFFFF) {
    curr_voltage = HAL::adc_voltage(curr_voltage.count() + 1);
    auto new_temperature = compute_temperature(curr_voltage);
    auto step = prev_temperature - new_temperature;
    prev_temperature = new_temperature;

    if (step > max_step) {
      max_step = step;
    }
  }

  ASSERT_LE(max_step, HAL::kelvin(1));
}

TEST(TestCompute, MoistureCalPointIdentites) {
  constexpr auto cal_temp = 273_K + 25_K;
  constexpr auto cal_air = 10_pF;
  constexpr auto cal_water = 300_pF;
  set_cal_point_air(cal_air);
  set_cal_point_water(cal_temp, cal_water);

  ASSERT_EQ(cal_temp, ee_t_water.get());
  ASSERT_EQ(cal_water, ee_c_water.get());
  ASSERT_EQ(cal_air, ee_c_air.get());

  ASSERT_EQ(HAL::moisture(0_ppt), compute_moisture(cal_temp, cal_air));
  ASSERT_EQ(HAL::moisture(1000_ppt), compute_moisture(cal_temp, cal_water));
}
