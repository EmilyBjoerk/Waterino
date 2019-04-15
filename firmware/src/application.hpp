#ifndef GUARD_WATERINO_APPLICATION_HPP
#define GUARD_WATERINO_APPLICATION_HPP

#include "hardware.hpp"
#include "controller.hpp"
#include "pump.hpp"

class Application {
public:
  // Runs application initialization for the MCU including
  // recovering from previous unexpected failures and printing
  Application();

  // Run the application logic and return true if the
  // MCU can safely go into deep sleep
  bool run();

private:
  Controller m_controller;
  Pump m_pump;

  HAL::moisture read_moisture();
};

#endif
