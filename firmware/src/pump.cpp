#include "pump.hpp"

#include "hardware.hpp"
#include "xtd_uc/algorithm.hpp"
#include "xtd_uc/avr.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/units.hpp"
#include "xtd_uc/wdt.hpp"

xtd::eemem<bool> EEMEM ee_pump_active{false};
xtd::eemem<xtd::chrono::steady_clock::duration> EEMEM ee_max_pump_duration{30_s};

constexpr Pump::duration Pump::MAX_DURATION_UB;
constexpr Pump::duration Pump::MAX_DURATION_LB;

#if ENABLE_TEST
std::atomic<Pump::status> Pump::m_status{Pump::status::idle};
#else
volatile Pump::status Pump::m_status = Pump::status::idle;
#endif

Pump::Pump() {
  HAL::pump_stop();
  HAL::pump_led_off();

  // This checks min-max bounds as well
  set_max_pump(ee_max_pump_duration.get());
  m_status = Pump::status::idle;
}

bool Pump::activate(duration pump_duration) {
  HAL::pump_led_on();
  bool success = false;

  // We need to check overflow status on the next pumping as the overflow signal may
  // be asserted after we return due to the water not instantly flowing through the soil.
  update_max_duration();
  pump_duration = xtd::min(pump_duration, ee_max_pump_duration.get());

#ifndef ENABLE_TEST
  HAL::uart << xtd::pstr(PSTR("Enabling pump for: ")) << xtd::units::ms(pump_duration).count()
            << xtd::pstr(PSTR(" ms.\n"));
#endif

  m_status = status::observing;
  HAL::sense_overflow_enable_irq(overflow);
  xtd::delay(1_ms);  // Let IRQ trigger if it's already overflowed.

  if (!has_overflowed()) {
    const auto start = xtd::chrono::steady_clock::now();
    const auto until = start + pump_duration;

    ee_pump_active = true;
    HAL::pump_activate();
    while (!has_overflowed() && xtd::chrono::steady_clock::now() < until) {
      /*nop*/
      xtd::wdt_reset_timeout();
    }
    HAL::pump_stop();
    ee_pump_active = false;

    m_prev_duration = xtd::chrono::steady_clock::now() - start;
    success = true;
  } else {
    // Immediate overflow. Most likely the previous watering overflowed and the sensor hasn't
    // dried yet. Do not update the max pump duration as we have no information from this
    // activatiion.
    m_status = status::immediate_overflow;
  }

  // We leave overflow sensing enabled until it is disabled elsewhere as the water can take some
  // time to trickle through the soil into the catchment tray. Then check for the overflow bit
  // on next pumping.

  HAL::pump_led_off();
  return success;
}

bool Pump::is_overflow_monitoring() const {
  return 
}

void Pump::stop_overflow_monitoring() const { HAL::sense_overflow_disable_irq(); }

bool Pump::has_overflowed() const {
  return m_status == status::overflow || m_status == status::immediate_overflow;
}

bool Pump::is_pumping() const { return ee_pump_active; }

void Pump::reset_pumping() { ee_pump_active = false; }

void Pump::set_max_pump(duration dur) {
  if (dur > MAX_DURATION_UB) {
    ee_max_pump_duration = MAX_DURATION_UB;
  } else if (dur < MAX_DURATION_LB) {
    ee_max_pump_duration = MAX_DURATION_LB;
  } else {
    ee_max_pump_duration = dur;
  }
}

void Pump::print_stat(HAL::ostream& os) const {
  os << xtd::pstr(PSTR("Pump status: active=")) << ee_pump_active.get()
     << xtd::pstr(PSTR(", max_duration="))
     << xtd::chrono::seconds(ee_max_pump_duration.get()).count()
     << xtd::pstr(PSTR(" s, prev_duration=")) << xtd::chrono::seconds(m_prev_duration).count()
     << xtd::pstr(PSTR(" s, overflowed=")) << has_overflowed() << '\n';
}

void Pump::overflow() {
  m_status = status::overflow;
  HAL::sense_overflow_disable_irq();
}

void Pump::update_max_duration() {
  // Check results from previous pump activation and adjust max duration.
  duration max_duration = ee_max_pump_duration.get();

  if (m_status == status::overflow) {
    // Invariant: Previous duration is always smaller than or equal to max duration.
    // Hence we take the previous duration and reduce it by 1/16h (6.25%) to get a new
    // max duration.
    ee_max_pump_duration = xtd::max(m_prev_duration * 15 / 16, MAX_DURATION_LB);
  } else if (m_status == status::observing && m_prev_duration >= max_duration) {
    // The previous activation was limited by the max duration; However there was no overflow
    // This means that the max duration is too tight and we can increase it by 1/32th (3.125%).

    // N.B. Testing this with the current test setup would take 2xMAX_DURATION_UB or 10 minutes per
    // run. This is too much time to wait. We expect this one line to not be buggy.
    ee_max_pump_duration = xtd::min(max_duration + max_duration / 32, MAX_DURATION_UB);
  }
}
