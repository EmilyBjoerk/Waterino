#include "probe_defs.hpp"

namespace probe {
  uint8_t msg_checksum(const uint8_t* data, uint8_t len) {
    uint8_t x = 0b10101010;
    for (uint8_t i = 0; i < len; ++i) {
      x ^= data[i];
      x = (x << 1) | ((x & 0x80) >> 7);
    }
    return x;
  }
}  // namespace probe
