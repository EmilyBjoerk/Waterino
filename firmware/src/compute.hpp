#ifndef GUARD_WATERINO_COMPUTE_HPP
#define GUARD_WATERINO_COMPUTE_HPP

#include "config.hpp"

// Compute a linearised temperature from a voltage drop over the NTC 
kelvin compute_temperature(adc_voltage raw);

// Compute the moisture level from a capacitance and temperature
moisture compute_moisture(kelvin temperature, rc_capacitance capacitance);

#endif
