#include <avr/interrupt.h>
#include <avr/sleep.h>

#include "xtd_uc/adc.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/i2c.hpp"

#include "probe.hpp"
#include "probe_defs.hpp"

// SDA/SCA = PB0/PB2
// MOIST_P_PIN = PB5
// MOIST_N_PIN = PB1
// MOIST_A_PIN = PB3/ADC3
// TEMP_A_PIN = PB4/ADC2

using namespace xtd::chrono_literals;

xtd::eeprom_small<uint8_t, 0> i2c_addr;
xtd::eeprom_small<uint16_t, 1> probe_threshold;
xtd::i2c_device i2c;
volatile bool do_read = false;

uint8_t last_cmd = probe::cmd_none;

union {
  probe::msg_read_probe probe_read;
  probe::msg_threshold thresh;

  uint8_t raw[xtd::max(sizeof(probe_read), sizeof(thresh))];
} txn_buffer;

static_assert(9 == sizeof(txn_buffer), "Too small txn_buffer!");
static_assert(9 == sizeof(txn_buffer.probe_read), "Too small probe_read!");

void increment_cmd_state(bool last_byte, uint8_t cmd_state) {
  if (last_byte) {
    last_cmd = probe::cmd_none;
  } else {
    last_cmd = (last_cmd & probe::cmd_mask) | (cmd_state + 1);
  }
}

ISR(ADC_vect){ // else application is reset
}

ISR(USI_START_vect) { i2c.on_usi_start(); }

ISR(USI_OVF_vect) {
  auto state = i2c.on_usi_ovf();
  uint8_t cmd_state = last_cmd & 0x0F;

  if (state == xtd::i2c_slave_receive) {
    switch (last_cmd & probe::cmd_mask) {
      case probe::cmd_none:
        last_cmd = i2c.slave_receive_raw() & probe::cmd_mask;
        if (last_cmd == probe::cmd_read_probe || last_cmd == probe::cmd_is_dry) {
          // Read probe before nacking, this forces the bus to be quiet while we read the ADC.
          // txn_buffer.probe_read = probe::read();
          do_read = true;
          return;  // Without acking! Acked from main when probe read completes
        } else if (last_cmd == probe::cmd_get_threshold) {
          // txn_buffer.thresh = probe::msg_threshold(*probe_threshold);
        }
        i2c.slave_ack(last_cmd == probe::cmd_set_threshold ? xtd::i2c_ack : xtd::i2c_nack);
        break;
      case probe::cmd_set_threshold:
        if (cmd_state < sizeof(txn_buffer.thresh)) {
          txn_buffer.raw[cmd_state++] = i2c.slave_receive_raw();
        }
        if (cmd_state >= sizeof(txn_buffer.thresh)) {
          if (txn_buffer.thresh.is_valid()) {
            probe_threshold = txn_buffer.thresh.thresh;
          }
          i2c.slave_ack(xtd::i2c_nack);
          last_cmd = probe::cmd_none;
        } else {
          last_cmd = (last_cmd & probe::cmd_mask) | cmd_state;
          i2c.slave_ack(xtd::i2c_ack);
        }
        break;
      default:
        // Received spurious i2c write, nack and reset FSM
        last_cmd = probe::cmd_none;
        i2c.slave_ack(xtd::i2c_nack);
        break;
    }
  } else if (state == xtd::i2c_slave_transmit) {
    switch (last_cmd & probe::cmd_mask) {
      case probe::cmd_read_probe: {
        bool last_byte = cmd_state == sizeof(txn_buffer.probe_read) - 1;
        i2c.slave_transmit(txn_buffer.raw[cmd_state], last_byte);
        increment_cmd_state(last_byte, cmd_state);
        break;
      }
      case probe::cmd_get_threshold: {
        bool last_byte = cmd_state == sizeof(txn_buffer.thresh) - 1;
        i2c.slave_transmit(txn_buffer.raw[cmd_state], last_byte);
        increment_cmd_state(last_byte, cmd_state);
        break;
      }
      case probe::cmd_is_dry: {
        uint16_t thresh = *probe_threshold;
        bool dry = txn_buffer.probe_read.moisture < thresh;
        i2c.slave_transmit(dry ? probe::msg_probe_dry : probe::msg_probe_wet, true);
        last_cmd = probe::cmd_none;
        break;
      }
      case probe::cmd_read_log:  // NYI
        i2c.slave_transmit(0xA3, true);
        last_cmd = probe::cmd_none;
        break;
      default:
        // Received spurious write, tell firmware to not accept more writes in this transaction
        // (until a new start condition), it  will respond 0xFF to any reads (which by a coincidence
        // is equal to probe::cmd_error).
        i2c.slave_transmit(0x83, true);
        last_cmd = probe::cmd_none;
        break;
    }
  }
}

int main() {
  // Disable digital io on PB3/4 to save power
  xtd::adc_dio_pin(2, false);
  xtd::adc_dio_pin(3, false);
  xtd::adc_disable();

  // Disable Analog comparator circuitry
  xtd::set_bit(ACSR, ACD);

  //  DDRB |= _BV(PB3) | _BV(PB1) | _BV(PB4);
  /*
  for (char i = 0; i < 10; i++) {
    PORTB |= _BV(3);
    xtd::delay(500_ms);
    PORTB &= ~_BV(3);
    xtd::delay(500_ms);
  }
*/
  i2c.enable(0);
  i2c.slave_on(15 << 1, false);

  // Setup is done enable interrupts
  sei();

  while (true) {
    if (do_read) {
      txn_buffer.probe_read = probe::read();
      //txn_buffer.raw[0]++;
      i2c.slave_ack(xtd::i2c_nack);
      do_read = false;
    }

    /*    cli();
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);
    sleep_enable();
    sleep_cpu();
    sei();

    sleep_disable();
    */
  }
}
