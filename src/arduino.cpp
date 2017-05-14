#include "xtd/arduino.hpp"

namespace arduino {

  void configure(dio_pin pin, pin_state state, bool set_high) {
    if (pin < dio_pin::dio_8) {
      gpio_port_D[int(pin)].configure(state, set_high);
    } else {
      gpio_port_B[int(pin) - 8].configure(state, set_high);
    }
  }

  void write(dio_pin pin, bool high) {
    if (pin < dio_pin::dio_8) {
      gpio_port_D[int(pin)].write(high);
    } else {
      gpio_port_B[int(pin) - 8].write(high);
    }
  }

  bool read(dio_pin pin) {
    if (pin < dio_pin::dio_8) {
      return gpio_port_D[int(pin)].read();
    } else {
      return gpio_port_B[int(pin) - 8].read();
    }
  }

  void blink(int times, const avr::delay_duration& d) {
    if (times < 0) {
      while (1) {
        write(dio_pin::led_builtin, true);
        delay(d);
        write(dio_pin::led_builtin, false);
        delay(d);
      }
    } else {
      for (int i = 0; i < times; ++i) {
        write(dio_pin::led_builtin, true);
        delay(d);
        write(dio_pin::led_builtin, false);
        delay(d);
      }
    }
  }
}
