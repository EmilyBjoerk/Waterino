#include "xtd/chrono.hpp"

#include <util/atomic.h>
#include "xtd/sfr.hpp"

ISR(TIMER2_OVF_vect) { xtd::chrono::steady_clock::ticks += 256; }

namespace xtd {
  namespace chrono {

    volatile steady_clock::rep steady_clock::ticks = 0;

    steady_clock::steady_clock() {
      ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
        ticks = 0;
        //
        // NOTE: We user Timer/Counter2 because it will keep running operating during most sleep
        // modes. So sleeping the MCU doesn't mess with system time.
        //
        avr::clr_bit(PRR, PRTIM2);  // Enable power to timer 2
        TCCR2A = 0;                 // Normal mode, counter wraps at 0xFF
        TCCR2B = 0b111 << CS20;     // Prescale clock frequency by 1/1024
        TIMSK2 = _BV(TOIE2);        // Overflow interrupt enable for timer 2
        TCNT2 = 0;
      }
    }

    steady_clock::time_point steady_clock::now() {
      static steady_clock clk;  // Initialize on first call

      rep ans;
      ATOMIC_BLOCK(ATOMIC_RESTORESTATE) { ans = ticks; }
      *reinterpret_cast<volatile uint8_t*>(&ans) = TCNT2;
      return time_point(duration(ans));
    }
  }
}
