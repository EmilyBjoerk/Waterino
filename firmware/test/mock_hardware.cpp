#include "mock_hardware.hpp"
#include <iostream>
std::unique_ptr<MockHardware> mock_hardware;

#if 0
#define TRACE                                                                           \
  std::cout << __PRETTY_FUNCTION__                                                      \
            << " (time: " << std::chrono::steady_clock::now().time_since_epoch() << ")" \
            << std::endl;
#endif

#ifndef TRACE
#define TRACE
#endif

void HALProbe::hardware_initialize() {
  TRACE;
  mock_hardware->hardware_initialize();
}

void HALProbe::pump_led_on() {
  TRACE;
  mock_hardware->pump_led_on();
}

void HALProbe::pump_led_off() {
  TRACE;
  mock_hardware->pump_led_off();
}

void HALProbe::pump_activate() {
  TRACE;
  mock_hardware->pump_activate();
}

void HALProbe::pump_stop() {
  TRACE;
  mock_hardware->pump_stop();
}

void HALProbe::alert() {
  TRACE;
  mock_hardware->alert();
}

cycles HALProbe::sense_rc_delay() {
  TRACE;
  return mock_hardware->sense_rc_delay();
}

adc_voltage HALProbe::sense_ntc_drop() {
  TRACE;
  return mock_hardware->sense_ntc_drop();
}

adc_voltage HALProbe::sense_overflow() {
  TRACE;
  return mock_hardware->sense_overflow();
}

void HALProbe::sense_overflow_enable_irq(callback_void_t cb) {
  TRACE;
  mock_hardware->sense_overflow_enable_irq(cb);
}

void HALProbe::sense_overflow_disable_irq() {
  TRACE;
  mock_hardware->sense_overflow_disable_irq();
}
