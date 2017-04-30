#ifndef GUARD_XTD_SFR_HPP
#define GUARD_XTD_SFR_HPP

#include <stdint.h>

namespace avr {
  inline void set_bit(volatile uint8_t& sfr, int bit) {
    sfr = static_cast<uint8_t>(sfr | (1 << bit));
  }

  inline void clr_bit(volatile uint8_t& sfr, int bit) {
    sfr = static_cast<uint8_t>(sfr & ~(1 << bit));
  }
}
#endif
