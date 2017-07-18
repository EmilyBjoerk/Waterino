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

#include "pinmap.hpp"

using namespace xtd::chrono_literals;

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
