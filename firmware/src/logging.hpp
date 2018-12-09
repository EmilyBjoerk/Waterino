#ifndef GUARD_WATERINO_LOGGING_HPP
#define GUARD_WATERINO_LOGGING_HPP

#include "config.hpp"
#include "xtd_uc/chrono.hpp"

void log_measurement(moisture, kelvin, rc_capacitance, adc_voltage, cycles);

void log_activation(xtd::chrono::steady_clock::duration, xtd::chrono::steady_clock::time_point);

#endif
