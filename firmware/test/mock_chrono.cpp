#include <chrono>
#include <iostream>
#include <xtd_uc/chrono.hpp>

#include "util.hpp"

namespace xtd {
  namespace chrono {

    steady_clock::time_point steady_clock::now() {
      auto t = std::chrono::steady_clock::now().time_since_epoch();
      return xtd::chrono::steady_clock::time_point(std2xtdchrono(t));
    }
  }  // namespace chrono
}  // namespace xtd
