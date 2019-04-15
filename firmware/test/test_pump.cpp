#include "../src/pump.hpp"

#include "util.hpp"
#include "xtd_uc/eeprom.hpp"

#include <pthread.h>

using namespace ::testing;
using namespace std::chrono_literals;

extern xtd::eemem<bool> ee_pump_active;
extern xtd::eemem<xtd::chrono::steady_clock::duration> ee_max_pump_duration;

class TestPump : public ::testing::Test {
protected:
  void SetUp() override { mock_hardware.reset(new ::testing::NiceMock<MockHardware>()); }
  void TearDown() override { mock_hardware.reset(); }

  auto cleanCut() {
    Pump cut;
    EXPECT_TRUE(::testing::Mock::VerifyAndClearExpectations(mock_hardware.get()));
    return cut;
  }

  void expectPumpActivation(bool expect_overflow) {
    pump_enabled_time = std::chrono::steady_clock::now();
    pump_disabled_time = pump_enabled_time;

    Expectation led_on = EXPECT_CALL(*mock_hardware, pump_led_on());
    Expectation overflow_en =
        EXPECT_CALL(*mock_hardware, sense_overflow_enable_irq(_))
            .After(led_on)
            .WillOnce(Invoke([this](HAL::callback_void_t cb) { overflow_callback.set(cb); }));
    Expectation pump_on = EXPECT_CALL(*mock_hardware, pump_activate())
                              .After(overflow_en)
                              .WillOnce(InvokeWithoutArgs([this]() {
                                pump_enabled_time = std::chrono::steady_clock::now();
                              }));

    Expectation pump_off = EXPECT_CALL(*mock_hardware, pump_stop())
                               .Times(AtLeast(1))
                               .After(pump_on)
                               .WillRepeatedly(InvokeWithoutArgs([this]() {
                                 if (pump_disabled_time <= pump_enabled_time) {
                                   pump_disabled_time = std::chrono::steady_clock::now();
                                 }
                               }));

    if (expect_overflow) {
      Expectation overflow_di = EXPECT_CALL(*mock_hardware, sense_overflow_disable_irq())
                                    .Times(AtLeast(1))
                                    .After(pump_off);
    }
    Expectation led_off = EXPECT_CALL(*mock_hardware, pump_led_off()).After(pump_off);
  }

  auto pumpActiveDuration() const { return pump_disabled_time - pump_enabled_time; }

  auto triggerOverflowAfter(const std::chrono::high_resolution_clock::duration& delay) {
    overflow_callback.set(nullptr);
    std::thread overflow_timer([this, delay]() {
      overflow_callback.wait_until([](HAL::callback_void_t cb) { return nullptr != cb; });
      std::this_thread::sleep_for(delay);
      overflow_callback.get()();
    });

    sched_param p;
    p.sched_priority = -20;
    pthread_setschedparam(overflow_timer.native_handle(), SCHED_FIFO, &p);

    return AutoJoinable(std::move(overflow_timer));
  }

  // Performs a test where:
  // 1) The pump is requested to be activated for the given amount of time.
  // 2) The duration is (possibly) capped by the max duration.
  // 3) Asynchronously an overflow triggers after another amount of time.
  // 4) The actual pump active duration is measured.
  void RunWithOverflow(Pump& cut, xtd_duration pump_duration,
                       xtd_duration expected_pump_duration,  //
                       std_duration time_until_overflow) {
    auto overflow_timer = triggerOverflowAfter(time_until_overflow);
    RunWithoutOverflow(cut, pump_duration, expected_pump_duration);
    overflow_timer.join();
    ASSERT_TRUE(cut.has_overflowed());
  }

  void RunWithoutOverflow(Pump& cut, xtd_duration pump_duration,
                          xtd_duration expected_pump_duration, bool actuall_overflow = false) {
    expectPumpActivation(actuall_overflow);

    // Execute & Verify first activation
    ASSERT_TRUE(cut.activate(pump_duration));
    ASSERT_FALSE(cut.is_pumping());
    ASSERT_TRUE(IsBetweenInclusive(std2xtdchrono(pumpActiveDuration()),  //
                                   expected_pump_duration - 10_ms,       //
                                   expected_pump_duration + 10_ms));

    // Verify success so that we can run another step directly after.
    ASSERT_TRUE(::testing::Mock::VerifyAndClearExpectations(mock_hardware.get()));
  }

