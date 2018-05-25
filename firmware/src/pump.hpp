#ifndef GUARD_WATERINO_PUMP_HPP
#define GUARD_WATERINO_PUMP_HPP

#include "xtd_uc/chrono.hpp"
#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/gpio.hpp"

#include "ierrorreporter.hpp"
#include "ipump.hpp"

using namespace xtd::chrono_literals;

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
class Pump : public IPump {
public:
  constexpr static uint16_t LEVEL_OK_LB = 552;
  constexpr static uint16_t LEVEL_OK_UB = 635;
  constexpr static duration MAX_DURATION_UB = 5_min;
  constexpr static duration MAX_DURATION_LB = 5_s;

  Pump(xtd::gpio_pin pump_pin, uint8_t level_pin, duration* eeprom_max_duration_address,
       bool* eeprom_active_address);

  // Pre-conditions:
  // * Global interrupts are enabled.
  // * ADC is enabled and has been set to use internal_vcc as AVref.
  //
  // Attempts to activate the pump. If the overflow detector is tripped then
  // activate() will fail and return false without activating the pump. Likewise
  // if the water level in the reservoir is low. If a short is detected in the
  // reservoir through the level check then this function will never return and
  // sets the signal LED and rings the buzzer.
  bool activate(duration duration, IErrorReporter& errors) override;

  // Must only be called from ISR, informs the pump logic that an overflow ocurred.
  void overflow() override;

  bool has_overflowed() const override;

  // Returns true if non-volatile "is_pumping" flag is set. If this returns true
  // after reset, then the MCU reset due to a fuse tripping during the last pumping.
  bool is_pumping() const override;

  // Resets the non-volatile "is_pumping" flag. Must be called if `is_pumping()`
  // returns true after reset.
  void reset_pumping() override;

  void set_max_pump(duration dur) override;

  void print_stat() const override;

private:
  xtd::eeprom<bool> m_active;
  xtd::eeprom<duration> m_max_duration;
  duration m_prev_duration;
  xtd::gpio_pin m_pump_pin;
  volatile bool m_overflowed = false;
  uint8_t m_level_pin;

  // Pre-conditions:
  // * ADC is enabled and has been configured to use internal_vcc as reference.
  Result water_level() const;

  void enable_overflow_irq();

  // Uses values from previous pumping to update the max pump duration.
  void update_max_duration();
};

#endif
