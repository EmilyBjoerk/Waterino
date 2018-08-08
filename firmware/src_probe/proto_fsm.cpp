#include "proto_fsm.hpp"
#include "probe.hpp"

xtd::eeprom_small<uint16_t, 1> eeprom_threshold;

namespace probe {
  void protocol_fsm::next_state(bool done) {
    if (done) {
      m_state = probe::cmd_none;
    } else {
      m_substate++;
    }
  }

  void protocol_fsm::reset(xtd::i2c_device& i2c) {
    i2c.slave_ack(xtd::i2c_nack);
    m_state = probe::cmd_none;
  }

  bool protocol_fsm::is_dry() const { return m_probe_read.moisture < *eeprom_threshold; }

  void protocol_fsm::on_rx(xtd::i2c_device& i2c) {
    switch (m_state) {
      case probe::cmd_none:
        m_state = i2c.slave_receive_raw();
        m_substate = 0;

        if (m_state == probe::cmd_read_probe || m_state == probe::cmd_is_dry) {
          // Read probe before nacking, this forces the bus to be quiet while we read the ADC.
          // txn_buffer.probe_read = probe::read();
          m_do_read = true;
          return;  // Without acking! Acked from run()  when probe read completes
        } else if (m_state == probe::cmd_get_threshold) {
          m_thresh = probe::msg_threshold(*eeprom_threshold);
        }
        i2c.slave_ack(m_state == probe::cmd_set_threshold ? xtd::i2c_ack : xtd::i2c_nack);
        break;
      case probe::cmd_set_threshold:
        m_raw[m_substate++] = i2c.slave_receive_raw();
        if (m_substate < sizeof(m_thresh)) {
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
    bool done = true;
    switch (m_state) {
      case probe::cmd_read_probe:
        done = (m_substate == sizeof(m_probe_read) - 1);
        i2c.slave_transmit(m_raw[m_substate], done);
        break;
      case probe::cmd_get_threshold:
        done = (m_substate == sizeof(m_thresh) - 1);
        i2c.slave_transmit(m_raw[m_substate], done);
        break;
      case probe::cmd_is_dry:
        i2c.slave_transmit(is_dry() ? probe::msg_probe_dry : probe::msg_probe_wet, true);
        break;
      case probe::cmd_read_log:  // NYI
        i2c.slave_transmit(0xA3, true);
        break;
      default:
        // Received spurious write, tell firmware to not accept more writes in this transaction
        // (until a new start condition), it  will respond 0xFF to any reads (which by a coincidence
        // is equal to probe::cmd_error).
        i2c.slave_transmit(0x83, true);
        break;
    }
    next_state(done);
  }

  void protocol_fsm::run(xtd::i2c_device& i2c) {
    if (m_do_read) {
      m_probe_read = probe::read();
      i2c.slave_ack(xtd::i2c_nack);
      m_do_read = false;
    }
  }

  bool protocol_fsm::can_sleep() const { return !m_do_read; }

}  // namespace probe
