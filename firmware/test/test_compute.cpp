#include "../src/compute.hpp"

#include "util.hpp"
#include "xtd_uc/eeprom.hpp"

extern xtd::eemem<HAL::kelvin> ee_t_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_air;

// Test that the temperature computed is monotonic with the ADC voltage
// The temperature increases with lower resistance or voltage over the NTC.
TEST(TestCompute, TemperatureMonotonicity) {
  HAL::adc_voltage curr_voltage = 0_V;
  HAL::kelvin prev_temperature = compute_temperature(curr_voltage);

  while (curr_voltage < HAL::aref) {
    curr_voltage = HAL::adc_voltage(curr_voltage.count() + 1);
    auto new_temperature = compute_temperature(curr_voltage);
    ASSERT_GE(prev_temperature, new_temperature);
  }
}

// Test that the temperature computed spans a large enough range
TEST(TestCompute, TemperatureRange) {
  auto min = compute_temperature(HAL::aref);  // It's NTC, min temperature at max voltage
  auto max = compute_temperature(0_V);
  EXPECT_LE(min, 273_K);  // ~0 C
  EXPECT_LE(333_K, max);  // ~60 C
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
  ASSERT_LE(max_step, HAL::kelvin(10));
}

// Test that the set calibration points evaluate to their defined moisture values.
TEST(TestCompute, MoistureSetCalPoints) {
  constexpr auto cal_temp = 273150_mK + 25_K;  // 25 C
  constexpr auto cal_air = 10_pF;
  constexpr auto cal_water = 300_pF;
  set_cal_point_air(cal_air);
  set_cal_point_water(cal_temp, cal_water);

  constexpr auto c_store_error = 50_fF;
  
  EXPECT_TRUE(IsBetweenInclusive(ee_t_water.get(), cal_temp - 10_mK, cal_temp + 10_mK));
  EXPECT_TRUE(IsBetweenInclusive(ee_c_water.get(), cal_water - c_store_error, cal_water + c_store_error));
  EXPECT_TRUE(IsBetweenInclusive(ee_c_air.get(), cal_air - c_store_error, cal_air + c_store_error));
}

// Test that the set calibration points evaluate to their defined moisture values.
TEST(TestCompute, MoistureCalPointIdentites) {
  constexpr auto cal_temp = 273150_mK + 30_K;  // 30 C
  constexpr auto cal_air = 10_pF;
  constexpr auto cal_water = 300_pF;
  set_cal_point_air(cal_air);
  set_cal_point_water(cal_temp, cal_water);

  ASSERT_EQ(HAL::moisture(0_ppt), compute_moisture(cal_temp, cal_air));
  ASSERT_EQ(HAL::moisture(1000_ppt), compute_moisture(cal_temp, cal_water));
}

TEST(TestCompute, MoistureExtremesNoOverflow) {
  set_cal_point_air(10_pF);
  set_cal_point_water(300_K, HAL::rc_c_max);

  ASSERT_LT(compute_moisture(273_K, HAL::rc_c_max), compute_moisture(300_K, HAL::rc_c_max));
  ASSERT_GT(compute_moisture(373_K, 10_pF), compute_moisture(300_K, 10_pF));
}

// Test that the moisture increases monotonically with increased capacitance.
// If compiled with clang, ubsan will report on signed overflows.
TEST(TestCompute, MoistureCapacitanceResolution) {
  set_cal_point_air(10_pF);
  set_cal_point_water(300_K, HAL::rc_c_max);

  auto c = HAL::rc_capacitance{0};
  auto max_step = HAL::moisture(0);
  auto prev_value = compute_moisture(300_K, c);

  do {
    c++;
    auto curr_value = compute_moisture(300_K, c);
    max_step = max(max_step, HAL::moisture(curr_value - prev_value));

    ASSERT_GE(curr_value, prev_value) << "Monotonicity violated!";
    prev_value = curr_value;
  } while (c.count() < ee_c_water.get().count() * 2);

  ASSERT_LE(max_step, 1000_ppm);
}

// Test that the moisture increases monotonically with increased temperature over 0-50 C.
// If compiled with clang, ubsan will report on signed overflows.
//
// Note:
// The capacitance is the same, but temperature has increased. As temperature increases
// the dielectric drops, meaning that for the capacitance to stay the same, the
// moisture must have increased.
TEST(TestCompute, MoistureTemperatureResolution) {
  set_cal_point_air(10_pF);
  set_cal_point_water(300_K, 100_pF);

  auto t = HAL::kelvin{273_K};
  auto prev_value = compute_moisture(t, 50_pF);
  auto max_step = HAL::moisture{0};
  do {
    t++;
    auto curr_value = compute_moisture(t, 50_pF);
    max_step = max(max_step, HAL::moisture(curr_value - prev_value));

    ASSERT_GE(curr_value, prev_value) << "Monotonicity violated!";
    prev_value = curr_value;
  } while (t < 353_K);  // 80 C

  ASSERT_LE(max_step, 1000_ppm);
}
