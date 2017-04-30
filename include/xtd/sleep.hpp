#ifndef GUARD_XTD_SLEEP_HPP
#define GUARD_XTD_SLEEP_HPP

#include "xtd/chrono.hpp"
#include "xtd/delay.hpp"

namespace avr {
  // Sleeps the MCU for the desired time.
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
  template <class Rep, class Period>
  void sleep(const xtd::chrono::duration<Rep, Period>& d, bool deep = false) {
    using xtd::chrono::steady_clock;
    using xtd::chrono::duration;

    auto start = steady_clock::now();

    // Both Idle and Power-save modes will wake the device on Timer/Counter2 interrupt.
    // Calling xtd::steady_clock::now() above will enable Timer/Counter2.
    // Thus the device will wake from the sleep every "steady_clock::irq_period" seconds.
    //
    // Power-save mode is selected by passing "deep=true".

    auto safe_sleep_limit = start + (d - duration<int8_t, steady_clock::irq_period>(1));

    // Set mode and enable sleep mode
    set_sleep_mode(deep ? SLEEP_MODE_PWR_SAVE : SLEEP_MODE_IDLE);

    sleep_enable();
    while (steady_clock::now() < safe_sleep_limit) {
      // Interrupts may make each sleep shorter than the irq_period.
      // Because of this dead counting wount work.
      sleep_cpu();
    }
    sleep_disable();

    // Busy wait the remainder
    delay(d - (steady_clock::now() - start));
  }
}

#endif
