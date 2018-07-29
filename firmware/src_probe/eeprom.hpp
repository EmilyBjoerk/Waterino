#ifndef GUARD_PROBE_PROBE_HPP
#define GUARD_PROBE_PROBE_HPP

#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/eeprom.hpp"

struct eeprom_layout {
  uint16_t threshold;
  uint8_t i2c_addr;

  uint8_t log_start;


  template <typename U>
  constexpr static auto* addr_of(U eeprom_layout::*a) {
    eeprom_layout x;
    using T = xtd::decay_t<decltype(x.*a)>;
    return reinterpret_cast<T*>((unsigned char*)(0) +
                                ((unsigned char*)(&(x.*a)) - (unsigned char*)(&x)));
  }
};

xtd::eeprom_small<uint16_t> e_probe_dry_threshold;
xtd::eeprom_small<uint8_t> e_i2c_addr;

#endif
