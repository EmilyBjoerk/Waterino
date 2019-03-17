#include <chrono>
#include <xtd_uc/chrono.hpp>

namespace xtd {
  namespace chrono {

    steady_clock::time_point steady_clock::now() {
      auto n = std::chrono::duration_cast<std::chrono::nanoseconds>(
                   std::chrono::steady_clock::now().time_since_epoch())
                   .count();
      return time_point(xtd::chrono::nanoseconds(n));
    }
  }  // namespace chrono
}  // namespace xtd
