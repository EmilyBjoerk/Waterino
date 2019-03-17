#ifndef GUARD_WATERINO_PUMP_HPP
#define GUARD_WATERINO_PUMP_HPP

#include "xtd_uc/chrono.hpp"
#include "xtd_uc/cstdint.hpp"

#ifdef ENABLE_TEST
#include <ostream>
#else
#include "xtd_uc/ostream.hpp"
#include "xtd_uc/uart.hpp"
#endif

using namespace xtd::unit_literals;

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
class Pump {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

  constexpr static uint16_t LEVEL_OK_LB = 552;
  constexpr static uint16_t LEVEL_OK_UB = 635;
  constexpr static duration MAX_DURATION_UB = 300_s;
  constexpr static duration MAX_DURATION_LB = 5_s;

#ifdef ENABLE_TEST
  using ostream = std::ostream;
#else
  using ostream = xtd::ostream<xtd::uart_stream_tag>;
#endif

  Pump();

  // Pre-conditions:
  // * Global interrupts are enabled.
  // * ADC is enabled and has been set to use internal_vcc as AVref.
  //
  // Attempts to activate the pump. If the overflow detector is tripped then
  // activate() will fail and return false without activating the pump. Likewise
  // if the water level in the reservoir is low. If a short is detected in the
  // reservoir through the level check then this function will never return and
  // sets the signal LED and rings the buzzer.
  bool activate(duration pump_duration);

  bool has_overflowed() const;

  // Returns true if non-volatile "is_pumping" flag is set. If this returns true
  // after reset, then the MCU reset due to a fuse tripping during the last pumping.
  bool is_pumping() const;

  // Resets the non-volatile "is_pumping" flag. Must be called if `is_pumping()`
  // returns true after reset.
  void reset_pumping();

  void set_max_pump(duration dur);

  void print_stat(ostream& os) const;

private:
  static volatile bool m_overflowed;
  duration m_prev_duration;

  // Must only be called from ISR, informs the pump logic that an overflow ocurred.
  static void overflow();

  // Uses values from previous pumping to update the max pump duration.
  void update_max_duration();
};

#endif
