#include "xtd/chrono.hpp"
#include "xtd/dio.hpp"
#include "xtd/uart.hpp"

#include "pumpcontroller.hpp"

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <stdio.h>
#include <util/delay.h>

using namespace xtd::chrono_literals;

using digital_pin_state = xtd::atmega328::pin_state;

using xtd::arduino::dio_pin;

int main() {
  xtd::chrono::sleep(2_s);
  xtd::serial.put_P(PSTR("Waterino 0.1 starting...\n"));

  xtd::arduino::configure(dio_pin::led_builtin, digital_pin_state::output);

  waterino::pump_controller controller0(0, xtd::arduino::dio_pin::dio_2);

  while (true) {
    for (int i = 0; i < 5; ++i) {
      xtd::chrono::delay(200_ms);
      xtd::arduino::write(dio_pin::led_builtin, true);
      xtd::chrono::delay(200_ms);
      xtd::arduino::write(dio_pin::led_builtin, false);
    }

    auto now = xtd::chrono::steady_clock::now();

    auto until_next_update = controller0.update(now);

    xtd::chrono::sleep(until_next_update);
  }
}
