#ifndef GUARD_WATERINO_XTD_ALGORITHM_HPP
#define GUARD_WATERINO_XTD_ALGORITHM_HPP

namespace xtd {
  template <class T>
  constexpr const T& max(const T& a, const T& b) {
    return a < b ? b : a;
  }

  template <class T>
  constexpr const T& min(const T& a, const T& b) {
    return a < b ? a : b;
  }

  template <class T>
  constexpr const T abs(T a) {
    return a < 0 ? -a : a;
  }

  template <class T>
  constexpr const T avg(T smaller, T bigger) {
    return smaller + (bigger - smaller) / 2;
  }
}

#endif
