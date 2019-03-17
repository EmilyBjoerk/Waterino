#ifndef GUARD_WATERINO_CONTROLLER_HPP
#define GUARD_WATERINO_CONTROLLER_HPP

#ifdef ENABLE_TEST
#include <ostream>
#else
#include "xtd_uc/ostream.hpp"
#include "xtd_uc/uart.hpp"
#endif

#include "xtd_uc/chrono.hpp"

using namespace xtd::unit_literals;

// This class implements a PI controller that computes the duration the pump
// should be active given time since it was last activated and a target
// activation period.
class Controller {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

#ifdef ENABLE_TEST
  using ostream = std::ostream;
#else
  using ostream = xtd::ostream<xtd::uart_stream_tag>;
#endif

  // This const expresses the default guess on the amount of water to give when
  // the PID is just starting.
  constexpr static duration default_duration = 4_s;

  Controller() = default;
  Controller(float kp, float ki, float si, const duration& target_period);

  // Compute the duration the pump should be active if the pump were to be
  // activated at the given timepoint
  duration compute(const time_point&) const;

  // Call this to inform the controller of the last time the pump was activated.
  // Normally this should be done after calling compute().
  void report_activation(const time_point&);

  void set_kp(float value);
  void set_ki(float value);
  void set_si(float value);
  void set_target_period(const duration& value);

  // Print the current status of the controller (PI values, target period, last watered)
  void print_stat(ostream& os, const time_point& now) const;

private:
  // Internally the error signal is expressed as percent of the target period.
  // This makes the Kp and Ki values independent of the target period, making it
  // easier to tune the the PI controller (one variable less) and also makes the
  // controller not need to be tuned if the target period is changed.
  float compute_error_pct(const time_point& now) const;

  float m_last_error{0.0f};
  time_point m_last_watering{0};
};

#endif
