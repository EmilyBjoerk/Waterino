#ifndef GUARD_XTD_CHRONO_HPP
#define GUARD_XTD_CHRONO_HPP

#include "chrono_noclock.hpp"

// -----------------------------------------------------------------------------
//
// NOTE: Including "chrono.hpp" will reserve TIMER2 for use by the steady_clock.
//
// To use "chrono.hpp" you must build and link "chrono.cpp"
//
// -----------------------------------------------------------------------------

#include <avr/interrupt.h>

// To allow friend declaration in steady_clock
extern "C" void TIMER2_OVF_vect(void) __attribute__((signal));

namespace xtd {
  namespace chrono {
    class steady_clock {
    public:
      using rep = signed long long;         // Overflows after 18718157 years on 16MHz clock
      using period = ratio<1024UL, F_CPU>;  // [s]
      using duration = xtd::chrono::duration<rep, period>;
      using time_point = xtd::chrono::time_point<steady_clock>;
      using irq_period = ratio_multiply<period, ratio<256>>;

      constexpr static bool is_steady = true;
      static time_point now();

    private:
      steady_clock();

      friend void ::TIMER2_OVF_vect(void);

      static volatile rep ticks;
    };
  }
}

#endif
