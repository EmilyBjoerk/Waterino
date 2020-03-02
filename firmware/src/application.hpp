#ifndef GUARD_WATERINO_APPLICATION_HPP
#define GUARD_WATERINO_APPLICATION_HPP


class Application {
public:
  // The longest time after the pump has been activated that we could conceivably
  // still observe a pot overflow for the first time.
  static constexpr Controller::duration max_overflow_delay = 10_min;

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
