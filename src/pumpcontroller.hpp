#ifndef GUARD_WATERINO_PUMPCONTROLLER_HPP
#define GUARD_WATERINO_PUMPCONTROLLER_HPP

#include "xtd/arduino.hpp"
#include "xtd/chrono.hpp"

using namespace xtd::chrono_literals;

namespace waterino {
  using time_point = xtd::chrono::steady_clock::time_point;

  class pump_controller {
  public:
    pump_controller(uint8_t probe_ai_pin, xtd::arduino::dio_pin pump_activate_pin);

    // Call this to make the controller check if it needs to check and take appropriate actions.
    // Currently it will block during the time it runs the pump.
    // Returns the maximal time until it must be called again.
    xtd::chrono::hours update(const time_point& now);

  private:
    const uint16_t probe_threshold = 300;
    const uint8_t probe_pin;
    const xtd::arduino::dio_pin pump_pin;

    xtd::chrono::milliseconds base_pump_duration = 3500_ms;
    xtd::chrono::hours target_pump_period = 120_h;  // 5 days
    time_point last_probe;
    time_point last_pumping;

    float Kp = 1.0f;
    float Ki = 1.0f;
    float Si = 0.0f;
  };
}

#endif
