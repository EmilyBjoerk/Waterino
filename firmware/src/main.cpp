#include "compute.hpp"
#include "controller.hpp"
#include "hardware.hpp"
#include "pump.hpp"
#include "xtd_uc/blink.hpp"
#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/numeric.hpp"
#include "xtd_uc/ratio.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/units.hpp"
#include "xtd_uc/wdt.hpp"

xtd::eemem<uint8_t> EEMEM ee_wdt_resets{0};
xtd::eemem<uint8_t> EEMEM ee_bod_resets{0};
xtd::eemem<uint8_t> EEMEM ee_power_cycles{0};
xtd::eemem<uint8_t> EEMEM ee_pump_resets{0};
xtd::eemem<HAL::moisture> EEMEM ee_dry_threshold{0};

auto g_controller = Controller{};
auto g_pump = Pump{};
auto g_last_probe = xtd::chrono::steady_clock::time_point{};

void setup() {
  switch (xtd::bootstrap(HAL::use_watchdog, xtd::wdt_timeout::_8000ms)) {
    case xtd::reset_cause::watchdog:
      ee_wdt_resets.clamp_increment();
      break;
    case xtd::reset_cause::brownout:
      ee_bod_resets.clamp_increment();
      break;
    default:
      ee_power_cycles.clamp_increment();
      break;
  }

  xtd::chrono::steady_clock::now(); // Start the system clock
  xtd::uart_configure(nullptr);
  HAL::hardware_initialize();

  // ee_pump_active is true, meaning we restarted while the pump was active
  // indicating a likely short circuit due to the water. Alert the user
  // and require a manual restart.
  if (g_pump.is_pumping()) {
    g_pump.reset_pumping();
    ee_pump_resets.clamp_increment();
    HAL::fatal(HAL::error_reset_during_pumping, xtd::pstr(PSTR("Reset during pumping!\n")));
  }
  HAL::uart << xtd::pstr(PSTR("Waterino ready!\n"));
  xtd::wdt_reset_timeout();
}

HAL::moisture probe_level() {
  const auto sensed_capacitance = HAL::sense_capacitance();
  const auto ntc_vdrop = HAL::sense_ntc_drop();
  const auto computed_temperature = compute_temperature(ntc_vdrop);
  const auto computed_moisture = compute_moisture(computed_temperature, sensed_capacitance);

#ifndef ENABLE_TEST
  HAL::uart << xtd::units::pF(sensed_capacitance).count() << xtd::pstr(PSTR(" pF, "));
  HAL::uart << xtd::units::mV(ntc_vdrop).count() << xtd::pstr(PSTR(" mV, "));
  HAL::uart << computed_moisture.count() << xtd::pstr(PSTR(" ppt, "));
  HAL::uart << computed_temperature.count() << xtd::pstr(PSTR(" cK\n"));

  // The flush is needed because, otherwise the output will get corrupted if the next
  // measurement starts immediately after. I'm not completely sure why but I think it
  // has something to do with the MCU going to sleep for the next sense or IRQ timing
  xtd::uart_flush();
#endif

  return computed_moisture;
}

bool water_level_low() { return false; }

int main() {
  setup();

  while (true) {
    xtd::wdt_reset_timeout();

    const auto now = xtd::chrono::steady_clock::now();

    /*
     TODO: Implement i2c protocol
    if (has_i2c_input()) {
      respond();
    }
    */

    if (g_controller.pump_activated_since_boot() &&
        now - g_controller.get_last_watering() > HAL::max_overflow_delay) {
      g_pump.stop_overflow_monitoring();
    }

    if (now - g_last_probe > HAL::sense_period) {
      g_last_probe = now;

      if (water_level_low()) {
        HAL::alert();
      } else if (probe_level() < ee_dry_threshold.get()) {
        const auto pump_duration = g_controller.compute(now);
        g_controller.report_activation(now);
        // Did we overflow immediately?
        if (!g_pump.activate(pump_duration)) {
          HAL::fatal(HAL::dry_overflow, xtd::pstr(PSTR("E_IMM_OVFLW")));
        }
      }
    }

    xtd::sleep(HAL::sense_period, /* deep sleep*/ false);
  }
}
