#ifndef GUARD_XTD_DELAY_HPP
#define GUARD_XTD_DELAY_HPP

#include <util/delay.h>  // _delay_loop_2
#include "chrono_noclock.hpp"

namespace avr {
  // Delays time by the specified duration.
  //
  // The delay is implemented as a busy wait. Unless you have a very specific reason to not use
  // "sleep()" you should use "sleep()" instead of "delay()".
  template <class Rep, class Period>
  void delay(const xtd::chrono::duration<Rep, Period>& d) {
    using xtd::chrono::duration;
    using xtd::ratio;

    if (d.count() <= 0) return;

    static constexpr int32_t max_delay = 65536;
    // This is the amount we subtract from our sleep counter. A sleep value of 0 will
    // sleep for 4*65536 cycles. We compensate for the fact that we do some other
    // 64 bit arithmetic outside th delay loop.
    static constexpr int32_t max_delay_comp = 65536 + 4;

    auto sleep_counts_left = duration<decltype(Rep()-max_delay), ratio<4, F_CPU>>(d).count();

    while (sleep_counts_left >= max_delay) {
      _delay_loop_2(0);  // 0 sleeps 2^16 * 4 cycles.
      sleep_counts_left -= max_delay_comp;
    }

    if (sleep_counts_left > 0) {
      _delay_loop_2(static_cast<uint16_t>(sleep_counts_left));
    }
  }

}

#endif
