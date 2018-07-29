#ifndef GUARD_PROBE_PROBE_DEFS_HPP
#define GUARD_PROBE_PROBE_DEFS_HPP

#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/limits.hpp"
#include "xtd_uc/units.hpp"

namespace probe {
  // Centidegrees Kelvin [0, 2^16-1] = [0, 655.35] K
  using temperature = xtd::units::quantity<uint16_t, xtd::units::kelvin, xtd::ratio<1, 100>>;

  enum command : uint8_t {
    // Read command.
    // Returns {struct read_result : Read result,
    //          uint8_t  : Checksum }
    cmd_read_probe = (1 << 0),

    // Read command.
    // Returns {struct full_read_result : Full read result,
    //          uint8_t  : Checksum }
    cmd_full_read_probe = (1 << 1),

    // Write command.
    // Arguments {uint16_t : Moisture (TBD)
    //            uint8_t  : Checksum }
    cmd_set_threshold = (1 << 2),

    // Read command.
    // Returns {uint16_t : Moisture (TBD)
    //          uint8_t  : Checksum }
    cmd_get_threshold = (1 << 3),

    // Read command.
    // Returns {uint8_t : True/False
    //          uint8_t  : Checksum }
    cmd_is_dry = (1 << 4),

    // Read command.
    // Returns N x {???
    //              uint8_t  : Checksum }
    cmd_read_log = (1 << 5)
  };

  class checksum {
  public:
    void feed(uint8_t v) { s = (s ^ v); }
    uint8_t get() const { return s; }

  private:
    uint8_t s = 0;
  };

  struct full_read_result {
    constexpr static temperature error_low_temp = temperature(xtd::numeric_limits<uint16_t>::min());
    constexpr static temperature error_high_temp =
        temperature(xtd::numeric_limits<uint16_t>::max());

    full_read_result(uint16_t m, temperature t, uint16_t n, uint16_t s)
      : moisture(m), temp(t), ntc_vdrop(n), soil_vdrop(s) {}

    uint16_t moisture;  // Undefined unit, relevant only in relation threshold set
    temperature temp;
    uint16_t ntc_vdrop;   // 1024 = Vcc drop, 0 = 0V drop
    uint16_t soil_vdrop;  // 1024 = Vcc drop, 0 = 0V drop
  };

}  // namespace probe

#endif
