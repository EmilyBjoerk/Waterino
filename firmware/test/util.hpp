#ifndef GUARD_WATERINO_TEST_UTIL_HPP
#define GUARD_WATERINO_TEST_UTIL_HPP

#include "mock_hardware.hpp"
#include "xtd_uc/chrono.hpp"

#include <chrono>
#include <iostream>
#include <thread>

#include <condition_variable>
#include <mutex>

template <typename T>
class Waitable {
public:
  Waitable(T t) : v(t) {}

  void set(T t) {
    std::unique_lock<std::mutex> ul(m);
    v = t;
    cv.notify_all();
  }

  T get() {
    T ans;
    {
      std::unique_lock<std::mutex> ul(m);
      ans = v;
    }
    return ans;
  }

  template <typename Callable>
  void wait_until(Callable&& pred) {
    std::unique_lock<std::mutex> ul(m);
    cv.wait(ul, [this, pred]() { return pred(v); });
  }

private:
  std::mutex m;
  std::condition_variable cv;
  T v;
};

template <typename val, typename lb, typename ub>
::testing::AssertionResult IsBetweenInclusive(val v, lb l, ub u) {
  if ((v >= l) && (v <= u)) {
    return ::testing::AssertionSuccess();
  }
  return ::testing::AssertionFailure() << v << " is not in [" << l << ", " << u << "]";
}

using xtd_duration = xtd::chrono::steady_clock::duration;
using clock_period = xtd_duration::scale;
using std_duration = std::chrono::duration<long long, std::ratio<clock_period::num, clock_period::den>>;

template <typename Rep, typename Period>
constexpr xtd::chrono::steady_clock::duration std2xtdchrono(std::chrono::duration<Rep, Period> x) {
  return xtd_duration{std::chrono::duration_cast<std_duration>(x).count()};
}

static_assert(1_s == std2xtdchrono(std::chrono::milliseconds(1000)), "");

class AutoJoinable {
public:
  AutoJoinable(std::thread&& t) : th(std::move(t)) {}
  AutoJoinable(AutoJoinable&& a) : th(std::move(a.th)) {}
  ~AutoJoinable() { join(); }
  void join() {
    if (th.joinable()) {
      th.join();
      // std::cout << "joined" << std::endl;
    }
  }

private:
  std::thread th;
};

#endif
