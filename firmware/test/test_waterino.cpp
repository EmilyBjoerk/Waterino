#include "../src/waterino.hpp"

#include <gtest/gtest.h>
#include <sstream>
#include "mocks.hpp"

using namespace testing;

using WaterinoTest =
    Waterino<TestPump, TestController, TestProbe, TestCmdInterface, TestErrorReporter>;

class WaterinoMain : public Test {
public:
  TestPump pump;
  TestController controller;
  TestProbe probe;
  TestCmdInterface cmd;
  TestErrorReporter errors;

  std::stringstream log;

  void SetUp() override {
    ON_CALL(errors.mock(), log()).WillByDefault(ReturnRef(log));
    ON_CALL(pump.mock(), activate(_, _)).WillByDefault(Return(true));
  }
};

// The pump signals overflow if there as too much water given. This should be reported
// and the controller should be notified.
TEST_F(WaterinoMain, OverflowDetected) {
  ON_CALL(pump.mock(), has_overflowed()).WillByDefault(Return(false));
  ON_CALL(probe.mock(), is_dry()).WillByDefault(Return(false));

  WaterinoTest cut(pump, controller, probe, cmd, errors);

  // First activation after power on, no activity, probe is not dry.
  ASSERT_TRUE(cut.run(WaterinoTest::time_point(0_s)));

  // Probe reports dry on second run, pump activates and gives the overflow_duration
  // dosage of water. Activity is reported to pump
  auto t1 = WaterinoTest::time_point(2_h);
  auto overflow_duration = IController::duration(10_s);
  EXPECT_CALL(probe.mock(), is_dry()).Times(AtLeast(1)).WillRepeatedly(Return(true));
  {
    InSequence s;
    EXPECT_CALL(controller.mock(), compute(t1)).WillRepeatedly(Return(overflow_duration));
    EXPECT_CALL(controller.mock(), report_activation(t1));
  }
  ASSERT_TRUE(cut.run(t1));
  Mock::VerifyAndClear(&controller.mock());
  Mock::VerifyAndClear(&probe.mock());

  // On third activation overflow is sensed and error signaled.
  auto t2 = WaterinoTest::time_point(4_h);
  ON_CALL(pump.mock(), has_overflowed()).WillByDefault(Return(true));

  EXPECT_CALL(errors.mock(), report(error_type::overflow));
  EXPECT_CALL(controller.mock(), report_overflow(overflow_duration));

  ASSERT_TRUE(cut.run(t2));
}

// If the pump didn't actually activate when requested to, the plants are at
// danger of dying so we must report a critical failure and notify the user.
TEST_F(WaterinoMain, NoPumpActivation) {
  ON_CALL(probe.mock(), is_dry()).WillByDefault(Return(true));
  ON_CALL(pump.mock(), has_overflowed()).WillByDefault(Return(false));
  EXPECT_CALL(errors.mock(), report(error_type::pump_failure)).Times(1);

  WaterinoTest cut(pump, controller, probe, cmd, errors);

  ASSERT_TRUE(cut.run(WaterinoTest::time_point(1_s)));
  ASSERT_FALSE(cut.run(WaterinoTest::time_point(2_h)));
}

// If the pump activation returns false, the return code must be propagated.
// This is to ensure that the Waterino stops anc ceases any dangerous activity.
TEST_F(WaterinoMain, PumpReportedFailure) {
  ON_CALL(probe.mock(), is_dry()).WillByDefault(Return(true));
  ON_CALL(pump.mock(), has_overflowed()).WillByDefault(Return(false));

  // We verify both states to make sure the test is sensitive on the right thing.
  EXPECT_CALL(pump.mock(), activate(_, _)).WillOnce(Return(true)).WillOnce(Return(false));

  WaterinoTest cut(pump, controller, probe, cmd, errors);

  ASSERT_TRUE(cut.run(WaterinoTest::time_point(0_s)));
  ASSERT_FALSE(cut.run(WaterinoTest::time_point(1_s)));
}

TEST_F(WaterinoMain, ResetAfterFuseBlown) {
  ON_CALL(probe.mock(), is_dry()).WillByDefault(Return(true));
  ON_CALL(pump.mock(), has_overflowed()).WillByDefault(Return(false));
  ON_CALL(pump.mock(), is_pumping()).WillByDefault(Return(true));

  // Pump must not be activated!
  EXPECT_CALL(pump.mock(), activate(_, _)).Times(0);

  // We reset the pumping status, signal fuse blown and return false
  {
    InSequence s;
    EXPECT_CALL(pump.mock(), reset_pumping()).Times(1);
    EXPECT_CALL(errors.mock(), report(error_type::fuse_blown)).Times(1);
  }

  WaterinoTest cut(pump, controller, probe, cmd, errors);
  ASSERT_FALSE(cut.run(WaterinoTest::time_point(0_s)));
}

TEST_F(WaterinoMain, PumpWhenDry) {
  EXPECT_CALL(errors.mock(), report(_)).Times(0);
  WaterinoTest cut(pump, controller, probe, cmd, errors);

  // Stage 0: probe is moist, everything normal. No pump activation or
  // update of controller state.
  auto t0 = WaterinoTest::time_point(2_h);
  EXPECT_CALL(probe.mock(), is_dry()).WillRepeatedly(Return(false));
  EXPECT_CALL(controller.mock(), report_activation(_)).Times(0);
  EXPECT_CALL(pump.mock(), activate(_, _)).Times(0);
  ASSERT_TRUE(cut.run(t0));
  Mock::VerifyAndClear(&controller.mock());
  Mock::VerifyAndClear(&probe.mock());
  Mock::VerifyAndClear(&pump.mock());

  // Stage 1: probe is dry, watering performed.
  auto t1 = WaterinoTest::time_point(2_h);
  auto pump_duration = WaterinoTest::duration(20_s);
  EXPECT_CALL(probe.mock(), is_dry()).WillRepeatedly(Return(true));
  {
    InSequence s;
    EXPECT_CALL(controller.mock(), compute(t1)).WillRepeatedly(Return(pump_duration));
    EXPECT_CALL(controller.mock(), report_activation(t1));
    EXPECT_CALL(pump.mock(), activate(pump_duration, _)).WillOnce(Return(true));
  }
  ASSERT_TRUE(cut.run(t1));
  Mock::VerifyAndClear(&controller.mock());
  Mock::VerifyAndClear(&probe.mock());
  Mock::VerifyAndClear(&pump.mock());

  // Stage 2: probe is moist, no action.
  auto t2 = WaterinoTest::time_point(4_h);
  EXPECT_CALL(probe.mock(), is_dry()).WillRepeatedly(Return(false));
  EXPECT_CALL(controller.mock(), report_activation(_)).Times(0);
  EXPECT_CALL(pump.mock(), activate(_, _)).Times(0);
  ASSERT_TRUE(cut.run(t2));
  Mock::VerifyAndClear(&controller.mock());
  Mock::VerifyAndClear(&probe.mock());
  Mock::VerifyAndClear(&pump.mock());
}