  Waitable<HAL::callback_void_t> overflow_callback{nullptr};

  std::chrono::steady_clock::time_point pump_enabled_time;
  std::chrono::steady_clock::time_point pump_disabled_time;
};

TEST_F(TestPump, StartUp_PumpWasActive) {
  ee_pump_active = true;
  EXPECT_CALL(*mock_hardware, pump_stop()).Times(1);
  EXPECT_CALL(*mock_hardware, pump_led_off()).Times(1);

  Pump cut;
  ASSERT_TRUE(cut.is_pumping());
  cut.reset_pumping();

  ASSERT_FALSE(ee_pump_active.get());
  ASSERT_FALSE(cut.is_pumping());
}

TEST_F(TestPump, StartUp_EEMaxPumpDurationTooLarge) {
  ee_max_pump_duration = 10_days;

  Pump cut;

  ASSERT_EQ(Pump::MAX_DURATION_UB, ee_max_pump_duration.get());
}

TEST_F(TestPump, StartUp_EEMaxPumpDurationNegative) {
  ee_max_pump_duration = -1_s;

  Pump cut;

  ASSERT_EQ(Pump::MAX_DURATION_LB, ee_max_pump_duration.get());
}

TEST_F(TestPump, StartUp_EEMaxPumpDurationTooSmall) {
  ee_max_pump_duration = 1_s;

  Pump cut;

  ASSERT_EQ(Pump::MAX_DURATION_LB, ee_max_pump_duration.get());
}

TEST_F(TestPump, SetMaxPumpDuration) {
  ee_max_pump_duration = 30_s;

  Pump cut;

  cut.set_max_pump(1_min);

  ASSERT_EQ(1_min, ee_max_pump_duration.get());
}

TEST_F(TestPump, SetMaxPumpDuration_TooLarge) {
  ee_max_pump_duration = 30_s;

  Pump cut;

  cut.set_max_pump(10_days);

  ASSERT_EQ(Pump::MAX_DURATION_UB, ee_max_pump_duration.get());
}

TEST_F(TestPump, SetMaxPumpDuration_Negative) {
  ee_max_pump_duration = 30_s;

  Pump cut;

  cut.set_max_pump(-1_s);

  ASSERT_EQ(Pump::MAX_DURATION_LB, ee_max_pump_duration.get());
}

TEST_F(TestPump, SetMaxPumpDuration_TooSmall) {
  ee_max_pump_duration = 30_s;

  Pump cut;

  cut.set_max_pump(1_s);

  ASSERT_EQ(Pump::MAX_DURATION_LB, ee_max_pump_duration.get());
}

// Test the scenario that the previous pumping overflowed significantly and
// the overflow sensor is still active. Attempt to activate the pump should
// not pump any water, and leave the max_pump_duration untouched as the
// activation didn't give any useful information on which to base the change
// on.
TEST_F(TestPump, Activate_OverflowImmediately) {
  const auto time_to_pump = xtd::chrono::steady_clock::duration(1_s);
  const auto max_pump_time = time_to_pump + 1_s;  // No clamp
  const auto new_max_pump_time = max_pump_time;

  auto cut = cleanCut();

  EXPECT_CALL(*mock_hardware, pump_activate()).Times(0);
  {
    ::testing::InSequence s;
    EXPECT_CALL(*mock_hardware, pump_led_on()).Times(1);
    EXPECT_CALL(*mock_hardware, sense_overflow_enable_irq(_)).WillOnce(InvokeArgument<0>());
    EXPECT_CALL(*mock_hardware, sense_overflow_disable_irq()).Times(1);
    EXPECT_CALL(*mock_hardware, pump_led_off()).Times(1);
  }

  ee_max_pump_duration = max_pump_time;
  auto result = cut.activate(time_to_pump);

  ASSERT_FALSE(result);
  ASSERT_TRUE(cut.has_overflowed());
  ASSERT_FALSE(cut.is_pumping());
  ASSERT_FALSE(ee_pump_active.get());
  ASSERT_EQ(ee_max_pump_duration.get(), new_max_pump_time);
}

