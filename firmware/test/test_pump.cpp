#include "../src/pump.hpp"

#include "mock_hardware.hpp"
#include "xtd_uc/eeprom.hpp"

#include <chrono>
#include <thread>

extern xtd::eemem<bool> ee_pump_active;
extern xtd::eemem<xtd::chrono::steady_clock::duration> ee_max_pump_duration;

using namespace ::testing;
using ::testing::InvokeArgument;
using ::testing::Return;
using namespace std::chrono_literals;

template <typename T>
auto toMs(const T& t) {
  return std::chrono::duration_cast<std::chrono::nanoseconds>(t).count() / 1000000.0;
}

class AutoJoinable {
public:
  AutoJoinable(std::thread&& t) : th(std::move(t)) {}
  AutoJoinable(AutoJoinable&& a) : th(std::move(a.th)) {}
  ~AutoJoinable() { join(); }
  void join() { th.join(); }

private:
  std::thread th;
};

class TestPump : public ::testing::Test {
protected:
  void SetUp() override { mock_hardware.reset(new ::testing::NiceMock<MockHardware>()); }
  void TearDown() override { mock_hardware.reset(); }

  auto cleanCut() {
    Pump cut;
    EXPECT_TRUE(::testing::Mock::VerifyAndClearExpectations(mock_hardware.get()));
    return cut;
  }

  void expectPumpActivation() {
    pump_enabled_time = std::chrono::steady_clock::now();
    pump_disabled_time = pump_enabled_time;

    ::testing::InSequence s;
    EXPECT_CALL(*mock_hardware, pump_led_on());
    EXPECT_CALL(*mock_hardware, sense_overflow_enable_irq(_))
        .WillRepeatedly(SaveArg<0>(&overflow_callback));
    EXPECT_CALL(*mock_hardware, pump_activate()).WillOnce(InvokeWithoutArgs([this]() {
      pump_enabled_time = std::chrono::steady_clock::now();
    }));
    EXPECT_CALL(*mock_hardware, pump_stop())
        .Times(AtLeast(1))
        .WillRepeatedly(InvokeWithoutArgs([this]() {
          if (pump_disabled_time <= pump_enabled_time) {
            pump_disabled_time = std::chrono::steady_clock::now();
          }
        }));
    EXPECT_CALL(*mock_hardware, sense_overflow_disable_irq()).Times(AtLeast(1));
    EXPECT_CALL(*mock_hardware, pump_led_off());
  }

  auto pumpActiveDuration() const { return pump_disabled_time - pump_enabled_time; }

  volatile HALProbe::callback_void_t overflow_callback = nullptr;
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

TEST_F(TestPump, Activate_OverflowImmediately) {
  auto cut = cleanCut();

  // Don't activate pump if the overflow signal is triggered immediately
  EXPECT_CALL(*mock_hardware, pump_activate()).Times(0);

  {
    ::testing::InSequence s;
    EXPECT_CALL(*mock_hardware, pump_led_on()).Times(1);
    EXPECT_CALL(*mock_hardware, sense_overflow_enable_irq(_)).WillOnce(InvokeArgument<0>());
    EXPECT_CALL(*mock_hardware, sense_overflow_disable_irq()).Times(1);
    EXPECT_CALL(*mock_hardware, pump_led_off()).Times(1);
  }

  auto result = cut.activate(10_s);
  ASSERT_FALSE(result);
  ASSERT_FALSE(cut.is_pumping());
  ASSERT_FALSE(ee_pump_active.get());

  // FIXME: What should happen to the max pump duration if we overflow immediately.
  // What does that imply?
}

auto triggerOverflowAfter(volatile HALProbe::callback_void_t& overflow_callback,
                          const std::chrono::high_resolution_clock::duration& delay) {
  std::thread overflow_timer([&overflow_callback, delay]() {
    while (nullptr == overflow_callback) {
      std::this_thread::sleep_for(500us);
    }
    std::this_thread::sleep_for(delay);
    overflow_callback();
  });
  return AutoJoinable(std::move(overflow_timer));
}

TEST_F(TestPump, Activate_OverflowDuringPumping) {
  auto cut = cleanCut();
  auto overflow_timer = triggerOverflowAfter(overflow_callback, 1s);

  expectPumpActivation();

  auto result = cut.activate(10_s);
  auto t_elapsed = pumpActiveDuration();

  ASSERT_TRUE(cut.has_overflowed());
  ASSERT_TRUE(result);
  ASSERT_GE(t_elapsed, 990ms) << "Actual: " << toMs(t_elapsed) << "ms";
  ASSERT_LE(t_elapsed, 1010ms) << "Actual: " << toMs(t_elapsed) << "ms";
}

TEST_F(TestPump, Activate_OverflowAfterPumping) {
  auto cut = cleanCut();
  auto overflow_timer = triggerOverflowAfter(overflow_callback, 2s);

  // TEST BROKEN

  expectPumpActivation();

  auto result = cut.activate(1_s);
  ASSERT_TRUE(result);
  ASSERT_FALSE(cut.has_overflowed());

  auto t_elapsed = pumpActiveDuration();
  ASSERT_GE(t_elapsed, 990ms) << "Actual: " << toMs(t_elapsed) << "ms";
  ASSERT_LE(t_elapsed, 1010ms) << "Actual: " << toMs(t_elapsed) << "ms";

  overflow_timer.join();
  ASSERT_TRUE(cut.has_overflowed());
}

TEST_F(TestPump, Activate_Successful) {
  // TODO
}
