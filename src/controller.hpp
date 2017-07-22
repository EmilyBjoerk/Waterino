#ifndef GUARD_WATERINO_CONTROLLER_HPP
#define GUARD_WATERINO_CONTROLLER_HPP

#include <util/atomic.h>
#include "pinmap.hpp"
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
    xtd::cout << xtd::pstr(PSTR("Pot overflowed last time, is target period too long?"));
    // XXX: Possibly do some smart adjustment to target period.
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

    auto signal = 0.0f;
    Si = *Si + e;
    signal = (*Kp) * e + (*Ki) * (*Si);
    auto pump_duration = BASE_DURATION + duration(static_cast<duration::rep>(signal));
    return pump_duration;
  }

  void set_kp(float value) { Kp = value; }
  void set_ki(float value) { Ki = value; }
  void set_si(float value) { Si = value; }
  void set_target_period(duration value) { m_target_period = value; }

  void print_stat() {
    auto last_watered = xtd::chrono::steady_clock::now() - m_last_watering;

    xtd::cout << xtd::pstr(PSTR("Controller status: Kp=")) << (*Kp)  //
              << xtd::pstr(PSTR(", Ki=")) << (*Ki)                   //
              << xtd::pstr(PSTR(", Si=")) << (*Si)                   //
              << xtd::pstr(PSTR(", target_period=")) << xtd::chrono::hours(*m_target_period).count()
              << xtd::pstr(PSTR(" hours, last_watered="))
              << xtd::chrono::hours(last_watered).count() << xtd::pstr(PSTR(" hours ago.\n"));
  }

private:
  xtd::eeprom<float> Kp;
  xtd::eeprom<float> Ki;
  xtd::eeprom<float> Si;
  xtd::eeprom<duration> m_target_period;

  time_point m_last_watering;
};

#endif
