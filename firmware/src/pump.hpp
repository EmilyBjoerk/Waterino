#ifndef GUARD_WATERINO_PUMP_HPP
#define GUARD_WATERINO_PUMP_HPP

#include <xtd_uc/uart.hpp>
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/delay.hpp"

#include "eeprom.hpp"

/*
 * This class controls the pump system.
 *
 * Related signals:
 *  - PUMP : Enables the relay driving 12V to the pump into the reservoir.
 *  - OVERFLOW : IRQ from the pot when water collects in the catchment tray.
 *               May trigger after PUMP goes low as the soil has a delay.
 *               Active Low.
 *  - LEVEL_ALERT : ADC signal from microswitch that can detect if 12V has
 *                  shorted to it.
 *
 * Rules:
 *  - The PUMP may not be activated if OVERFLOW is active.
 *  - The PUMP signal must be immediately driven low if OVERFLOW is asserted.
 *  - The PUMP signal must be immediately driven low if LEVEL_ALERT is outside
 *    of [2.9V +- 0.2V] * 1024/5V = [552, 635].
 *  - The class must be able to recover from EEPROM corruption.
 */
template <typename HAL>
class Pump {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

  constexpr static uint16_t LEVEL_OK_LB = 552;
  constexpr static uint16_t LEVEL_OK_UB = 635;
  constexpr static duration MAX_DURATION_UB = 300_s;
  constexpr static duration MAX_DURATION_LB = 5_s;

  Pump() {
    HAL::pump_stop();

    // Make sure the data in the EEPROM isn't corrupted.
    if (*ee_max_pump_duration > MAX_DURATION_UB) {
      ee_max_pump_duration = MAX_DURATION_UB;
    } else if (*ee_max_pump_duration < MAX_DURATION_LB) {
      ee_max_pump_duration = MAX_DURATION_LB;
    }
  }

  bool water_level_low() {
    return false;  // TODO
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
  bool activate(duration pump_duration) {
    HAL::pump_led_on();

    // We need to check overflow status on the next pumping as the overflow signal may
    // be asserted after we return due to the water not instantly flowing through the soil.
    update_max_duration();
    pump_duration = xtd::min(pump_duration, *ee_max_pump_duration);

    bool m_overflowed = false;
    HAL::sense_overflow_enable_irq(overflow);
    xtd::delay(1_ms);  // Let IRQ trigger if it's already overflowed.
    if (m_overflowed) {
      // We're already overflowed but we're requested to pump (i.e. soil is dry)
      // something is amiss
      HAL::pump_led_off();
      return false;
    }

    // Non-Volatile, if true on RESET we can detect reset due to short circuit (done elsewhere).
    ee_pump_active = true;
    auto start = xtd::chrono::steady_clock::now();
    auto until = start + pump_duration;
    HAL::pump_activate();
    while (!has_overflowed() && xtd::chrono::steady_clock::now() < until) {
      // nop
    }
    HAL::pump_stop();
    reset_pumping();

    // Note: may be shorter than pump_duration if overflow was triggered
    m_prev_duration = xtd::chrono::steady_clock::now() - start;

    // We leave overflow sensing enabled until it is disabled elsewhere as the water can take some
    // time to trickle through the soil into the catchment tray. Then check for the overflow bit on
    // next pumping.
    HAL::pump_led_off();
    return true;
  }

  bool has_overflowed() const { return m_overflowed; }

  // Returns true if non-volatile "is_pumping" flag is set. If this returns true
  // after reset, then the MCU reset due to a fuse tripping during the last pumping.
  bool is_pumping() const { return *ee_pump_active; }

  // Resets the non-volatile "is_pumping" flag. Must be called if `is_pumping()`
  // returns true after reset.
  void reset_pumping() { ee_pump_active = false; }

  void set_max_pump(duration dur) { ee_max_pump_duration = dur; }

  void print_stat() const {
    xtd::ostream<xtd::uart_stream_tag> uart;
    uart << xtd::pstr(PSTR("Pump status: active=")) << (*ee_pump_active)
         << xtd::pstr(PSTR(", max_duration="))
         << xtd::chrono::seconds(*ee_max_pump_duration).count()
         << xtd::pstr(PSTR(" s, prev_duration=")) << xtd::chrono::seconds(m_prev_duration).count()
         << xtd::pstr(PSTR(" s, last_overflowed=")) << m_overflowed << '\n';
  }

private:
  duration m_prev_duration;
  static volatile bool m_overflowed;
  uint8_t m_level_pin;

  // Must only be called from ISR, informs the pump logic that an overflow ocurred.
  static void overflow() {
    HAL::pump_stop();
    HAL::sense_overflow_disable_irq();
    m_overflowed = true;
  }

  // Uses values from previous pumping to update the max pump duration.
  void update_max_duration() {
    // Check results from previous pump activation and adjust max duration.
    auto max_duration = *ee_max_pump_duration;
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
};

template <typename HAL>
constexpr typename Pump<HAL>::duration Pump<HAL>::MAX_DURATION_UB;

template <typename HAL>
constexpr typename Pump<HAL>::duration Pump<HAL>::MAX_DURATION_LB;
#endif
