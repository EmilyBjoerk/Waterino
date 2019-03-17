#include "pump.hpp"
#include "hardware.hpp"

#include "xtd_uc/avr.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"

// Make rtags happy
#ifndef EEMEM
#define EEMEM
#endif

xtd::eemem<bool> EEMEM ee_pump_active{false};
xtd::eemem<xtd::chrono::steady_clock::duration> EEMEM ee_max_pump_duration{30_s};

constexpr Pump::duration Pump::MAX_DURATION_UB;
constexpr Pump::duration Pump::MAX_DURATION_LB;
volatile bool Pump::m_overflowed = false;

Pump::Pump() {
  HALProbe::pump_stop();
  HALProbe::pump_led_off();

  // This checks min-max bounds as well
  set_max_pump(ee_max_pump_duration.get());
}

bool Pump::activate(duration pump_duration) {
  HALProbe::pump_led_on();

  // We need to check overflow status on the next pumping as the overflow signal may
  // be asserted after we return due to the water not instantly flowing through the soil.
  update_max_duration();
  pump_duration = xtd::min(pump_duration, ee_max_pump_duration.get());

  m_overflowed = false;
  HALProbe::sense_overflow_enable_irq(overflow);
  xtd::delay(1_ms);  // Let IRQ trigger if it's already overflowed.
  if (m_overflowed) {
    // We're already overflowed but we're requested to pump (i.e. soil is dry)
    // something is amiss
    HALProbe::pump_led_off();
    return false;
  }

  // Non-Volatile, if true on RESET we can detect reset due to short circuit (done elsewhere).
  ee_pump_active = true;
  auto start = xtd::chrono::steady_clock::now();
  auto until = start + pump_duration;
  HALProbe::pump_activate();
  while (!has_overflowed() && xtd::chrono::steady_clock::now() < until) {
    // nop
  }

  // Overflow IRQ does the below
  if (!has_overflowed()) {
    HALProbe::pump_stop();
    HALProbe::sense_overflow_disable_irq();
  }
  
  // Note: may be shorter than pump_duration if overflow was triggered
  m_prev_duration = xtd::chrono::steady_clock::now() - start;

  reset_pumping();
  HALProbe::pump_led_off();

  // We leave overflow sensing enabled until it is disabled elsewhere as the water can take some
  // time to trickle through the soil into the catchment tray. Then check for the overflow bit on
  // next pumping.
  return true;
}

bool Pump::has_overflowed() const { return m_overflowed; }

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

void Pump::print_stat(ostream& os) const {
  os << xtd::pstr(PSTR("Pump status: active=")) << ee_pump_active.get()
     << xtd::pstr(PSTR(", max_duration="))
     << xtd::chrono::seconds(ee_max_pump_duration.get()).count()
     << xtd::pstr(PSTR(" s, prev_duration=")) << xtd::chrono::seconds(m_prev_duration).count()
     << xtd::pstr(PSTR(" s, last_overflowed=")) << m_overflowed << '\n';
}

void Pump::overflow() {
  HALProbe::pump_stop();
  HALProbe::sense_overflow_disable_irq();
  m_overflowed = true;
}

void Pump::update_max_duration() {
  // Check results from previous pump activation and adjust max duration.
  auto max_duration = ee_max_pump_duration.get();
  if (m_overflowed) {
    // Invariant: Previous duration is always smaller than or equal to max duration.
    // Hence we take the previous duration and reduce it by 1/16h (6.25%) to get a new
    // max duration.
    auto gain = (m_prev_duration.count() + 15) / 16;  // Round up.
    auto new_max = duration(m_prev_duration.count() - gain);
    ee_max_pump_duration = new_max > MAX_DURATION_UB ? MAX_DURATION_UB : new_max;
  } else if (m_prev_duration >= max_duration) {
    // The previous activation was limited by the max duration; However there was no overflow
    // This means that the max duration is too tight and we can increase it by 1/32th (3.125%).
    auto gain = max_duration.count() / 32;  // Round down.
    auto new_max = duration(max_duration.count() + gain);
    ee_max_pump_duration = new_max < MAX_DURATION_LB ? MAX_DURATION_LB : new_max;
  }
}
