#ifndef GUARD_XTD_ARDUINO_HPP
#define GUARD_XTD_ARDUINO_HPP

#include "adc.hpp"
#include "dio.hpp"

#include "delay.hpp"

namespace arduino {
  using namespace avr;

  enum class dio_pin : uint8_t {
    dio_0,
    dio_1,
    dio_2,
    dio_3,
    dio_4,
    dio_5,
    dio_6,
    dio_7,
    dio_8,
    dio_9,
    dio_10,
    dio_11,
    dio_12,
    dio_13,
    led_builtin = dio_13
  };

  void configure(dio_pin pin, pin_state state, bool set_high = false);
  void write(dio_pin pin, bool high);
  bool read(dio_pin pin);

  void blink(int times, const avr::delay_duration& d);
}

#endif
