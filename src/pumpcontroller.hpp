#ifndef GUARD_WATERINO_PUMPCONTROLLER_HPP
#define GUARD_WATERINO_PUMPCONTROLLER_HPP

#include "xtd/arduino.hpp"
#include "xtd/chrono.hpp"

using namespace xtd::chrono_literals;

namespace waterino {
  using time_point = xtd::chrono::steady_clock::time_point;
  using clock_duration = xtd::chrono::steady_clock::duration;

  class pump_controller {
  public:
    constexpr static auto probe_period = 4_h;
    constexpr static auto update_period = 1_h;

    constexpr static auto max_pump_duration = 10_s;
    constexpr static auto base_pump_duration = clock_duration(3500_ms);
    constexpr static auto target_pump_period = clock_duration(120_h);  // 5 days

    constexpr static auto stabilisation_time = 200_ms;  // TODO: Derive a usefull value here.

    constexpr static auto Kp = 4000.0f;
    constexpr static auto Ki = 2000.0f;

    pump_controller(uint8_t probe_ai_pin, arduino::dio_pin probe_pwr_p,
                    arduino::dio_pin probe_pwr_n, arduino::dio_pin pump_activate_pin);

    // Call this to make the controller check if it needs to check and take appropriate actions.
    // Currently it will block during the time it runs the pump.
    // Returns the maximal time until it must be called again.
    clock_duration update(const time_point& now);

  private:
    const uint16_t probe_threshold = 600;
    const uint8_t probe_ai;
    const arduino::dio_pin divider_top;
    const arduino::dio_pin divider_bottom;
    const arduino::dio_pin pump_pin;

    time_point last_probe;
    time_point last_pumping;

    float Si = 0.0f;

    uint16_t probe() const;
  };
}

#endif
