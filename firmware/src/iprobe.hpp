#ifndef GUARD_WATERINO_IPROBE_HPP
#define GUARD_WATERINO_IPROBE_HPP

#include "xtd_uc/cstdint.hpp"

class IProbe {
public:
  using adc_value_type = uint16_t;
  
  virtual bool is_dry() const = 0;

  // Pre-condition: ADC is enabled and setup to use internal AVcc as VRef.
  virtual adc_value_type read() const = 0;

  virtual void print_stat() const = 0;
};

#endif
