#include "xtd/bootstrap.hpp"
#include "xtd/chrono.hpp"
#include "xtd/dio.hpp"
#include "xtd/sleep.hpp"
#include "xtd/uart.hpp"

#include "pumpcontroller.hpp"

#include <avr/pgmspace.h>

using namespace xtd::chrono_literals;
using arduino::dio_pin;

int main() {
  auto reset_cause = avr::bootstrap(false);

  arduino::configure(dio_pin::led_builtin, avr::pin_state::output, false);

  avr::uart.enable();
  avr::uart << "rst: " << uint8_t(reset_cause) << '\n';

  waterino::pump_controller controller0(0, dio_pin::dio_9, dio_pin::dio_8, dio_pin::dio_2);

  while (true) {
    for (int i = 0; i < 4; ++i) {
      arduino::write(dio_pin::led_builtin, true);
      arduino::sleep(100_ms);
      arduino::write(dio_pin::led_builtin, false);
      arduino::sleep(100_ms);
    }

    auto now = xtd::chrono::steady_clock::now();
    auto until_next_update = controller0.update(now);

    // avr::uart.flush();
    // avr::uart.disable();
    avr::sleep(until_next_update);
    // avr::uart.enable();
  }
}
