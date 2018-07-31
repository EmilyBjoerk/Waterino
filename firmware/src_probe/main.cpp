#include <avr/interrupt.h>
#include <avr/sleep.h>

#include "xtd_uc/delay.hpp"
#include "xtd_uc/i2c.hpp"

#include "probe.hpp"

// SDA/SCA = PB0/PB2
// MOIST_P_PIN = PB5
// MOIST_N_PIN = PB1
// MOIST_A_PIN = PB3/ADC3
// TEMP_A_PIN = PB4/ADC2

using namespace xtd::chrono_literals;

xtd::i2c_device i2c;
uint8_t last_data = 0;

ISR(USI_START_vect) { i2c.on_usi_start(); }

ISR(USI_OVF_vect) {
  i2c.on_usi_ovf();

  auto state = i2c.slave_state();
  if (state == xtd::i2c_slave_receive) {
    last_data = i2c.slave_receive(xtd::i2c_ack);
  } else if (state == xtd::i2c_slave_transmit) {
    i2c.slave_transmit(last_data, true);
  }
}

int main() {
  DDRB |= _BV(3);

  for (char i = 0; i < 10; i++) {
    PORTB |= _BV(3);
    xtd::delay(500_ms);
    PORTB &= ~_BV(3);
    xtd::delay(500_ms);
  }

  i2c.enable(0);
  i2c.slave_on(15, false);

  // Setup is done enable interrupts
  sei();

  while (true) {
    cli();
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);
    sleep_enable();
    sleep_cpu();
    sei();

    sleep_disable();
  }
}
