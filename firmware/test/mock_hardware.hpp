#ifndef GUARD_WATERINO_TEST_MOCK_HARDWARE_HPP
#define GUARD_WATERINO_TEST_MOCK_HARDWARE_HPP

#include <gmock/gmock.h>
#include <memory>
#include "../src/hardware.hpp"

/*
 * This together with the stubs in mock_hardware.cpp mocks out the HAL with the object in 
 * mock_hardware below.
 */
class VirtualHardware {
public:
  virtual ~VirtualHardware() = default;

  virtual void hardware_initialize() = 0;
  virtual void pump_led_on() = 0;
  virtual void pump_led_off() = 0;
  virtual void pump_activate() = 0;
  virtual void pump_stop() = 0;
  virtual void alert() = 0;
  virtual cycles sense_rc_delay() = 0;
  virtual adc_voltage sense_ntc_drop() = 0;
  virtual adc_voltage sense_overflow() = 0;
  virtual void sense_overflow_enable_irq(HALProbe::callback_void_t /*cb*/) = 0;
  virtual void sense_overflow_disable_irq() = 0;
};

class MockHardware : public VirtualHardware{
public:
  MOCK_METHOD0(hardware_initialize, void());
  MOCK_METHOD0(pump_led_on, void());
  MOCK_METHOD0(pump_led_off, void());
  MOCK_METHOD0(pump_activate, void());
  MOCK_METHOD0(pump_stop, void());
  MOCK_METHOD0(alert, void());
  MOCK_METHOD0(sense_rc_delay, cycles());
  MOCK_METHOD0(sense_ntc_drop, adc_voltage());
  MOCK_METHOD0(sense_overflow, adc_voltage());
  MOCK_METHOD1(sense_overflow_enable_irq, void(HALProbe::callback_void_t));
  MOCK_METHOD0(sense_overflow_disable_irq, void());
};

extern std::unique_ptr<MockHardware> mock_hardware;

#endif
