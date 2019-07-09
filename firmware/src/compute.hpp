#ifndef GUARD_WATERINO_COMPUTE_HPP
#define GUARD_WATERINO_COMPUTE_HPP

#include "hardware.hpp"

// Sets the calibration point for water, also requires temperature to remove temperature
// dependency from measurements.
void set_cal_point_water(HAL::kelvin, HAL::rc_capacitance);

// Sets the calibration point for free air (dry).
void set_cal_point_air(HAL::rc_capacitance);

// Compute a linearised temperature from a voltage drop over the NTC 
HAL::kelvin compute_temperature(HAL::adc_voltage raw);

// Compute the moisture level from a capacitance and temperature
HAL::moisture compute_moisture(HAL::kelvin temperature, HAL::rc_capacitance capacitance);

#endif
