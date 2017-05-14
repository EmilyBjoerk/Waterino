#include "pumpcontroller.hpp"
#include "xtd/sleep.hpp"

#include "xtd/uart.hpp"

using xtd::chrono::hours;
using xtd::chrono::seconds;
using xtd::chrono::milliseconds;
using namespace xtd::chrono_literals;

namespace waterino {
  pump_controller::pump_controller(uint8_t probe_ai_pin, arduino::dio_pin probe_pwr_p,
                                   arduino::dio_pin probe_pwr_n, arduino::dio_pin pump_activate_pin)
      : probe_ai(probe_ai_pin),
        divider_top(probe_pwr_p),
        divider_bottom(probe_pwr_n),
        pump_pin(pump_activate_pin)

  {
    // Make sure the pump is not driven.
    arduino::configure(pump_pin, avr::pin_state::output, false);

    // Make sure both probe control pins are in tristate configuration
    arduino::configure(divider_bottom, avr::pin_state::tristate);
    arduino::configure(divider_top, avr::pin_state::tristate);
  }

  clock_duration pump_controller::update(const time_point& now) {
    // avr::uart << "PID update... Current time: " << seconds(now.time_since_epoch()).count()
    //<< " s since start.\n";

    if (last_probe.time_since_epoch().count() == 0 || now - last_probe > probe_period) {
      last_probe = now;
      auto probe_value = probe();

      if (probe_value > probe_threshold) {
        auto last_pump_period = now - last_pumping;
        clock_duration error = target_pump_period - last_pump_period;
        /*        avr::uart << "Target pump period: " << target_pump_period.count() << '\n';
        avr::uart << "Last pump period: " << last_pump_period.count() << '\n';
        avr::uart << "Last pump time: " << last_pumping.time_since_epoch().count() << '\n';
        avr::uart << "Current time: " << now.time_since_epoch().count() << '\n';
        */
        // We will define the error signal to be the relative error in relation to
        // the target pump period. This makes the controll coefficients independent
        // of the target period. And hopefully should transfer between different
        // periods.
        auto e = static_cast<float>(error.count()) / target_pump_period.count();

        Si += e;
        auto u = Kp * e + Ki * Si;
        auto pump_duration =
            base_pump_duration + clock_duration(static_cast<clock_duration::rep>(u));

        if (pump_duration > max_pump_duration) {
          pump_duration = max_pump_duration;
        }

        last_pumping = now;

        avr::uart << "PID: e=" << xtd::chrono::minutes(error).count()
                  << " s. Activating pump for: " << milliseconds(pump_duration).count() << "ms\n";
        /*
        if (pump_duration.count() > 0) {
          arduino::write(pump_pin, true);
          avr::sleep(pump_duration);
          arduino::write(pump_pin, false);
        }*/
      }
    }
    return update_period;
  }

  uint16_t pump_controller::probe() const {
    bool turn_off_adc = false;
    if (!avr::adc::isenabled()) {
      turn_off_adc = true;
      avr::adc::enable();
    }
    avr::adc::select_ch(probe_ai, avr::adc::vref::internal_vcc);

    // Both pins are tristate (HighZ) initially. We set the sink first and then the source.
    arduino::configure(divider_bottom, avr::pin_state::output, false);
    arduino::configure(divider_top, avr::pin_state::output, true);
    avr::delay(stabilisation_time);
    auto first_read = avr::adc::blocking_read();

    // Change the high to low first so we go through both pins low instead of both high.
    arduino::write(divider_top, false);
    arduino::write(divider_bottom, true);
    avr::delay(stabilisation_time);
    auto second_read = 1023 - avr::adc::blocking_read();

    // The bottom is high, change it to tristate first.
    arduino::configure(divider_bottom, avr::pin_state::tristate);
    arduino::configure(divider_top, avr::pin_state::tristate);

    if (turn_off_adc) {
      avr::adc::disable();
    }

    auto avg = (first_read + second_read) / 2;
    avr::uart << "Probe value: " << avg << " (" << first_read << ", " << second_read << ")\n";
    return avg;
  }
}
