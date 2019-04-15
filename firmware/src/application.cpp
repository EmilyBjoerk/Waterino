#include "application.hpp"
#include "compute.hpp"

#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/numeric.hpp"
//#include "xtd_uc/wdt.hpp"

// Make rtags happy
#ifndef EEMEM
#define EEMEM
#endif

#ifdef ENABLE_TEST
#include <iostream>
auto& uart = std::cout;
#else
#include "xtd_uc/uart.hpp"
xtd::ostream<xtd::uart_stream_tag> uart;
#endif

xtd::eemem<uint8_t> EEMEM ee_wdt_resets{0};
xtd::eemem<uint8_t> EEMEM ee_bod_resets{0};
xtd::eemem<uint8_t> EEMEM ee_power_cycles{0};
xtd::eemem<uint8_t> EEMEM ee_pump_resets{0};
xtd::eemem<HAL::moisture> EEMEM ee_dry_threshold{0};

template <typename T>
void ee_count_up(xtd::eemem<T>& x) {
  if (x.get() < xtd::numeric_limits<T>::max()) {
    x = x.get() + 1;
  }
}

Application::Application() {
  switch (xtd::bootstrap(HAL::use_watchdog)) {
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
  HAL::hardware_initialize();

  // Start the system clock
  xtd::chrono::steady_clock::now();

  // TODO: ee_pump_active is true, we restarted while the pump was active
  // indicating a likely short circuit due to the water. Alert the user
  // and require a manual restart.
  if (m_pump.is_pumping()) {
    m_pump.reset_pumping();
    ee_count_up(ee_pump_resets);
    HAL::fatal(HAL::error_reset_during_pumping, xtd::pstr(PSTR("Reset during pumping!\n")));
  }
}

bool Application::run() {
  bool can_deep_sleep = true;
  if (read_moisture() < ee_dry_threshold.get()) {
    // Time must be recorded before the alert loop below,
    // otherwise the alert loop may extend the observed time
    // between dryness which the PID controller would interpret
    // as there being too much water last time and reduce watering.
    const auto now = xtd::chrono::steady_clock::now();

    // while (g_pump.water_level_low()) {
    //  HAL::alert();  // Repeatedly check the condition and alert the user
    //}
    const auto pump_duration = m_controller.compute(now);
    m_controller.report_activation(now);
    if (!m_pump.activate(pump_duration)) {
      HAL::fatal(HAL::dry_overflow,
                 xtd::pstr(PSTR("Dry soil detected but overflow tripped immediately!")));
    }
    can_deep_sleep = false;
  }

  return can_deep_sleep;
}

HAL::moisture Application::read_moisture() {
  const auto sensed_charge_time = HAL::sense_rc_delay();
  const auto sensed_capacitance = HAL::rc_capacitance(sensed_charge_time.count());
  const auto ntc_vdrop = HAL::sense_ntc_drop();
  const auto computed_temperature = compute_temperature(ntc_vdrop);
  const auto computed_moisture = compute_moisture(computed_temperature, sensed_capacitance);

  /*  log_measurement(computed_moisture, computed_temperature, sensed_capacitance, ntc_vdrop,
      sensed_charge_time);*/
  return computed_moisture;
}
