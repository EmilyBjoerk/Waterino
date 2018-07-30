#include <avr/interrupt.h>
#include <avr/sleep.h>


#include "xtd_uc/delay.hpp"

using namespace xtd::chrono_literals;

int main() {
  DDRB |= _BV(3);

  while (true) {
    PORTB |= _BV(3);
    xtd::delay(500_ms);
    PORTB &= ~_BV(3);
    xtd::delay(500_ms);
  }
}

#if 0
#include "probe.hpp"

enum class i2c_state : uint8_t { idle, start_detected, slave_tx_acked };

volatile i2c_state g_i2c_state = i2c_state::idle;
volatile uint8_t g_i2c_addr = 0;

ISR(ADC_vect) {}

ISR(USI_START_vect) {
  // Start condition detected on the wire, SCL is forced low untill we clear the
  // status bit.

  // Make sure SCL and SDA are inputs
  DDRB &= ~0b101;

  // Put us in the right USI mode (start condition IRQ disabled).
  USICR = _BV(USIOIE) |       // IRQ on Counter overflow
          (0b11 << USIWM0) |  // TWI mode with clock stretching on OVF
          (0b100 << USICLK);  // Clock USIDR on positive edge on external SCL

  // Clear the input register for good measure.
  USIDR = 0x00;

  // Clear counter value
  USISR &= ~0b1111;

  g_i2c_state = i2c_state::start_detected;

  // Release SCL
  USISR &= ~_BV(USISIF);
}

ISR(USI_OVF_vect) {
  // We have received or sent one frame
  switch (g_i2c_state) {
    case i2c_state::start_detected: {
      auto addr = USIDR;
      if (g_i2c_addr == (addr & 0xFE)) {
        // It's for us, ack it
        DDRB |= _BV(0);  // Allow driving SDA
        USIDR = 0;       // SDA will be driven low

        USISR = (USISR & ~0b1111) + 14;  // Trigger OVF IRQ after ACK bit

        bool slave_tx = addr & 1;
        if (slave_tx) {
          g_i2c_state = i2c_state::slave_tx_acked;
        } else {
          g_i2c_state = i2c_state::slave_rx_acked;
        }

      } else {
        //  Not for us... Disable overflow IRQ and counter until next start bit
        USICR = _BV(USISIE) |      // IRQ on start condition
                (0b11 << USIWM0);  // TWI mode with clock stretching on OVF
        g_i2c_state = i2c_state::idle;
      }
      break;
    }
    case i2c_state::slave_tx_acked:
      // change clock mode to negatifve edge here and write data
      working here break;
    case i2c_state::slave_rx_acked:
      working here break;
    default:
      break;
  }

  USISR |= _BV(USIOIF);  // Clear overflow flag and release SCL
}

ISR(WDT_vect) { p }

// SDA/SCA = PB0/PB2
// MOIST_P_PIN = PB5
// MOIST_N_PIN = PB1
// MOIST_A_PIN = PB3/ADC3
// TEMP_A_PIN = PB4/ADC2

int main() {
  PRR = _BV(PRTIM1) | _BV(PRTIM0) | _BV(PRADC);  // Turn off power to ADC and timers
  MCUCR = _BV(PUD);                              // Disable pull ups on all IO

  // When the micro is sleeping the IO pins will short to ground. Thus take that as the default
  // state for the moisture pins because this state must work as it is the sleep state.
  DDRB = _BV(PORTB1) | _BV(PORTB5);

  // Setup USI as I2C slave'
  g_i2c_addr = *e_i2c_addr;
  USICR =
      _BV(USISIE) |  // IRQ on Start Condition
      _BV(USIOIE) |  // IRQ on Counter overflow
      (0b11
       << USIWM0) |  // Two Wire mode with clock stretching on counter overflow (15->0 transition).
      (0b100 << USICLK);

  // Setup is done enable interrupts
  sei();

  while (true) {
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);
    sleep_enable();
    sleep_cpu();

    /*
    if(i2c.slave_state() == i2c_slave_state::receive){
      auto cmd = i2c.slave_receive_raw();


      i2c_read_response::nack);
      }*/
  }
}
#endif
