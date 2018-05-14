#ifndef GUARD_WATERINO_EEPROM_LAYOUT_HPP
#define GUARD_WATERINO_EEPROM_LAYOUT_HPP

#include <stdint.h>

#include "controller.hpp"
#include "pump.hpp"

struct eeprom_layout {
  eeprom_layout() = default;

  float pid_kp = 0.0f;
  float pid_ki = 0.0f;
  float pid_si = 0.0f;
  Pump::duration pump_max_duration;
  Controller::duration pid_target_period;
  bool pump_active = 0;
  uint32_t start_of_log = 0;

  template <typename U>
  constexpr static auto* addr_of(U eeprom_layout::*a) {
    eeprom_layout x;
    using T = xtd::decay_t<decltype(x.*a)>;
    return reinterpret_cast<T*>((unsigned char*)(0) +
                                ((unsigned char*)(&(x.*a)) - (unsigned char*)(&x)));
  }
};

#endif
