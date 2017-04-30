#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/sleep.h>
#include <util/atomic.h>
#include <util/delay.h>

#include "xtd/adc.hpp"
#include "xtd/bootstrap.hpp"
#include "xtd/dio.hpp"
#include "xtd/sleep.hpp"
#include "xtd/uart.hpp"

using namespace xtd::chrono_literals;

bool ledon = true;

volatile bool d = false;
unsigned int a = 0;
ISR(ADC_vect) {
  d = true;
  a++;
  if (a > 6000) {
    char i = 1;
    while (i-- > 0) {
      _delay_ms(50);

      _delay_ms(50);
      avr::gpio_port_B[5].write(ledon);
    }
    a = 0;
  }
}

int main(void) {
  avr::bootstrap(false);
  avr::uart::enable();

  avr::gpio_port_B[5].configure(avr::pin_state::output, ledon);

  avr::adc::enable();
  avr::adc::select_ch(0, avr::adc::vref::internal_vcc, false);
  avr::delay(1_s);
  while (1) {
    auto value = avr::adc::blocking_read();
    avr::uart::put(value);
    avr::uart::put("/1024\n");
    avr::sleep(2_s);
    // avr::delay(2_s);
    ledon = !ledon;
    avr::gpio_port_B[5].write(!ledon);
  }
  avr::adc::disable();
}
