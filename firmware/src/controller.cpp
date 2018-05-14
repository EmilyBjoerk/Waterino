#include "controller.hpp"

#include "pinmap.hpp"  // xtd::cout

// Has to be defined even though it is compile time constant...
constexpr Controller::duration Controller::default_duration;

Controller::Controller(float* eeprom_Kp, float* eeprom_Ki, float* eeprom_Si,
                       Controller::duration* eeprom_target_period)
    : Kp(eeprom_Kp), Ki(eeprom_Ki), Si(eeprom_Si), m_target_period(eeprom_target_period) {}

// Compute the duration the pump should be active if the pump were to be
// activated at the given timepoint
Controller::duration Controller::compute(Controller::time_point now) const {
  // The error term and integral part are expressed as percent of target period
  // we need to scale this up to get the actual time.
  auto signal_pct = 1.0f + (*Kp) * compute_error_pct(now) + (*Ki) * (*Si);
  auto pump_duration_ticks = Controller::default_duration.count() * signal_pct;
  return Controller::duration(static_cast<Controller::duration::rep>(pump_duration_ticks + 0.5f));
}

float Controller::compute_error_pct(Controller::time_point now) const {
  auto first_activation = m_last_watering.time_since_epoch().count() == 0;

  auto period = static_cast<float>(m_target_period->count());

  // If this is the first time the pump has been activated after power on, we do
  // not know when the pump was last activated. However assuming that the device
  // was in a steady state prior to the poweroff, then the PI variable Si should
  // have a majority contribution to the control signal. Then if we assume error
  // value of zero. We will get the same duration as the last watering attempt.
  auto error = first_activation ? period : static_cast<float>((now - m_last_watering).count());

  // We normalise the error signal w.r.t. the target period,
  // this makes Kp and Ki independent of the target period.
  auto ans = (period - error) / period;
#if 0
  xtd::cout << ans
            << " period: " << (period * duration::period::num / duration::period::den / 3600.0)
            << "\n";
  xtd::cout << now.time_since_epoch() << " ---- " << m_last_watering.time_since_epoch()
            << std::endl;
#endif
  return ans;
}

// Call this to inform the controller of the last time the pump was activated.
void Controller::report_activation(Controller::time_point now) {
  Si = *Si + compute_error_pct(now);
  m_last_watering = now;
}

void Controller::report_overflow(Controller::duration) {
  xtd::cout << xtd::pstr(PSTR("Pot overflowed last time, is target period too long?"));
  // XXX: Possibly do some smart adjustment to target period.
}

void Controller::print_stat(Controller::time_point now) const {
  auto last_watered = now - m_last_watering;

  xtd::cout << xtd::pstr(PSTR("Controller status: Kp=")) << (*Kp)  //
            << xtd::pstr(PSTR(", Ki=")) << (*Ki)                   //
            << xtd::pstr(PSTR(", Si=")) << (*Si)                   //
            << xtd::pstr(PSTR(", target_period=")) << xtd::chrono::hours(*m_target_period).count()
            << xtd::pstr(PSTR(" hours, last_watered=")) << xtd::chrono::hours(last_watered).count()
            << xtd::pstr(PSTR(" hours ago.\n"));
}
