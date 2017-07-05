#ifndef GUARD_XTD_SLEEP_HPP
#define GUARD_XTD_SLEEP_HPP

#include <avr/sleep.h>
#include "xtd/chrono.hpp"
#include "xtd/delay.hpp"

namespace xtd {
  // Sleeps the MCU for the desired time.
  //
  // Largest sleep possible is dictated by xtd::chrono::steady_clock::duration.
  //
  // The precision of the sleep is dictated by the precision of xtd::chrono::steady_clock,
  // for a 16MHz MCU this is 64µs. If you need higher precision than what sleep can provide on your
  // MCU, you need to use `delay()`.
  //
  // Calling sleep will enter a low power mode. The sleep command is not as accurate as delay()
  // since delay is a timed busy wait and sleep() relieas on the xtd::chrono::steady_clock which
  // isn't wall time and may be affected by other long running interrupt service routines or long
  // regions where interrupts are disabled.
  //
  // If "deep==false", then only the cpu clock and flash clock will be halted. All I/O peripheral
  // clocks and interrupts will still be processed. (IDLE mode in AVR data sheets)
  // If "deep==true" a deeper sleep state will be entered where only external interrupts, TWI and
  // Watchdog will wake the device. Other I/O such as USART will not process (Power-save mode in
  // AVR data sheets).
  //
  // ISRs will be serviced in accordance to the deep mode flag but the call will not return until
  // the full duration has been slept.
  void sleep(const xtd::chrono::steady_clock::duration& d, bool deep = false);
}

#endif
