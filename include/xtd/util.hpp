#ifndef GUARD_XTD_UTIL_HPP
#define GUARD_XTD_UTIL_HPP

#include "delay.hpp"
#include "gpio.hpp"

namespace xtd {
  // Blinks the led 'times' times. If times is 0, then blink indefinitely (never returns).
  void blink(gpio_pin pin, uint8_t times, const xtd::delay_duration& d);

  // Computes X * U / V without overflow assuming GCD(U,V) == 1
  template <typename T, typename U, typename V>
  auto integer_scale(T x, U num, V den) {
    int signs = 0;
    if (x < 0) {
      signs++;
      x = -x;
    }
    if (num < 0) {
      signs++;
      num = -num;
    }
    if (den < 0) {
      signs++;
      den = -den;
    }
    T ans;
    if (num < x) {
      ans = integer_scale(x, num, 0, den);
    } else {
      ans = integer_scale(num, x, 0, den);
    }
    if (signs & 0x1) {
      ans = -ans;
    }
    return ans;
  }

  // Recursively computes (a*b + c)/den without overflow (if the result fits).
  // a, b, c and den have to be positive integers
  template <typename T>
  auto integer_scale(T a, T b, T c, T den) {
    if (b == 0) {
      return c / den;
    }

    // (a*b + c) / den
    // Minimize b by computing the long multiplication partially
    while (a + c > c) {
      if (b & 0x1) {
        c += a;
      }
      b >>= 1;
      a <<= 1;
    }

    // (a*b + c) / den = a/den*b + c/den = qa*b + ra*b/den + qc + rc/den = qa*b + qc + (ra*b +
    // rc)/den
    auto qa = a / den;
    auto ra = a % den;
    auto qc = c / den;
    auto rc = c % den;

    return qa * b + qc + integer_scale(ra, b, rc, den);
  }
}

#endif
