#ifndef GUARD_WATERINO_ICONTROLLER_HPP
#define GUARD_WATERINO_ICONTROLLER_HPP

#include "xtd_uc/chrono.hpp"

// This class implements a PI controller that computes the duration the pump
// should be active given time since it was last activated and a target
// activation period.
class IController {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

  // Compute the duration the pump should be active if the pump were to be
  // activated at the given timepoint
  virtual duration compute(const time_point&) const = 0;

  // Call this to inform the controller of the last time the pump was activated.
  // Normally this should be done after calling compute().
  virtual void report_activation(const time_point&) = 0;

  // Inform the controller that the given pump duration was too long and the pot
  // overflowed.
  virtual void report_overflow(const duration&) = 0;

  // Print the current status of the controller (PI values, target period, last watered)
  virtual void print_stat(const time_point& now) const = 0;
};

#endif
