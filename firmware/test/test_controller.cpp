#include "../src/controller.hpp"
#include <xtd_uc/iterables.hpp>

#include <gtest/gtest.h>
#include <cmath>
#include <stdexcept>
#include <utility>


using time_point = Controller::time_point;
using duration = Controller::duration;

constexpr double duration_to_s(const duration& d) {
  return d.count() * duration::scale::num / duration::scale::den;
}

struct SimulationEventLog {
  SimulationEventLog(const time_point& t, double a, double b, double c)
      : time(t), water_mass_ml(a), pumped_mass_ml(b), evaporated(c) {}
  time_point time;
  double water_mass_ml;
  double pumped_mass_ml;
  double evaporated;

  friend std::ostream& operator<<(std::ostream& os, const SimulationEventLog& d) {
    return os << d.time << " water: " << d.water_mass_ml << " pumped: " << d.pumped_mass_ml
              << " evaporated: " << d.evaporated;
  }
};

struct SimulationResults {
  SimulationResults(double final_period_h_, time_point convergence_time_, double overshoot_pct_)
      : final_period_h(final_period_h_),
        overshoot_pct(overshoot_pct_),
        convergence_time(convergence_time_) {}
  double final_period_h;
  double overshoot_pct;
  time_point convergence_time;
};

class WateringSimulator {
public:
  WateringSimulator(Controller& cut_, const duration& time_, const duration& step_,
                    double initial_mass_ml_, double threshold_ml_, double pump_rate_ml_s_)
      : threshold_ml(threshold_ml_),
        initial_mass_ml(initial_mass_ml_),
        pump_rate_ml_s(pump_rate_ml_s_),
        end_time(time_),
        step(step_),
        cut(cut_) {}

  virtual double evaporate(double mass_ml, const duration& time) const = 0;

  std::vector<SimulationEventLog> run(bool print_log = false) {
    std::vector<SimulationEventLog> log;
    double water_mass_ml = initial_mass_ml;
    for (time_point now = time_point(0_s); now < end_time; now = now + step) {
      auto added_mass = 0.0;

      // Act at 't'
      if (water_mass_ml < threshold_ml) {
        auto pump_duration = cut.compute(now);
        cut.report_activation(now);
        if (print_log) {
          cut.print_stat(std::cout, now);
        }
        added_mass = pump_rate_ml_s * duration_to_s(pump_duration);
      }

      // Time passes to 't+1'
      auto evaporated = evaporate(water_mass_ml, step);
      log.emplace_back(now, water_mass_ml, added_mass, evaporated);
      water_mass_ml = water_mass_ml + added_mass - evaporated;
    }
    return log;
  }

  static duration longest_watering_period(const std::vector<SimulationEventLog>& log) {
    duration max_period{0};
    auto previous_watering = log.end();
    auto it = log.begin() + 1;

    while (it != log.end()) {
      if (it->pumped_mass_ml > 0.0) {
        if (previous_watering != log.end()) {
          auto period = it->time - previous_watering->time;
          if (period > max_period) {
            max_period = period;
          }
        }
        previous_watering = it;
      }
      it++;
    }
    return max_period;
  }

  // Returns {converged period, time to convergence, overshoot % above dt_max}
  SimulationResults compute_convergence(const std::vector<SimulationEventLog>& log,
                                        const duration& dt_min, const duration& dt_max,
                                        bool print_log = false) const {
    const auto overshoot_pct =
        duration_to_s(longest_watering_period(log) - dt_max) / duration_to_s(dt_max);

    constexpr auto never = time_point{-1};

    auto sum_h = 0.0;
    auto samples = 0;
    auto last_watering = never;
    for (auto& entry : xtd::reverse(log)) {
      if (entry.pumped_mass_ml <= 0) {
        continue;  // Skip over every entry where there were no watering action
      }

      if (last_watering != never) {
        auto period = last_watering - entry.time;
        if (print_log) {
          std::cout << "dT=" << period << " -- " << entry << std::endl;
        }
        if (period < dt_min || dt_max < period) {
          // Cutoff thresholds exceeded
          return {sum_h / samples, last_watering, overshoot_pct};
        }

        samples++;
        sum_h += duration_to_s(period) / 3600.0;
      }

      last_watering = entry.time;
    }
    return {samples ? sum_h / samples : -1, never, overshoot_pct};
  }

private:
  double threshold_ml;
  double initial_mass_ml;
  double pump_rate_ml_s;
  time_point end_time;
  duration step;
  Controller& cut;
};

class LinearEvaporationWateringSimulator : public WateringSimulator {
public:
  LinearEvaporationWateringSimulator(Controller& cut_, const duration& time_, const duration& step_,
                                     double initial_mass_ml_, double threshold_ml_,
                                     double pump_rate_ml_s_, double evaporation_rate_ml_s_)
      : WateringSimulator(cut_, time_, step_, initial_mass_ml_, threshold_ml_, pump_rate_ml_s_),
        evaporation_rate_ml_s(evaporation_rate_ml_s_) {}

