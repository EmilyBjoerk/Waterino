#ifndef GUARD_WATERINO_IPUMP_HPP
#define GUARD_WATERINO_IPUMP_HPP

#include "xtd_uc/cstdint.hpp"
#include "xtd_uc/chrono.hpp"

class IErrorReporter;

class IPump {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

  // Pre-conditions:
  // * Global interrupts are enabled.
  // * ADC is enabled and has been set to use internal_vcc as AVref.
  //
  // Attempts to activate the pump. If the overflow detector is tripped then
  // activate() will fail and return false without activating the pump. Likewise
  // if the water level in the reservoir is low. If a short is detected in the
  // reservoir through the level check then this function will never return and
  // sets the signal LED and rings the buzzer.
  virtual bool activate(duration duration, IErrorReporter& errors) = 0;

  // Must only be called from ISR, informs the pump logic that an overflow ocurred.
  virtual void overflow() = 0;

  virtual bool has_overflowed() const = 0;

  // Returns true if non-volatile "is_pumping" flag is set. If this returns true
  // after reset, then the MCU reset due to a fuse tripping during the last pumping.
  virtual bool is_pumping() const = 0;

  // Resets the non-volatile "is_pumping" flag. Must be called if `is_pumping()`
  // returns true after reset.
  virtual void reset_pumping() = 0;

  virtual void set_max_pump(duration dur) = 0;

  virtual void print_stat() const = 0;
};

#endif
