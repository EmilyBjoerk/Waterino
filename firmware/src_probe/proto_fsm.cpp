#include "proto_fsm.hpp"
#include "probe.hpp"

xtd::eeprom_small<uint16_t, 1> eeprom_threshold;

namespace probe {

  void protocol_fsm::reset(xtd::i2c_device& i2c) {
    i2c.slave_ack(xtd::i2c_nack);
    // Below guatantees that a spurious read will respond with error and not go out of bounds
    m_state = probe::cmd_none;
    m_raw[0] = probe::msg_error;
    m_tx_bytes = 0;
  }

  bool protocol_fsm::is_dry() const { return m_probe_read.moisture < *eeprom_threshold; }

  void protocol_fsm::on_rx(xtd::i2c_device& i2c) {
    switch (m_state) {
      case probe::cmd_none:
        m_state = i2c.slave_receive_raw();

        switch (m_state) {
          case probe::cmd_read_probe:
            m_do_read = true;  // Ack after the read
            m_tx_bytes = sizeof(m_probe_read) - 1;
            break;
          case probe::cmd_is_dry:
            m_do_read = true;  // Ack after the read
            m_tx_bytes = sizeof(m_is_dry) - 1;
            break;
          case probe::cmd_get_threshold:
            i2c.slave_ack(xtd::i2c_nack);
            m_tx_bytes = sizeof(m_thresh) - 1;
            m_thresh = *eeprom_threshold;
            break;
          case probe::cmd_set_threshold:
            i2c.slave_ack(xtd::i2c_ack);
            m_tx_bytes = sizeof(m_thresh) - 1;
            break;
          default:
            // Unknown/Unsupported command
            reset(i2c);
            break;
        }
        break;
      case probe::cmd_set_threshold:
        m_raw[m_tx_bytes] = i2c.slave_receive_raw();
        if (m_tx_bytes != 0) {
          m_tx_bytes--;
          i2c.slave_ack(xtd::i2c_ack);
        } else {
          if (m_thresh.is_valid()) {
            eeprom_threshold = m_thresh.thresh;
          }
          reset(i2c);
        }
        break;
      default:
        // Received spurious i2c write
        reset(i2c);
        break;
    }
  }

  void protocol_fsm::on_tx(xtd::i2c_device& i2c) {
    bool done = m_tx_bytes == 0;
    i2c.slave_transmit(m_raw[m_tx_bytes], done);
    if (done) {
      m_state = probe::cmd_none;
      m_raw[0] = probe::msg_error;
    } else {
      m_tx_bytes--;
    }
  }

  void protocol_fsm::run(xtd::i2c_device& i2c) {
    if (m_do_read) {
      m_probe_read = probe::read();
      if (m_state == probe::cmd_is_dry) {
        m_is_dry = is_dry() ? probe::msg_probe_dry : probe::msg_probe_wet;
      }
      i2c.slave_ack(xtd::i2c_nack);
      m_do_read = false;
    }
  }

  bool protocol_fsm::can_sleep() const { return !m_do_read; }

}  // namespace probe
