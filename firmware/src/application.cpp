#include "application.hpp"

#include "compute.hpp"
#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/numeric.hpp"
#include "xtd_uc/ratio.hpp"
#include "xtd_uc/units.hpp"
#include "xtd_uc/wdt.hpp"

xtd::eemem<uint8_t> EEMEM ee_wdt_resets{0};
xtd::eemem<uint8_t> EEMEM ee_bod_resets{0};
xtd::eemem<uint8_t> EEMEM ee_power_cycles{0};
xtd::eemem<uint8_t> EEMEM ee_pump_resets{0};
xtd::eemem<HAL::moisture> EEMEM ee_dry_threshold{0};

bool water_level_low() { return false; }

bool has_i2c_input() { return false; }

Application::Application() {
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

  HAL::hardware_initialize();

  // ee_pump_active is true, meaning we restarted while the pump was active
  // indicating a likely short circuit due to the water. Alert the user
  // and require a manual restart.
  if (m_pump.is_pumping()) {
    m_pump.reset_pumping();
    ee_pump_resets.clamp_increment();
    HAL::fatal(HAL::error_reset_during_pumping);
  }
  HAL::uart << xtd::pstr(PSTR("Waterino ready!\n"));
  xtd::wdt_reset_timeout();
}

void Application::execute_loop() {
  xtd::wdt_reset_timeout();
  m_now = xtd::chrono::steady_clock::now();

  if (has_i2c_input()) {
    // respond(); // TBD
  }

  if (HAL::sense_overflow_enabled() && m_controller.pump_activated_since_boot() &&
      m_now - m_controller.get_last_watering() > HAL::max_overflow_delay) {
    m_pump.stop_overflow_monitoring();
  }

  if (m_now - m_last_probe > HAL::sense_period) {
    // Make sure that the overflow detection is off, otherwise we may end
    // up in a bad state where multiple functions are fighting over the
    // use of the ADC
    m_pump.stop_overflow_monitoring();

    if (water_level_low()) {
      HAL::alert();
    } else {
      m_capacitance = HAL::sense_capacitance();
      m_ntc_voltage = HAL::sense_ntc_drop();
      m_temperature = compute_temperature(m_ntc_voltage);
      m_moisture = compute_moisture(m_temperature, m_capacitance);

      print_state();

      if (m_moisture < ee_dry_threshold.get()) {
        const auto pump_duration = m_controller.compute(m_now);
        m_controller.report_activation(m_now);
        if (!m_pump.activate(pump_duration)) {
          HAL::fatal(HAL::dry_overflow);  // We overflowed immediately...
        }
      }
      m_last_probe = m_now;
    }
  }
  HAL::sleep_until_irq();
}

void Application::print_state() const {
#ifndef ENABLE_TEST
  HAL::uart << xtd::units::pF(m_capacitance).count() << xtd::pstr(PSTR(" pF, "));
  HAL::uart << xtd::units::mV(m_ntc_voltage).count() << xtd::pstr(PSTR(" mV, "));
  HAL::uart << m_moisture.count() << xtd::pstr(PSTR(" ppt, "));
  HAL::uart << m_temperature.count() << xtd::pstr(PSTR(" cK\n"));

  // The flush is needed because, otherwise the output will get corrupted if the next
  // measurement starts immediately after. I'm not completely sure why but I think it
  // has something to do with the MCU going to sleep for the next sense or IRQ timing
  xtd::uart_flush();
#endif
}