// Test the typical overflow scenario where the pump is started and while we are actively pumping
// the overflow sensor trips. The pump should be immediately killed and the max pump duration capped
// to slightly below the requested duration on the next activation.
TEST_F(TestPump, Activate_OverflowDuringPumping) {
  constexpr auto time_until_overflow = 2s;
  constexpr auto pump_duration = 6_s;
  constexpr auto pump_duration_expected = std2xtdchrono(time_until_overflow);

  auto cut = cleanCut();
  ee_max_pump_duration = pump_duration + 1_s;  // No clamp
  RunWithOverflow(cut, pump_duration, pump_duration_expected, time_until_overflow);

  const auto pump_duration_new_max = std2xtdchrono(time_until_overflow) * 15 / 16;
  const auto pump_duration_new_expected = pump_duration_new_max;  // Clamped by prev. overflow
  RunWithoutOverflow(cut, pump_duration, pump_duration_new_expected);

  ASSERT_FALSE(cut.has_overflowed());
  ASSERT_TRUE(IsBetweenInclusive(ee_max_pump_duration.get(),  //
                                 pump_duration_new_max - 10_ms, pump_duration_new_max + 10_ms));
}

// Test a common scenario where the overflow signal is delayed until some time after the pump stops
// as there is a short delay before the water runs through the soil.
TEST_F(TestPump, Activate_OverflowAfterPumping) {
  constexpr auto time_until_overflow = 3s;
  constexpr auto pump_duration = xtd_duration(2_s);  // Use clock cycles
  constexpr auto pump_duration_expected = pump_duration;

  auto cut = cleanCut();
  ee_max_pump_duration = pump_duration + 1_s;  // No clamp
  RunWithOverflow(cut, pump_duration, pump_duration_expected, time_until_overflow);

  constexpr auto next_pump_duration = 3_s;
  constexpr auto next_pump_duration_expected =
      pump_duration_expected * 15 / 16;  // Clamped from previous run
  constexpr auto next_pump_duration_max =
      next_pump_duration_expected;  // Didn't overflow, slightly grown activation after next
  RunWithoutOverflow(cut, next_pump_duration, next_pump_duration_expected);

  ASSERT_FALSE(cut.has_overflowed());
  ASSERT_TRUE(IsBetweenInclusive(ee_max_pump_duration.get(), next_pump_duration_max - 10_ms,
                                 next_pump_duration_max + 10_ms));
}

// Expect that if the pumping duration is clipped by the max but still doesn't overflow.
TEST_F(TestPump, Activate_ClippMaxNoOverflow) {
  ee_max_pump_duration = Pump::MAX_DURATION_LB;
  auto cut = cleanCut();

  const auto pump_duration = ee_max_pump_duration.get() + 1_s;
  const auto pump_duration_expected = ee_max_pump_duration.get();
  RunWithoutOverflow(cut, pump_duration, pump_duration_expected);

  ASSERT_TRUE(IsBetweenInclusive(ee_max_pump_duration.get(), pump_duration_expected - 10_ms,
                                 pump_duration_expected + 10_ms));

  const auto next_pump_duration_limit = Pump::MAX_DURATION_LB + Pump::MAX_DURATION_LB /32;
  RunWithoutOverflow(cut, pump_duration, next_pump_duration_limit);
  ASSERT_EQ(ee_max_pump_duration.get(), next_pump_duration_limit);
}

TEST_F(TestPump, Activate_ClippLB) {
  ee_max_pump_duration = Pump::MAX_DURATION_LB;
  auto cut = cleanCut();

  const auto overflow_after = std::chrono::duration_cast<std_duration>(500ms);
  const auto pump_duration = ee_max_pump_duration.get() + 1_s;
  const auto pump_duration_expected = std2xtdchrono(overflow_after);
  RunWithOverflow(cut, pump_duration, pump_duration_expected, overflow_after);

  // Run once more to make LB update
  RunWithOverflow(cut, pump_duration, pump_duration_expected, overflow_after);

  ASSERT_EQ(ee_max_pump_duration.get(), Pump::MAX_DURATION_LB);
}
