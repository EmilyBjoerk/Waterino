#ifndef GUARD_WATERINO_APPLICATION_HPP
#define GUARD_WATERINO_APPLICATION_HPP

#include "controller.hpp"
#include "hardware.hpp"
#include "pump.hpp"
#include "xtd_uc/chrono.hpp"

class Application {
public:
  Application();

  void execute_loop();

  void print_state() const;

private:
  Controller m_controller;
  Pump m_pump;
  xtd::chrono::steady_clock::time_point m_last_probe;
  xtd::chrono::steady_clock::time_point m_now;

  HAL::rc_capacitance m_capacitance;
  HAL::adc_voltage m_ntc_voltage;
  HAL::kelvin m_temperature;
  HAL::moisture m_moisture;
};

#endif
