#include "compute.hpp"
#include "config.hpp"
#include "controller.hpp"
#include "eeprom.hpp"
#include "hardware.hpp"
#include "logging.hpp"
#include "pump.hpp"

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

Controller g_controller;
Pump g_pump;

enum probe_error_code : char { error_reset_during_pumping, dry_overflow };

auto read_moisture() {
  HALProbe::sense_overflow_disable_irq();  // Pin is needed by sense_rc_delay();

  const auto sensed_charge_time = HALProbe::sense_rc_delay();
  const auto sensed_capacitance = rc_capacitance(sensed_charge_time.count());
  const auto ntc_vdrop = HALProbe::sense_ntc_drop();
  const auto computed_temperature = compute_temperature(ntc_vdrop);
  const auto computed_moisture = compute_moisture(computed_temperature, sensed_capacitance);

  log_measurement(computed_moisture, computed_temperature, sensed_capacitance, ntc_vdrop,
                  sensed_charge_time);
  return computed_moisture;
}

void fatal(probe_error_code, const xtd::pstr& msg) {
  // TODO: Signal over I2C
  uart << xtd::pstr(PSTR("FATAL: ")) << msg << '\n';
  while (true) {
    HALProbe::pump_led_on();
    xtd::delay(200_ms);
    HALProbe::pump_led_off();
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
  HALProbe::hardware_initialize();

  // Start the system clock
  xtd::chrono::steady_clock::now();
  uart << xtd::pstr(PSTR("Waterino starting\n"));

  // TODO: ee_pump_active is true, we restarted while the pump was active
  // indicating a likely short circuit due to the water. Alert the user
  // and require a manual restart.
  if (g_pump.is_pumping()) {
    g_pump.reset_pumping();
    ee_count_up(ee_pump_resets);
    fatal(error_reset_during_pumping, xtd::pstr(PSTR("Reset during pumping!\n")));
  }
}

void loop() {
  bool can_deep_sleep = true;
  if (read_moisture() < *ee_dry_threshold) {
    // Time must be recorded before the alert loop below,
    // otherwise the alert loop may extend the observed time
    // between dryness which the PID controller would interpret
    // as there being too much water last time and reduce watering.
    const auto now = xtd::chrono::steady_clock::now();

    //while (g_pump.water_level_low()) {
    //  HALProbe::alert();  // Repeatedly check the condition and alert the user
    //}
    const auto pump_duration = g_controller.compute(now);
    g_controller.report_activation(now);
    if (!g_pump.activate(pump_duration)) {
      fatal(dry_overflow, xtd::pstr(PSTR("Dry soil detected but overflow tripped immediately!")));
    }
    can_deep_sleep = false;
  }
  xtd::sleep(c_sense_period, can_deep_sleep);
}

int main() {
  initialize();
  while (true) {
    loop();
  }
}
