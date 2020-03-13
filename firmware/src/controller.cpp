#include "controller.hpp"

#include "xtd_uc/avr.hpp"
#include "xtd_uc/eeprom.hpp"

// Has to be defined even though it is compile time constant...
constexpr Controller::duration Controller::default_duration;

xtd::eemem<float> EEMEM ee_pid_kp{1.0f};
xtd::eemem<float> EEMEM ee_pid_ki{1.0f};
xtd::eemem<float> EEMEM ee_pid_si{1.0f};
xtd::eemem<float> EEMEM ee_tgt_period_hours{24.0f * 5.0f};

Controller::Controller(float kp, float ki, float si, float target_period_hours) {
  set_kp(kp);
  set_ki(ki);
  set_si(si);
  set_target_period(target_period_hours);
}

// Compute the duration the pump should be active if the pump were to be
// activated at the given timepoint
Controller::duration Controller::compute(const time_point& now) const {
  // The error term and integral part are expressed as percent of target period
  // we need to scale this up to get the actual time.
  auto error_pct = compute_error_pct(now);
  auto signal_pct = 1.0f + ee_pid_kp * error_pct + ee_pid_ki * ee_pid_si;
  auto pump_duration_ticks = default_duration.count() * signal_pct + 0.5f;
  return duration(static_cast<duration::value_type>(pump_duration_ticks));
}

float Controller::compute_error_pct(const time_point& now) const {
  auto first_activation = !pump_activated_since_boot();
  auto period = ee_tgt_period_hours.get();

  // If this is the first time the pump has been activated after power on, we do
  // not know when the pump was last activated. However assuming that the device
  // was in a steady state prior to the poweroff, then the PI variable Si should
  // have a majority contribution to the control signal. Then if we assume error
  // value of zero. We will get the same duration as the last watering attempt.
  auto error = first_activation
                   ? period
                   : xtd::ratio_scale<xtd::ratio_divide<duration::scale, xtd::ratio<3600>>>(
                         static_cast<float>((now - m_last_watering).count()));

  // We normalise the error signal w.r.t. the target period,
  // this makes Kp and Ki independent of the target period.
  auto ans = 1.0f - error / period;

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
void Controller::report_activation(const time_point& now) {
  m_last_error = compute_error_pct(now);
  ee_pid_si = ee_pid_si + m_last_error;
  m_last_watering = now;
}

void Controller::set_kp(float value) { ee_pid_kp = value; }
void Controller::set_ki(float value) { ee_pid_ki = value; }
void Controller::set_si(float value) { ee_pid_si = value; }
void Controller::set_target_period(float value) { ee_tgt_period_hours = value; }

bool Controller::pump_activated_since_boot() const {
  return m_last_watering.time_since_epoch().count() != 0;
}

Controller::time_point Controller::get_last_watering() const { return m_last_watering; }

void Controller::print_stat(HAL::ostream& os, const time_point& now) const {
  auto last_watered = now - m_last_watering;

  os << xtd::pstr(PSTR("Controller status: Kp=")) << ee_pid_kp  //
     << xtd::pstr(PSTR(", Ki=")) << ee_pid_ki                   //
     << xtd::pstr(PSTR(", Si=")) << ee_pid_si                   //
     << xtd::pstr(PSTR(", e=")) << m_last_error                 //
     << xtd::pstr(PSTR(", target_period=")) << static_cast<long>(ee_tgt_period_hours.get())
     << xtd::pstr(PSTR(" hours, last_watered=")) << xtd::chrono::hours(last_watered).count()
     << xtd::pstr(PSTR(" hours ago. Now=")) << xtd::chrono::hours(now.time_since_epoch()).count()
     << xtd::pstr(PSTR(" hours after boot.\n"));
}
