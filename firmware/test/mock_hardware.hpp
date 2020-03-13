#ifndef GUARD_WATERINO_TEST_MOCK_HARDWARE_HPP
#define GUARD_WATERINO_TEST_MOCK_HARDWARE_HPP

#include <gmock/gmock.h>
#include <memory>
#include "../src/hardware.hpp"

#include "xtd_uc/bootstrap.hpp"

/*
 * This together with the stubs in mock_hardware.cpp mocks out the HAL with the object in
 * mock_hardware below.
 */
class VirtualHardware {
public:
  virtual ~VirtualHardware() = default;

  virtual xtd::reset_cause bootstrap(bool, xtd::wdt_timeout) = 0;

  virtual void hardware_initialize() = 0;
  virtual void pump_led_on() = 0;
  virtual void pump_led_off() = 0;
  virtual void pump_activate() = 0;
  virtual void pump_stop() = 0;
  virtual void alert() = 0;
  virtual void fatal(HAL::error_code) = 0;
  virtual HAL::rc_capacitance sense_capacitance() = 0;
  virtual HAL::adc_voltage sense_ntc_drop() = 0;
  virtual bool sense_overflow() = 0;
  virtual bool sense_overflow_enabled() = 0;
  virtual void sense_overflow_enable_irq(HAL::overflow_callback_t /*cb*/) = 0;
  virtual void sense_overflow_disable_irq() = 0;
  virtual void sleep_until_irq() = 0;
  
};

class MockHardware : public VirtualHardware {
public:
  MOCK_METHOD2(bootstrap, xtd::reset_cause(bool, xtd::wdt_timeout));

  MOCK_METHOD0(hardware_initialize, void());
  MOCK_METHOD0(pump_led_on, void());
  MOCK_METHOD0(pump_led_off, void());
  MOCK_METHOD0(pump_activate, void());
  MOCK_METHOD0(pump_stop, void());
  MOCK_METHOD0(alert, void());
  MOCK_METHOD1(fatal, void(HAL::error_code));
  MOCK_METHOD0(sense_capacitance, HAL::rc_capacitance());
  MOCK_METHOD0(sense_ntc_drop, HAL::adc_voltage());
  MOCK_METHOD0(sense_overflow, bool());
  MOCK_METHOD0(sense_overflow_enabled, bool());
  MOCK_METHOD1(sense_overflow_enable_irq, void(HAL::overflow_callback_t));
  MOCK_METHOD0(sense_overflow_disable_irq, void());
  MOCK_METHOD0(sleep_until_irq, void());
};

extern std::unique_ptr<MockHardware> mock_hardware;

#endif
