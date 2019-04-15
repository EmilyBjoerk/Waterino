#ifndef GUARD_WATERINO_COMPUTE_HPP
#define GUARD_WATERINO_COMPUTE_HPP

#include "hardware.hpp"

// Compute a linearised temperature from a voltage drop over the NTC 
HAL::kelvin compute_temperature(HAL::adc_voltage raw);

// Compute the moisture level from a capacitance and temperature
HAL::moisture compute_moisture(HAL::kelvin temperature, HAL::rc_capacitance capacitance);

#endif
