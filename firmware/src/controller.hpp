#ifndef GUARD_WATERINO_CONTROLLER_HPP
#define GUARD_WATERINO_CONTROLLER_HPP

#include "xtd_uc/chrono.hpp"
#include "xtd_uc/eeprom.hpp"

#include "icontroller.hpp"

using namespace xtd::chrono_literals;

// This class implements a PI controller that computes the duration the pump
// should be active given time since it was last activated and a target
// activation period.
class Controller : public IController{
public:
  Controller(float* eeprom_Kp, float* eeprom_Ki, float* eeprom_Si, duration* eeprom_target_period);

  // This const expresses the default guess on the amount of water to give when
  // the PID is just starting.
  constexpr static duration default_duration = 4_s;

  // Compute the duration the pump should be active if the pump were to be
  // activated at the given timepoint
  virtual duration compute(const time_point&) const override;

  // Call this to inform the controller of the last time the pump was activated.
  // Normally this should be done after calling compute().
  virtual void report_activation(const time_point&) override;

  // Inform the controller that the given pump duration was too long and the pot
  // overflowed.
  virtual void report_overflow(const duration&) override;

  void set_kp(float value) { Kp = value; }
  void set_ki(float value) { Ki = value; }
  void set_si(float value) { Si = value; }
  void set_target_period(const duration& value) { m_target_period = value; }

  // Print the current status of the controller (PI values, target period, last watered)
  virtual void print_stat(const time_point& now) const override;

private:

  // Internally the error signal is expressed as percent of the target period.
  // This makes the Kp and Ki values independent of the target period, making it
  // easier to tune the the PI controller (one variable less) and also makes the
  // controller not need to be tuned if the target period is changed.
  float compute_error_pct(const time_point& now) const;

  xtd::eeprom<float> Kp;
  xtd::eeprom<float> Ki;
  xtd::eeprom<float> Si;
  xtd::eeprom<duration> m_target_period;
  float m_last_error;
  time_point m_last_watering;
};

#endif
