#include "compute.hpp"

HAL::kelvin compute_temperature(HAL::adc_voltage /*raw*/) { return {}; }

HAL::moisture compute_moisture(HAL::kelvin /*temperature*/, HAL::rc_capacitance c) {
  return HAL::moisture{c / HAL::rc_c_water};
}
