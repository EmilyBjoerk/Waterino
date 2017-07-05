#include "xtd/bootstrap.hpp"
#include "xtd/chrono.hpp"
#include "xtd/gpio.hpp"
#include "xtd/sleep.hpp"
#include "xtd/uart.hpp"

#include <avr/eeprom.h>
#include <avr/pgmspace.h>

#include "controller.hpp"
#include "eeprom_layout.hpp"
#include "probe.hpp"
#include "pump.hpp"

using namespace xtd::chrono_literals;

// ------------ Pin definitions taken from Rev A schematic ---------------------
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

void fatal(bool short_circuit, bool water_level) {
  // Regardles of how we got here, always make sure that the pump is disabled.
  xtd::gpio_write(c_pin_pump, false);

  if (short_circuit) {
    xtd::gpio_write(c_pin_short_circuit_led, true);
  }

  if (water_level) {
    xtd::gpio_write(c_pin_water_level_led, true);
  }

  while (true)  // TODO: Ring buzzer
    ;
}

Pump pump(c_pin_pump, c_pin_level_alert_analog,
          eeprom_layout::addr_of(&eeprom_layout::pump_max_duration),
          eeprom_layout::addr_of(&eeprom_layout::pump_active));
Probe probe(c_pin_moisture_pos, c_pin_moisture_neg, c_pin_moisture_analog, 250, c_pin_thermal_pos,
            c_pin_thermal_analog);
Controller controller(eeprom_layout::addr_of(&eeprom_layout::pid_kp),
                      eeprom_layout::addr_of(&eeprom_layout::pid_ki),
                      eeprom_layout::addr_of(&eeprom_layout::pid_si),
                      eeprom_layout::addr_of(&eeprom_layout::pid_target_period));

ISR(INT0_vect) { pump.overflow(); }

int main() {
  // ---------------------------------------------------------------------------
  // Init MCU to low power state, check WDT and figure out why we're resetting.
  // ---------------------------------------------------------------------------
  /*auto reset_cause = */ xtd::bootstrap(false);

  // ---------------------------------------------------------------------------
  // Setup GPIO pins to default states
  // ---------------------------------------------------------------------------
  DIDR0 = 0b110111 << ADC0D;  // Enable needed digital pins on port C

  xtd::gpio_config(c_pin_rx_led, xtd::gpio_mode::output, true);
  xtd::gpio_config(c_pin_tx_led, xtd::gpio_mode::output, true);
  xtd::gpio_config(c_pin_short_circuit_led, xtd::gpio_mode::output, false);
  xtd::gpio_config(c_pin_water_level_led, xtd::gpio_mode::output, false);
  xtd::gpio_config(c_pin_buzzer, xtd::gpio_mode::output, false);

  xtd::uart.enable();  // TODO: Attach RX/TX LEDs
  xtd::uart << "Waterino starting...\n";

  // Did the MCU reset in the middle of a pump activation?
  if (pump.is_pumping()) {
    xtd::uart << "MCU was shutdown due to fuse tripping.\n";
    xtd::uart << "Check PUMP connector/reservoir for short circuit and reset device.\n";
    xtd::gpio_write(c_pin_short_circuit_led, true);
    pump.reset_pumping();  // Clear flag.
    fatal(true, false);    // Never returns.
  }

  // ---------------------------------------------------------------------------
  // Control loop
  // ---------------------------------------------------------------------------
  xtd::chrono::steady_clock::time_point last_probe;
  constexpr auto probe_period = 2_h;
  while (true) {
    auto now = xtd::chrono::steady_clock::now();
    if (last_probe.time_since_epoch().count() == 0 || now - last_probe > probe_period) {
      last_probe = now;
      if (probe.is_dry()) {
        if (pump.has_overflowed()) {
          // It is possible that the target watering period simply isn't possible due to
          // too small pot or other physical effects. This is indicated by an overflow.
          // Advise the controller.
          controller.advise_overflowed();
        }

        auto pump_duration = controller.compute(now);
        xtd::uart << "Activating pump for: " << xtd::chrono::milliseconds(pump_duration).count()
                  << "ms\n";

        auto pump_result = pump.activate(pump_duration);
        if (pump_result == Pump::Result::level_short_circuit) {
          fatal(true, false);
        } else if (pump_result == Pump::Result::level_low) {
          fatal(false, true);
        } else if (pump_result == Pump::Result::overflow) {
          xtd::uart << "Pot overflowed!\n";
        }
      }
    }
    xtd::sleep(probe_period);
  }
}
