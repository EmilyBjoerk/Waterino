#include "pump.hpp"
#include "eeprom_layout.hpp"
#include "xtd/adc.hpp"
#include "xtd/delay.hpp"

using xtd::chrono::steady_clock;

constexpr Pump::duration Pump::MAX_DURATION_UB;
constexpr Pump::duration Pump::MAX_DURATION_LB;

Pump::Pump(xtd::gpio_pin pump_pin, uint8_t level_pin, void* eeprom_max_pump_duration_address,
           void* eeprom_active_address)
    : m_active(eeprom_active_address),
      m_max_duration(eeprom_max_pump_duration_address),
      m_pump_pin(pump_pin),
      m_level_pin(level_pin) {
  xtd::gpio_config(m_pump_pin, xtd::gpio_mode::output, false);
  EIMSK &= ~_BV(INT0);

  // Make sure the data in the EEPROM isn't corrupted.
  if (*m_max_duration > MAX_DURATION_UB) {
    m_max_duration = MAX_DURATION_UB;
  } else if (*m_max_duration < MAX_DURATION_LB) {
    m_max_duration = MAX_DURATION_LB;
  }
}

// Pre-conditions:
// * Global interrupts are enabled.
// * ADC is enabled and has been set to use internal_vcc as AVref.
//
// Attempts to activate the pump. If the overflow detector is tripped then
// activate() will fail and return false without activating the pump. Likewise
// if the water level in the reservoir is low. If a short is detected in the
// reservoir through the level check then this function will never return and
// sets the signal LED and rings the buzzer.
Pump::Result Pump::activate(duration pump_duration) {
  auto result = water_level();
  if (result != Result::success) {
    return result;
  }

  // We need to check overflow status on the next pumping as the overflow signal may
  // be asserted after we return due to the water not instantly flowing through the soil.
  update_max_duration();
  if (pump_duration > *m_max_duration) {
    pump_duration = *m_max_duration;
  }

  enable_overflow_irq();
  if (m_overflowed) {
    return Result::overflow;
  }

  // Non-Volatile, if true on RESET we can detect reset due to short circuit (done elsewhere).
  m_active = true;

  auto start = steady_clock::now();
  auto until = start + pump_duration;
  xtd::gpio_write(m_pump_pin, true);
  while (result == Result::success && steady_clock::now() < until) {
    if (m_overflowed) {  // May be raised at any time from IRQ
      result = Result::overflow;
    } else {
      result = water_level();
    }
  }
  xtd::gpio_write(m_pump_pin, false);
  m_active = false;
  m_prev_duration = steady_clock::now() - start;

  // We leave the overflow interrupt unmasked as the water can take some time
  // to trickle through the soil into the catchment tray. Then check for the
  // overflow bit on next pumping.
  return result;
}

void Pump::overflow() {
  xtd::gpio_write(m_pump_pin, false);

  // Disable interrupts for overflow pin otherwise they will continuously trigger.
  EIMSK &= ~_BV(INT0);
  m_overflowed = true;
}

bool Pump::has_overflowed() const{
    return m_overflowed;
}

bool Pump::is_pumping() const { return *m_active; }

void Pump::reset_pumping() { m_active = false; }

Pump::Result Pump::water_level() const {
  xtd::adc::select_ch(m_level_pin, xtd::adc::vref::internal_vcc);
  auto value = xtd::adc::blocking_read();

  if (value > LEVEL_OK_UB) {
    return Result::level_short_circuit;
  }
  if (value < LEVEL_OK_LB) {
    return Result::level_low;
  }
  return Result::success;
}

void Pump::enable_overflow_irq() {
  m_overflowed = false;
  EICRA &= ~(0b11 << ISC00);           // Make sure we trigger on low level.
  EIMSK |= _BV(INT0);                  // Enable IRQ
  xtd::delay(xtd::delay_duration(1));  // Let IRQ trigger if it's already overflowed.
}

void Pump::update_max_duration() {
  // Check results from previous pump activation and adjust max duration.
  if (m_overflowed) {
    // Invariant: Previous duration is always smaller than or equal to max duration.
    // Hence we take the previous duration and reduce it by 1/16h (6.25%) to get a new
    // max duration.
    auto gain = (m_prev_duration.count() + 15) / 16;  // Round up.
    auto new_max = duration(m_prev_duration.count() - gain);
    m_max_duration = new_max > MAX_DURATION_UB ? MAX_DURATION_UB : new_max;
  } else if (m_prev_duration == *m_max_duration) {
    // The previous activation was limited by the max duration; However there was no overflow
    // This means that the max duration is too tight and we can increase it by 1/32th (3.125%).
    auto gain = m_max_duration->count() / 32;  // Round down.
    auto new_max = duration(m_max_duration->count() + gain);
    m_max_duration = new_max < MAX_DURATION_LB ? MAX_DURATION_LB : new_max;
  }
}
