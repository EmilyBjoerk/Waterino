#ifndef GUARD_WATERINO_EEPROM_HPP
#define GUARD_WATERINO_EEPROM_HPP

#include "xtd_uc/chrono.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/limits.hpp"

#include "config.hpp"

template <typename T, uint16_t addr>
void ee_count_up(xtd::eeprom_small<T, addr>& x) {
  if (*x < xtd::numeric_limits<T>::max()) {
    x = *x + 1;
  }
}

struct eeprom_layout {
  constexpr eeprom_layout() {}

  uint8_t ee_osccal = 0;
  bool ee_pump_active = false;
  uint8_t ee_wdt_resets = 0;
  uint8_t ee_bod_resets = 0;
  uint8_t ee_power_cycles = 0;
  uint8_t ee_pump_resets = 0;

  float ee_pump_pid_kp = 0;
  float ee_pump_pid_ki = 0;
  float ee_pump_pid_si = 0;

  moisture ee_dry_threshold = 0;
  xtd::chrono::steady_clock::duration ee_max_pump_duration = 0;
  xtd::chrono::steady_clock::duration ee_last_pump_duration = 0;
};

template <typename U>
constexpr static uint16_t ee_addr_of(U eeprom_layout::*a) {
  constexpr eeprom_layout x;
  return reinterpret_cast<uint16_t>((unsigned char*)(0) +
                                    ((unsigned char*)(&(x.*a)) - (unsigned char*)(&x)));
}

#define EE(TYPE, NAME) xtd::eeprom_small<TYPE, ee_addr_of(&eeprom_layout::NAME)> NAME

EE(uint8_t, ee_osccal);
EE(bool, ee_pump_active);
EE(uint8_t, ee_wdt_resets);
EE(uint8_t, ee_bod_resets);
EE(uint8_t, ee_power_cycles);
EE(uint8_t, ee_pump_resets);

EE(float, ee_pump_pid_kp);
EE(float, ee_pump_pid_ki);
EE(float, ee_pump_pid_si);

EE(moisture, ee_dry_threshold);
EE(xtd::chrono::steady_clock::duration, ee_max_pump_duration);
EE(xtd::chrono::steady_clock::duration, ee_last_pump_duration);

#undef EE

#endif
