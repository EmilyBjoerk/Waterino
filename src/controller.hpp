#ifndef GUARD_WATERINO_CONTROLLER_HPP
#define GUARD_WATERINO_CONTROLLER_HPP

#include <util/atomic.h>
#include "xtd/chrono.hpp"
#include "xtd/eeprom.hpp"

using namespace xtd::chrono_literals;

class Controller {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

  Controller(void* eeprom_Kp, void* eeprom_Ki, void* eeprom_Si, void* eeprom_target_period)
      : Kp(eeprom_Kp), Ki(eeprom_Ki), Si(eeprom_Si), m_target_period(eeprom_target_period) {}

  constexpr static duration BASE_DURATION = 10_s;

  void advise_overflowed() {
      // FIXME: Do something as the last pumping overflowed.
  }

  duration compute(time_point now) {
    if (m_last_watering.time_since_epoch().count() == 0) {
      // First watering since reset, fudge `m_last_watering` so that the error
      // term becomes zero and we rely on the Si value from eeprom.
      m_last_watering = now - (*m_target_period);
    }

    auto error = *m_target_period - (now - m_last_watering);
    m_last_watering = now;

    // We normalise the error signal w.r.t. the target period,
    // this makes Kp and Ki independent of the target period.
    auto e = static_cast<float>(error.count()) / m_target_period->count();

    // Do not allow the UART receive ISR to change the values in the middle of computation
    auto signal = 0.0f;
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      Si = *Si + e;
      signal = (*Kp) * e + (*Ki) * (*Si);
    }
    auto pump_duration = BASE_DURATION + duration(static_cast<duration::rep>(signal));
    return pump_duration;
  }

private:
  xtd::eeprom<float> Kp;
  xtd::eeprom<float> Ki;
  xtd::eeprom<float> Si;
  xtd::eeprom<duration> m_target_period;

  time_point m_last_watering;
};

#endif
