#ifndef GUARD_PROBE_PROTO_FSM_HPP
#define GUARD_PROBE_PROTO_FSM_HPP

#include "probe_defs.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/i2c.hpp"

namespace probe {

  class protocol_fsm {
  public:
    void on_rx(xtd::i2c_device& i2c);
    void on_tx(xtd::i2c_device& i2c);

    // Must be called periodically to perform actions not doable in on_*
    void run(xtd::i2c_device& i2c);

    bool can_sleep() const;

  private:
    uint8_t m_state = probe::cmd_none;
    uint8_t m_substate = 0;
    volatile bool m_do_read = false;

    union {
      probe::msg_read_probe m_probe_read;
      probe::msg_threshold m_thresh;

      uint8_t m_raw[xtd::max(sizeof(m_probe_read), sizeof(m_thresh))];
    };

    void reset(xtd::i2c_device& i2c);
    void next_state(bool done);
    bool is_dry() const;
  };

}  // namespace probe

#endif
