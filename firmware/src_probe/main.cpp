#include <avr/interrupt.h>
#include <avr/sleep.h>

#include "xtd_uc/adc.hpp"
#include "xtd_uc/eeprom.hpp"
#include "xtd_uc/i2c.hpp"

#include "probe.hpp"
#include "proto_fsm.hpp"

// SDA/SCA = PB0/PB2
// MOIST_P_PIN = PB5
// MOIST_N_PIN = PB1
// MOIST_A_PIN = PB3/ADC3
// TEMP_A_PIN = PB4/ADC2

xtd::i2c_device i2c;
xtd::eeprom_small<uint8_t, 0> i2c_addr;
probe::protocol_fsm protocol;

ISR(ADC_vect) {  // else application is reset
}

ISR(TWI_vect) {
  auto state = i2c.on_twi();
  switch (state) {
    case xtd::i2c_slave_transmit:
      break;
    case xtd::i2c_slave_receive:
      break;
    case xtd::i2c_master_lost_arbitration:
      break;
    case xtd::i2c_master_nobody_home:
      break;
    case xtd::i2c_master_transmit:
      break;
    case xtd::i2c_master_receive:
      break;
    case xtd::i2c_master_idle:
      break;

    case xtd::i2c_idle:            // FALLTHROUGH
    case xtd::i2c_busy:            // FALLTHROUGH
    case xtd::i2c_internal_error:  // FALLTHROUGH
    default:
      // Do nothing
  }
}

int main() {
  // Make sure probe excitation pins are in the default state
  probe::stop_excitation();

  // Disable power to timers (not used) other flags handled below
  PRR = _BV(PRTIM1) | _BV(PRTIM0);

  // Disable digital input on the probe excitation pins (never read)
  DIDR0 |= _BV(ADC0D);  // MOIST+ (PB5/RESET)
  DIDR0 |= _BV(AIN1D);  // MOIST- (PB1)

  // Disable Analog comparator circuitry
  xtd::set_bit(ACSR, ACD);

  // Disable digital io on PB3/4 (used as ADC) to save power
  xtd::adc_dio_pin(2, false);
  xtd::adc_dio_pin(3, false);
  xtd::adc_disable();

  // Setup i2c slave driver
  i2c.enable(0);
  i2c.slave_on(15 << 1, false);

  // Setup is done enable interrupts
  sei();

  while (true) {
    protocol.run(i2c);

    // Mask interrupts so that the i2c driver doesn't become active immediately after reporting idle
    cli();
    if (protocol.can_sleep()) {
      set_sleep_mode(i2c.idle() ? SLEEP_MODE_PWR_DOWN : SLEEP_MODE_IDLE);
      sleep_enable();

      // Next instcuction will execute before interrupts are processed meaning that any...
      sei();
      // ...pending IRQ since cli() above will wake the cpu and return from the sleep call
      sleep_cpu();
      sleep_disable();
    } else {
      sei();
    }
  }
}
