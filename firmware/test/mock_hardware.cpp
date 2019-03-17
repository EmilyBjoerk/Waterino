#include "mock_hardware.hpp"

std::unique_ptr<MockHardware> mock_hardware;

void HALProbe::hardware_initialize() { mock_hardware->hardware_initialize(); }

void HALProbe::pump_led_on() { mock_hardware->pump_led_on(); }

void HALProbe::pump_led_off() { mock_hardware->pump_led_off(); }

void HALProbe::pump_activate() { mock_hardware->pump_activate(); }

void HALProbe::pump_stop() { mock_hardware->pump_stop(); }

void HALProbe::alert() { mock_hardware->alert(); }

cycles HALProbe::sense_rc_delay() { return mock_hardware->sense_rc_delay(); }

adc_voltage HALProbe::sense_ntc_drop() { return mock_hardware->sense_ntc_drop(); }

adc_voltage HALProbe::sense_overflow() { return mock_hardware->sense_overflow(); }

void HALProbe::sense_overflow_enable_irq(callback_void_t cb) {
  mock_hardware->sense_overflow_enable_irq(cb);
}

void HALProbe::sense_overflow_disable_irq() { mock_hardware->sense_overflow_disable_irq(); }
