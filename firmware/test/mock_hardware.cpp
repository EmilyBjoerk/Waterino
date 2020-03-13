#include "mock_hardware.hpp"

#include <iostream>
std::unique_ptr<MockHardware> mock_hardware;

#if 0
#define TRACE                                                                           \
  std::cout << __PRETTY_FUNCTION__                                                      \
            << " (time: " << std::chrono::steady_clock::now().time_since_epoch() << ")" \
            << std::endl;
#else
#define TRACE
#endif

namespace xtd {
  xtd::reset_cause bootstrap(bool b, xtd::wdt_timeout t) {
    TRACE;
    return mock_hardware->bootstrap(b, t);
  }
}  // namespace xtd

namespace HAL {

  ostream& uart = std::cout;

  void hardware_initialize() {
    TRACE;
    mock_hardware->hardware_initialize();
  }

  void pump_led_on() {
    TRACE;
    mock_hardware->pump_led_on();
  }

  void pump_led_off() {
    TRACE;
    mock_hardware->pump_led_off();
  }

  void pump_activate() {
    TRACE;
    mock_hardware->pump_activate();
  }

  void pump_stop() {
    TRACE;
    mock_hardware->pump_stop();
  }

  void alert() {
    TRACE;
    mock_hardware->alert();
  }

  void fatal(error_code c) {
    TRACE;
    mock_hardware->fatal(c);
  }

  adc_voltage sense_ntc_drop() {
    TRACE;
    return mock_hardware->sense_ntc_drop();
  }

  rc_capacitance sense_capacitance() {
    TRACE;
    return mock_hardware->sense_capacitance();
  }

  bool sense_overflow() {
    TRACE;
    return mock_hardware->sense_overflow();
  }

  bool sense_overflow_enabled() {
    TRACE;
    return mock_hardware->sense_overflow_enabled();
  }

  void sense_overflow_enable_irq(overflow_callback_t cb) {
    TRACE;
    mock_hardware->sense_overflow_enable_irq(cb);
  }

  void sense_overflow_disable_irq() {
    TRACE;
    mock_hardware->sense_overflow_disable_irq();
  }

  void sleep_until_irq() {
    TRACE;
    mock_hardware->sleep_until_irq();
  }
}  // namespace HAL
