#ifndef GUARD_PROBE_PROBE_DEFS_HPP
#define GUARD_PROBE_PROBE_DEFS_HPP

#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/limits.hpp"
#include "xtd_uc/units.hpp"

namespace probe {
  // Centidegrees Kelvin [0, 2^16-1] = [0, 655.35] K
  using temperature = xtd::units::quantity<uint16_t, xtd::units::kelvin, xtd::ratio<1, 100>>;

  // The command uses the high nibble so that the low bits can be used by the implementing FSM.
  enum command : char {
    cmd_none = 0,
    // Read command.
    // Returns {struct msg_read_probe : Read result }
    cmd_read_probe = (1 << 4),

    // Write command.
    // Arguments {struct msg_threshold : Threshold }
    cmd_set_threshold = (3 << 4),

    // Read command.
    // Returns {struct msg_threshold : Threshold }
    cmd_get_threshold = (4 << 4),

    // Read command.
    // Returns {msg_probe_dry/msg_probe_wet (uint8_t) : Dry or not }
    cmd_is_dry = (5 << 4),

    // Read command.
    // Returns N x {???
    //              uint8_t  : Checksum }
    cmd_read_log = (6 << 4)
  };

  // Mask applied to received commands to allow using low nibble for state
  constexpr uint8_t cmd_mask = 0xF0;

  // Response sent when a protocol error ocurrs
  constexpr uint8_t msg_error = 0xFF;

  constexpr uint8_t msg_probe_dry = 0xF0;
  constexpr uint8_t msg_probe_wet = 0x0F;

  // Computes 8 bit checksum of provided data
  uint8_t msg_checksum(const uint8_t* data, uint8_t len);

  struct msg_read_probe {
    constexpr static temperature temp_lo = temperature(xtd::numeric_limits<uint16_t>::min());
    constexpr static temperature temp_hi = temperature(xtd::numeric_limits<uint16_t>::max());

    msg_read_probe() = default;
    msg_read_probe(uint16_t m, temperature t, uint16_t n, uint16_t s)
        : moisture(m), temp(t), ntc_vdrop(n), soil_vdrop(s) {
      checksum = chk();
    }

    bool is_valid() const { return checksum == chk(); }

    uint16_t moisture;  // Undefined unit, relevant only in relation threshold set
    temperature temp;
    uint16_t ntc_vdrop;   // 1024 = Vcc drop, 0 = 0V drop
    uint16_t soil_vdrop;  // 1024 = Vcc drop, 0 = 0V drop

    uint8_t checksum;

  private:
    uint8_t chk() const {
      return msg_checksum(reinterpret_cast<const uint8_t*>(this), sizeof(*this) - 1);
    }
  };

  struct msg_threshold {
    msg_threshold() = default;
    msg_threshold(uint16_t t) : thresh(t) { checksum = chk(); }
    
    bool is_valid() const { return checksum == chk(); }

    uint16_t thresh;
    uint8_t checksum;

  private:
    uint8_t chk() const {
      return msg_checksum(reinterpret_cast<const uint8_t*>(this), sizeof(*this) - 1);
    }
  };

}  // namespace probe

#endif
