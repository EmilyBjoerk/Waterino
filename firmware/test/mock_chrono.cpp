#include <chrono>
#include <iostream>
#include <xtd_uc/chrono.hpp>

#include "util.hpp"

namespace xtd {
  namespace chrono {

    std::chrono::steady_clock::time_point mcu_epoch = std::chrono::steady_clock::now();

    steady_clock::time_point steady_clock::now() {
      auto t_raw = std::chrono::steady_clock::now() - mcu_epoch;
      auto t_ms = std::chrono::duration_cast<std::chrono::milliseconds>(t_raw);
      return steady_clock::time_point(milliseconds(t_ms.count()));
    }
  }  // namespace chrono
}  // namespace xtd