  virtual double evaporate(double, const duration& time) const override {
    return duration_to_s(time) * evaporation_rate_ml_s;
  }

private:
  double evaporation_rate_ml_s;
};

class DifferentialEvaporationWateringSimulator : public WateringSimulator {
public:
  DifferentialEvaporationWateringSimulator(Controller& cut_, const duration& time_,
                                           const duration& step_, double initial_mass_ml_,
                                           double threshold_ml_, double pump_rate_ml_s_,
                                           double evaporation_pct_s_)
      : WateringSimulator(cut_, time_, step_, initial_mass_ml_, threshold_ml_, pump_rate_ml_s_),
        evaporation_pct_s(evaporation_pct_s_) {}

  virtual double evaporate(double mass, const duration& time) const override {
    return duration_to_s(time) * evaporation_pct_s * mass;
  }

private:
  double evaporation_pct_s;
};

TEST(TestController, FirstActivation) {
  float kp = 3.0f;
  float ki = 3.0f;
  float si = 2.0f;
  duration target_period = 200_h;

  Controller cut(kp, ki, si, target_period);

  const auto now = time_point(10_s);  // Arbitrary time
  const auto expected = duration(Controller::default_duration.count() * (1 + ki * si));
  ASSERT_EQ(expected, cut.compute(now));
}

TEST(TestController, ControlDirection) {
  float kp = 3.0f;
  float ki = 3.0f;
  float si = 2.0f;
  duration target_period = 200_h;

  Controller cut(kp, ki, si, target_period);

  auto d1 = cut.compute(time_point(1_h));
  cut.report_activation(time_point(1_h));

  // Time between first and second activation is much shorter than the target
  // period. The amount of water given should increase: d2 > d1
  ASSERT_GT(cut.compute(time_point(100_h)), d1);

  // ...other way around
  ASSERT_LT(cut.compute(time_point(300_h)), d1);
}

TEST(TestController, LinearSimulationMediumPot) {
  float kp = 10.0f;
  float ki = 19.0f;
  float si = 0.0f;
  duration target_period = 3_days;

  Controller cut(kp, ki, si, target_period);

  // Used to dimension the other parameters
  constexpr auto pot_capacity = 500.0;  // ml
  constexpr auto pot_dry_time = 5_days;

  // Assume 100ml/min pump:
  constexpr auto pump_rate_s = (100.0 / 60.0);
  constexpr auto evaporation_ml_s = pot_capacity / duration_to_s(pot_dry_time);  // ml/s
  constexpr auto pot_level = pot_capacity / 2.0;
  constexpr auto threshold = pot_capacity / 5.0;

  auto simulator = LinearEvaporationWateringSimulator(cut, 4000_h, 1_h, pot_level, threshold,
                                                      pump_rate_s, evaporation_ml_s);
  auto log = simulator.run();
  auto result = simulator.compute_convergence(log, target_period - 1_h, target_period + 1_h);

  ASSERT_NEAR(xtd::chrono::hours(target_period).count(), result.final_period_h, 20.0 / 60.0);
  ASSERT_LT(result.overshoot_pct, 0.03);
  ASSERT_LT(result.convergence_time, time_point(10_days));
}

TEST(TestController, DifferentialSimulationMediumPot) {
  float kp = 10.0f;
  float ki = 19.0f;
  float si = 0.0f;
  duration target_period = 3_days;

  Controller cut(kp, ki, si, target_period);

  // Used to dimension the other parameters
  constexpr auto pot_capacity = 500.0;  // ml
  constexpr auto pot_dry_time = 5_days;

  // Assume 100ml/min pump:
  constexpr auto pump_rate_s = (100.0 / 60.0);

  // Let dx/dt = -cx(t) where 'c' is the rate of evaporation in pct, and 'x' is the amount of water.
  // Solving the differential equation with the bi-condition x(0) = I, the initial mass yields:
  // x(t) = Ie^(-ct)  solving for the rate where only 'K' percent of the initial water remains after
  // t: c = ln(K)/-t
  const auto evaporation_pct_h = -std::log(0.05) / duration_to_s(pot_dry_time);  // ml/s
  constexpr auto pot_level = pot_capacity / 2.0;
  constexpr auto threshold = pot_capacity / 5.0;

  auto simulator = DifferentialEvaporationWateringSimulator(cut, 4000_h, 1_h, pot_level, threshold,
                                                            pump_rate_s, evaporation_pct_h);
  auto log = simulator.run();
  auto result = simulator.compute_convergence(log, target_period - 3_h, target_period + 3_h);

  ASSERT_NEAR(xtd::chrono::hours(target_period).count(), result.final_period_h, 1.0);
  ASSERT_LT(result.overshoot_pct, 0.03);
  ASSERT_LT(result.convergence_time, time_point(40_days));
}
