#include "../src/controller.hpp"

#include <gtest/gtest.h>
#include <cmath>

using namespace xtd::chrono_literals;
using time_point = Controller::time_point;
using duration = Controller::duration;

TEST(Controller, FirstActivation) {
  float kp = 3.0f;
  float ki = 3.0f;
  float si = 2.0f;
  duration target_period = 200_h;

  Controller cut(&kp, &ki, &si, &target_period);

  const auto now = time_point(10_s);  // Arbitrary time
  const auto expected = duration(Controller::default_duration.count() * (1 + ki * si));
  ASSERT_EQ(expected, cut.compute(now));
}

TEST(Controller, ControlDirection) {
  float kp = 3.0f;
  float ki = 3.0f;
  float si = 2.0f;
  duration target_period = 200_h;

  Controller cut(&kp, &ki, &si, &target_period);

  auto d1 = cut.compute(time_point(1_h));
  cut.report_activation(time_point(1_h));

  // Time between first and second activation is much shorter than the target
  // period. The amount of water given should increase: d2 > d1
  ASSERT_GT(cut.compute(time_point(100_h)), d1);

  // ...other way around
  ASSERT_LT(cut.compute(time_point(300_h)), d1);
}

constexpr auto duration_to_s(const duration& d) {
  return static_cast<double>(d.count()) * duration::period::num / duration::period::den;
}

struct SimulationEventLog {
  SimulationEventLog(const time_point& t, double a, double b, double c)
      : time(t), water_mass_ml(a), pumped_mass_ml(b), evaporated(c) {}
  time_point time;
  double water_mass_ml;
  double pumped_mass_ml;
  double evaporated;

  friend std::ostream& operator<<(std::ostream& os, const SimulationEventLog& d) {
    return os << d.time.time_since_epoch() << " water: " << d.water_mass_ml
              << " pumped: " << d.pumped_mass_ml << " evaporated: " << d.evaporated;
  }
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

  std::vector<SimulationEventLog> run() {
    std::vector<SimulationEventLog> log;
    double water_mass_ml = initial_mass_ml;
    for (time_point now = time_point(0_s); now < end_time; now = now + step) {
      auto added_mass = 0.0;

      // Act at 't'
      if (water_mass_ml < threshold_ml) {
        auto pump_duration = cut.compute(now);
        cut.report_activation(now);
        added_mass = pump_rate_ml_s * duration_to_s(pump_duration);
      }

      // Time passes to 't+1'
      auto evaporated = evaporate(water_mass_ml, step);
      log.emplace_back(now, water_mass_ml, added_mass, evaporated);
      water_mass_ml = water_mass_ml + added_mass - evaporated;
    }
    return log;
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

TEST(Controller, ConvergenceSimulation) {
  float kp = 3.0f;
  float ki = 12.0f;
  float si = 0.0f;
  duration target_period = 3_days;

  Controller cut(&kp, &ki, &si, &target_period);

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

  // Over the last 10 times we expect the mean to be close to target_period
  auto it = log.rbegin();
  auto sum_h = 0.0;
  constexpr auto samples = 10;
  auto samples_left = samples;
  constexpr auto no_time = time_point(0_s);
  auto last_watering = no_time;
  while (samples_left > 0 && it != log.rend()) {
    if (it->pumped_mass_ml > 0.0) {
      std::cout << (*it) << std::endl;
      if (last_watering != no_time) {
        auto elapsed = last_watering - it->time;
        sum_h += duration_to_s(elapsed) / 3600.0;
        samples_left--;
      }
      last_watering = it->time;
    }
    it++;
  }

  auto avg_tail_period = sum_h / samples;
  auto expected_period = xtd::chrono::hours(target_period);
  std::cout << target_period << " : " << expected_period << std::endl;
  ASSERT_NEAR(expected_period.count(), avg_tail_period, 0.0);
}
