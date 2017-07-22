#include "cmdinterpreter.hpp"

CmdInterpreter::CmdInterpreter(Pump* pump, Probe* probe, Controller* controller)
    : m_pump(pump), m_probe(probe), m_controller(controller) {}

void CmdInterpreter::rx_error() { m_status = status::error; }

void CmdInterpreter::execute_available() {
  xtd::gpio_write(c_pin_rx_led, true);

  // Run all complete commands from the buffer.
  while (m_cmds_queued) {
    m_cmds_queued--;
    char cmd[max_cmd_len + 1];
    uint8_t len = 0;

    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      // Must be atomic as feed is called from an ISR and may modify the buffer out of band.
      while (len < max_cmd_len && !m_buffer.empty()) {
        auto c = m_buffer.get();
        cmd[len++] = c;
        if (c == '\0') {
          break;
        }
      }
    }

    if (cmd[len - 1] != '\0') {
      cmd[len - 1] = '\0';
      xtd::cout << xtd::pstr(PSTR("Command too long: ")) << cmd << '\n';
      // Skip to next command
      while (!m_buffer.empty() && '\0' != m_buffer.get())
        ;
      continue;
    }

    float arg_f = 0.0;
    long arg_d = 0;
    if (0 == strncmp_P(cmd, PSTR("log"), 4)) {
    } else if (0 == strncmp_P(cmd, PSTR("sta"), 4)) {
      m_controller->print_stat();
      m_pump->print_stat();
      m_probe->print_stat();
    } else if (0 == strncmp_P(cmd, PSTR("set "), 4)) {  // yes 4, don't compare '\0'
      if (1 == sscanf_P(cmd, PSTR("ki %f"), &arg_f)) {
        m_controller->set_ki(arg_f);
        m_controller->print_stat();
      } else if (1 == sscanf_P(cmd, PSTR("kp %f"), &arg_f)) {
        m_controller->set_kp(arg_f);
        m_controller->print_stat();
      } else if (1 == sscanf_P(cmd, PSTR("si %f"), &arg_f)) {
        m_controller->set_si(arg_f);
        m_controller->print_stat();
      } else if (1 == sscanf_P(cmd, PSTR("tg %ld"), &arg_d)) {
        m_controller->set_target_period(xtd::chrono::hours(arg_d));
        m_controller->print_stat();
      } else if (1 == sscanf_P(cmd, PSTR("mx %ld"), &arg_d)) {
        m_pump->set_max_pump(xtd::chrono::seconds(arg_d));
        m_pump->print_stat();
      } else {
        xtd::cout << xtd::pstr(PSTR("Unknown set parameter!\n"));
      }
    } else {
      xtd::cout << xtd::pstr(PSTR("Unknown command!\n"));
    }
  }
  // Then, if there was an error, clear the remainder of the buffer and reset the error.
  if (m_status != status::good) {
    m_buffer.clear();
    xtd::cout << xtd::pstr(PSTR("Parser recovered from "));
    if (m_status == status::error) {
      xtd::cout << xtd::pstr(PSTR("RX error.\n"));
    } else {
      xtd::cout << xtd::pstr(PSTR("overflow.\n"));
    }
    m_status = status::good;
  }
}

void CmdInterpreter::accept(char c) {
  xtd::gpio_write(c_pin_rx_led, false);
  if (c == '\r' || m_status != status::good) {
    return;  // Ignore carriage return and don't accept input if we're errored
  }

  if (m_buffer.full()) {
    m_status = status::overflow;
    return;
  }

  if (c == '\n') {  // Linefeed separates commands
    constexpr auto max_cmds = xtd::numeric_limits<decltype(m_cmds_queued)>::max();
    if (m_cmds_queued == max_cmds) {
      m_status = status::overflow;
      return;
    }
    m_cmds_queued++;
  }
  m_buffer.push(c);
}
