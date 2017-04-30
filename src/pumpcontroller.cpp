#include "pumpcontroller.hpp"

using xtd::chrono::hours;
using xtd::chrono::milliseconds;
using namespace xtd::chrono_literals;
using namespace xtd::atmega328;

namespace waterino {
  pump_controller::pump_controller(uint8_t probe_ai_pin, xtd::arduino::dio_pin pump_activate_pin)
      : probe_pin(probe_ai_pin), pump_pin(pump_activate_pin) {
    xtd::arduino::configure(pump_pin, xtd::atmega328::pin_state::output, false);
  }

  hours pump_controller::update(const time_point& now) {
    if (now - last_probe > 4_h) {
      last_probe = now;
      adc.select_ch(probe_pin, adc_vref::internal_vcc);
      auto probe_value = adc.single_read();

      if (probe_value < probe_threshold) {
        auto last_pump_period = now - last_pumping;
        hours error = last_pump_period - target_pump_period;

        // We will define the error signal to be the relative error in relation to
        // the target pump period. This makes the controll coefficients independent
        // of the target period. And hopefully should transfer between different
        // periods.
        auto e = static_cast<float>(error.count()) / target_pump_period.count();

        Si += e;
        auto u = Kp * e + Ki * Si;
        auto pump_duration = base_pump_duration + milliseconds(static_cast<milliseconds::rep>(u));

        last_pumping = now;
        xtd::arduino::write(pump_pin, true);
        xtd::chrono::sleep(pump_duration);
        xtd::arduino::write(pump_pin, false);
      }
    }
    return 1_h;  // Call us again in at most one hour;
  }
}
