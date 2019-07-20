#include "application.hpp"
#include "compute.hpp"

#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/numeric.hpp"
#include "xtd_uc/ratio.hpp"
//#include "xtd_uc/wdt.hpp"

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

void dbg(const char* x){
  uart<<x<<"\n";
  xtd::uart_flush();
}

constexpr Controller::duration Application::max_overflow_delay;

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
  xtd::chrono::steady_clock::now(); // System clock starts now.
  
  if (m_pump.is_pumping()) {
    // The pump state in EEPROM was set to active indicating that the system reset
    // after the pump activated but before it finnished. Something is possibly bad.
    m_pump.reset_pumping();
    ee_pump_resets.clamp_increment();
    HAL::fatal(HAL::error_reset_during_pumping,
	       xtd::pstr(PSTR("Reset during pumping!\n")));
  }
  
  xtd::wdt_reset_timeout();
}

bool Application::run() {
  xtd::wdt_reset_timeout();

  const auto now = xtd::chrono::steady_clock::now();
  auto can_deep_sleep = true;

  if (m_controller.pump_activated_since_boot() &&
      now - m_controller.get_last_watering() > max_overflow_delay) {
    // We are not expecting an overflow at this point, stop the
    // actvie logic testing for one.
    HAL::sense_overflow_disable_irq();
  }
  if (read_moisture() < ee_dry_threshold.get()) {
    // Time must be recorded before the alert loop below,
    // otherwise the alert loop may extend the observed time
    // between dryness which the PID controller would interpret
    // as there being too much water last time and reduce watering.

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
  uart << xtd::pstr(PSTR("Probe Reading\n"));

  const auto sensed_capacitance = HAL::sense_capacitance();
  const auto ntc_vdrop = HAL::sense_ntc_drop();
  const auto computed_temperature = compute_temperature(ntc_vdrop);
  const auto computed_moisture = compute_moisture(computed_temperature, sensed_capacitance);

#ifndef ENABLE_TEST
  uart << xtd::pstr(PSTR("Capacitance: "))
       << xtd::units::capacitance<uint32_t, xtd::pico>(sensed_capacitance).count()
       << xtd::pstr(PSTR(" pF ("))
       << sensed_capacitance.count()
       << xtd::pstr(PSTR(").\n"));
  uart << xtd::pstr(PSTR("Moisture: ")) << computed_moisture.count()
       << xtd::pstr(PSTR(" thousandths.\n"));
  uart << xtd::pstr(PSTR("Temperature: ")) << (computed_temperature.count() - 27315)
       << xtd::pstr(PSTR(" centi degrees ("))
       << xtd::units::voltage<uint32_t, xtd::milli>(ntc_vdrop).count()
       << xtd::pstr(PSTR(").\n"));

  // The flush is needed because, otherwise the output will get corrupted if the next
  // measurement starts immediately after. I'm not completely sure why but I think it
  // has something to do with the MCU going to sleep for the next sense or IRQ timing
  xtd::uart_flush();

#endif

  return computed_moisture;
}
