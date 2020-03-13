#include "../src/application.hpp"

#include "util.hpp"

#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/eeprom.hpp"

using namespace ::testing;
using namespace std::chrono_literals;

extern xtd::eemem<uint8_t> ee_wdt_resets;
extern xtd::eemem<uint8_t> ee_bod_resets;
extern xtd::eemem<uint8_t> ee_power_cycles;
extern xtd::eemem<uint8_t> ee_pump_resets;
extern xtd::eemem<HAL::moisture> ee_dry_threshold;
extern xtd::eemem<bool> ee_pump_active;
extern xtd::eemem<xtd::chrono::steady_clock::duration> ee_max_pump_duration;

extern xtd::eemem<HAL::kelvin> ee_t_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_water;
extern xtd::eemem<HAL::rc_capacitance> ee_c_air;

class TestApplication : public ::testing::Test {
protected:
  void SetUp() override {
    ee_wdt_resets = 0;
    ee_bod_resets = 0;
    ee_power_cycles = 0;
    ee_pump_resets = 0;
    ee_dry_threshold = 0;
    ee_pump_active = false;
    ee_max_pump_duration = 0;
    mock_hardware.reset(new ::testing::NiceMock<MockHardware>());
  }
  void TearDown() override { mock_hardware.reset(); }
};

// If the was active when we powered down (possibly caused by a short from pumping) we make sure the
// pump is stopped and send a fatal signal to alert the user who will need to manually reset the
// device.
TEST_F(TestApplication, PumpStopOnBoot) {
  ee_pump_active = true;

  Expectation pump_stop = EXPECT_CALL(*mock_hardware, pump_stop());
  EXPECT_CALL(*mock_hardware, fatal(HAL::error_reset_during_pumping)).After(pump_stop);
  Application cut;

  ASSERT_EQ(1, ee_pump_resets.get());
  ASSERT_EQ(false, ee_pump_active.get());
}

TEST_F(TestApplication, HardwareInitCalled) {
  Expectation bootstrap =
    EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::brownout));
  EXPECT_CALL(*mock_hardware, hardware_initialize()).After(bootstrap);

  Application cut;
}

TEST_F(TestApplication, ResetBOD) {
  ee_bod_resets = 0;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::brownout));

  Application cut;

  ASSERT_EQ(1, ee_bod_resets.get());
}

TEST_F(TestApplication, ResetBODMax) {
  ee_bod_resets = 254;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::brownout));

  Application cut;

  ASSERT_EQ(255, ee_bod_resets.get());
}

TEST_F(TestApplication, ResetBODClip) {
  ee_bod_resets = 255;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::brownout));

  Application cut;

  ASSERT_EQ(255, ee_bod_resets.get());
}

TEST_F(TestApplication, ResetPower) {
  ee_power_cycles = 0;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::power_on));

  Application cut;

  ASSERT_EQ(1, ee_power_cycles.get());
}

TEST_F(TestApplication, ResetPowerMax) {
  ee_power_cycles = 254;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::power_on));

  Application cut;

  ASSERT_EQ(255, ee_power_cycles.get());
}

TEST_F(TestApplication, ResetPowerClip) {
  ee_power_cycles = 255;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::power_on));

  Application cut;

  ASSERT_EQ(255, ee_power_cycles.get());
}

TEST_F(TestApplication, ResetWDT) {
  ee_wdt_resets = 0;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::watchdog));

  Application cut;

  ASSERT_EQ(1, ee_wdt_resets.get());
}

TEST_F(TestApplication, ResetWDTMax) {
  ee_wdt_resets = 254;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::watchdog));

  Application cut;

  ASSERT_EQ(255, ee_wdt_resets.get());
}

TEST_F(TestApplication, ResetWDTClip) {
  ee_wdt_resets = 255;
  EXPECT_CALL(*mock_hardware, bootstrap(_,_)).WillOnce(Return(xtd::reset_cause::watchdog));

  Application cut;

  ASSERT_EQ(255, ee_wdt_resets.get());
}

// If the RC measurement returns 0 F. I.e. the probe is in a vacuum we should water because
// a vacuum is by definition void of moisture (see what I did there?).
TEST_F(TestApplication, WaterInVacuum) {
  ee_dry_threshold = HAL::moisture(10000_ppm);
  EXPECT_CALL(*mock_hardware, sense_capacitance()).WillOnce(Return(0_F));
  EXPECT_CALL(*mock_hardware, sense_ntc_drop()).WillOnce(Return(2400_mV));
  EXPECT_CALL(*mock_hardware, pump_activate());
  EXPECT_CALL(*mock_hardware, pump_stop()).Times(AtLeast(1));

  Application cut;

  cut.execute_loop();
}

// If the RC measurement is consistent with fully submerged (calibrated value) then we
// should not water any more.
TEST_F(TestApplication, NoWaterOnSuperWet) {
  ee_dry_threshold = HAL::moisture(10000_ppm);
  EXPECT_CALL(*mock_hardware, sense_capacitance()).WillOnce(Return(300_pF));
  EXPECT_CALL(*mock_hardware, pump_activate()).Times(Exactly(0));

  Application cut;

  cut.execute_loop();
}
