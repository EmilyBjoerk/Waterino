#include "compute.hpp"
#include "config.hpp"
#include "eeprom.hpp"
#include "hardware.hpp"
#include "logging.hpp"

#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/limits.hpp"
#include "xtd_uc/sched_fcfs.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/uart.hpp"
#include "xtd_uc/wdt.hpp"

#include <avr/interrupt.h>

xtd::ostream<xtd::uart_stream_tag> uart;

enum probe_error_code : char { error_reset_during_pumping };

void fatal(probe_error_code, const xtd::pstr& msg) {
  // TODO: Signal over I2C
  uart << xtd::pstr(PSTR("FATAL: ")) << msg << '\n';
  while (true) {
    pump_led_on();
    xtd::delay(200_ms);
    pump_led_off();
    xtd::delay(200_ms);
  }
}

void initialize() {
  switch (xtd::bootstrap(c_use_watchdog)) {
    case xtd::reset_cause::watchdog:
      ee_count_up(ee_wdt_resets);
      break;
    case xtd::reset_cause::brownout:
      ee_count_up(ee_bod_resets);
      break;
    default:
      ee_count_up(ee_power_cycles);
      break;
  }

  // xtd::wdt_set_timeout(xtd::wdt_timeout::_8000ms);
  xtd::uart_configure(nullptr);
  hardware_initialize();

  // Start the system clock
  xtd::chrono::steady_clock::now();

  uart << xtd::pstr(PSTR("Waterino starting\n"));
}

constexpr auto c_no_overflow = xtd::chrono::steady_clock::time_point(0);
auto g_overflow_time = c_no_overflow;

// Returns true if an overflow condition has been detected since the
// last call to updatu_max_pump_duration() below or since restart.
bool overflow_occurred() { return g_overflow_time != c_no_overflow; }

// Called from the IRQ handler when an overflow has been detected.
// Stops the pump immediately and records time of the overflow.
// The sleep command wakes, and calls pump_sleep_cb() below
// which will cause the sleep to abort and control returns to main.
__attribute__((used)) void overflow_detected() {
  pump_stop();
  g_overflow_time = xtd::chrono::steady_clock::now();
}

// See comments on overflow_detected().
__attribute__((used)) bool pump_sleep_cb() { return !overflow_occurred(); }

// Updates the value stored is ee_max_pump_duration if an overflow ocurred
// During the last pump activation at time 'last_pump_time'.
// See also comments on overflow_detected().
void update_max_pump_duration(xtd::chrono::steady_clock::time_point last_pump_time) {
  if (overflow_occurred()) {
    ee_max_pump_duration = xtd::min(*ee_max_pump_duration, g_overflow_time - last_pump_time);
    g_overflow_time = c_no_overflow;
  }
}

auto activate_pump(xtd::chrono::steady_clock::duration pump_duration) {
  ee_pump_active = true;
  auto now = xtd::chrono::steady_clock::now();
  pump_activate();
  xtd::sleep(pump_duration, false, pump_sleep_cb);
  pump_stop();
  ee_pump_active = false;
  return now;
}

int main() {
  initialize();

  // TODO: ee_pump_active is true, we restarted while the pump was active
  // indicating a likely short circuit due to the water. Alert the user
  // and require a manual restart.
  if (*ee_pump_active) {
    ee_pump_active = false;
    ee_count_up(ee_pump_resets);
    fatal(error_reset_during_pumping, xtd::pstr(PSTR("Reset during pumping!\n")));
  }

  auto last_pump_time = xtd::chrono::steady_clock::time_point(0);
  while (true) {
    sense_overflow_disable_irq();  // Pin is needed by sense_rc_delay();

    const auto sensed_charge_time = sense_rc_delay();
    const auto sensed_capacitance = rc_capacitance(sensed_charge_time.count());
    const auto ntc_vdrop = sense_ntc_drop();
    const auto computed_temperature = compute_temperature(ntc_vdrop);
    const auto computed_moisture = compute_moisture(computed_temperature, sensed_capacitance);
    log_measurement(computed_moisture, computed_temperature, sensed_capacitance, ntc_vdrop,
                    sensed_charge_time);

    if (computed_moisture < *ee_dry_threshold) {
      pump_led_on();
      update_max_pump_duration(last_pump_time);

      const auto pump_duration =
          xtd::min(control_pump_duration(last_pump_time, ee_last_pump_duration, ee_pump_pid_kp,
                                         ee_pump_pid_ki, ee_pump_pid_si),
                   *ee_max_pump_duration);
      log_activation(pump_duration, last_pump_time);
      ee_last_pump_duration = pump_duration;

      sense_overflow_enable_irq(overflow_detected);
      last_pump_time = activate_pump(pump_duration);
      pump_led_off();
      xtd::sleep(c_sense_period, false);
    } else {
      xtd::sleep(c_sense_period, true);
    }
  }
}
