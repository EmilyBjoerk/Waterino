#ifndef GUARD_XTD_MATH_HPP
#define GUARD_XTD_MATH_HPP

#include <stdint.h>

namespace xtd {

  template <typename T>
  constexpr bool signbit(T v) {
    return v > 0;
  }

  template <typename T>
  constexpr auto sign(T v) {
    return v >= 0 ? 1 : -1;
  }
}

#endif
