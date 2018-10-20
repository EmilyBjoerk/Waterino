#ifndef GUARD_WATERINO_CMD_INTERPRETER_HPP
#define GUARD_WATERINO_CMD_INTERPRETER_HPP

#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/queue.hpp"

class Pump;
class Probe;
class Controller;

/*
  Command list:

  sta // Print PID status: Kp, Ki, Si, Target period
  log // Dump log from EEPROM

  set ki %f
  set kp %f
  set si %f
  set tg %d // hours
  set mx %d // seconds

 */
class CmdInterpreter {
public:
  enum class status : uint8_t { good, error, overflow };
  constexpr static uint8_t max_cmd_len = 16;
  constexpr static uint8_t buffer_len = 4 * max_cmd_len - 1;

  CmdInterpreter(Pump* pump, Probe* probe, Controller* controller);

  // Signal an error in the input stream (all good characters must have been fed first).
  // May be called from ISR, must be short.
  void rx_error();

  // Executes all available commands from the buffer and recovers from errors.
  void execute_available();

  // Accept one char from the input stream.
  // May be called from ISR, must be short.
  void accept(char c);

private:
  Pump* m_pump;
  Probe* m_probe;
  Controller* m_controller;

  status m_status = status::good;
  uint8_t m_cmds_queued = 0;
  xtd::queue<char, buffer_len> m_buffer;
};

#endif
