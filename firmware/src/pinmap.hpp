#ifndef GUARD_WATERINO_PINMAP_HPP
#define GUARD_WATERINO_PINMAP_HPP

#include "xtd/gpio.hpp"
#include "xtd/ostream.hpp"
#include "xtd/uart.hpp"

// ------------ Pin definitions taken from Rev 1.0 schematic ---------------------
// Port B: Extension port and ICSP
// Port C
constexpr xtd::gpio_pin c_pin_moisture_neg(xtd::gpio_port::port_c, 0);
constexpr xtd::gpio_pin c_pin_moisture_pos(xtd::gpio_port::port_c, 1);
constexpr xtd::gpio_pin c_pin_thermal_pos(xtd::gpio_port::port_c, 2);
constexpr uint8_t c_pin_level_alert_analog = 3;
constexpr xtd::gpio_pin c_pin_rx_led(xtd::gpio_port::port_c, 4);
constexpr xtd::gpio_pin c_pin_tx_led(xtd::gpio_port::port_c, 5);
constexpr uint8_t c_pin_moisture_analog = 6;
constexpr uint8_t c_pin_thermal_analog = 7;

// Port D
// 0: HW-RX
// 1: HW-TX
// 2: INT0 - Overflow
// 3: INT1 - Extension IRQ (not used yet)
constexpr xtd::gpio_pin c_pin_overflow(xtd::gpio_port::port_d, 2);
constexpr xtd::gpio_pin c_pin_int1(xtd::gpio_port::port_d, 3);
constexpr xtd::gpio_pin c_pin_pump(xtd::gpio_port::port_d, 4);
constexpr xtd::gpio_pin c_pin_short_circuit_led(xtd::gpio_port::port_d, 5);
constexpr xtd::gpio_pin c_pin_water_level_led(xtd::gpio_port::port_d, 6);
constexpr xtd::gpio_pin c_pin_buzzer(xtd::gpio_port::port_d, 7);

// ----------------------- External Connectors --------------------------------
// PUMP:
//  - Pin 1 = Microswitch that is Normally Open (NO) and closes to GND when water level is low.
//  - Pin 2 = Ground
//  - Pin 3 = +12V to pump.
//  - Pin 4 = Ground
//
// The MCU pin "c_pin_level_alert_analog" can sense pin1 through a resistor and diode network.
// When it senses 5V, the +12V line is shorted to Pin 1 either through water or directly.
// When it senses ~3V, then the switch is open.
// When it senses ~1V, the switch is closed or pin 2 or 3 has shorted to pin 1 (we can't tell) but
// the result
// is that the level is low and the pump /relay is killed so it is safe.
// If +12V shorts to pin 2 or pin 3 a fuse will trip and the circuit is killed. We use a variable in
// the EEPROM
// to detect if the MCU was killed before it could turn off the pump.
// That should be all combinations of shorts possible handled.
//
// Resistor-Diode network for pin 1: http://tinyurl.com/y9vs4eub
//
// PLANT:
//  - Pin 1 = Ground
//  - Pin 2 = moisture_neg
//  - Pin 3 = moisture_analog (and moisture_pos through series resistor)
//  - Pin 4 = thermal_analog (and thermal_pos through series resistor)
//  - Pin 5 = overflow (weak pull-up).
//  - Pin 6 = Ground
//
// Pins 2 and 3 go to electrodes in the soil and form a circuit.
// Pins 4 and 1 go to a thermal probe and form a circuit.
// Pins 5 and 6 go to two electrodes below the pot that short when water is found.
//
// Pins 5 and 6 are designed to short between themselves. The only way these can short to anything
// else is through severe failure in the wiring insulation.
// Pins 2 and 3 can handle a short between them; However shorting pin 2 to pin 1 and driving pin 2
// high
// may source too much current from the GPIO pin. We accept this risk as we only ever drive the pin
// high
// for a hundred ms or so. The expected result is simply voltage sag on pin 2 which is acceptable.
// Pin 4 can safely short anywhere on the connector thanks to the series resistor.
// That should be all combinations of resonably possible shorts handled.

namespace xtd {
  extern xtd::ostream<xtd::uart_stream_tag> cout;
}

#endif
