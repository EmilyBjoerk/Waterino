#include "xtd_uc/bootstrap.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/gpio.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/uart.hpp"

#include <avr/eeprom.h>
#include <avr/pgmspace.h>

#include "cmdinterpreter.hpp"
#include "controller.hpp"
#include "eeprom_layout.hpp"
#include "pinmap.hpp"
#include "probe.hpp"
#include "pump.hpp"

namespace xtd {
  xtd::ostream<xtd::uart_stream_tag> cout;
}

using namespace xtd::chrono_literals;

Pump g_pump(c_pin_pump, c_pin_level_alert_analog,
            eeprom_layout::addr_of(&eeprom_layout::pump_max_duration),
            eeprom_layout::addr_of(&eeprom_layout::pump_active));

Probe g_probe(c_pin_moisture_pos, c_pin_moisture_neg, c_pin_moisture_analog, 220, c_pin_thermal_pos,
              c_pin_thermal_analog);

Controller g_controller(eeprom_layout::addr_of(&eeprom_layout::pid_kp),
                        eeprom_layout::addr_of(&eeprom_layout::pid_ki),
                        eeprom_layout::addr_of(&eeprom_layout::pid_si),
                        eeprom_layout::addr_of(&eeprom_layout::pid_target_period));

CmdInterpreter g_cmd_interpreter(&g_pump, &g_probe, &g_controller);

// Will light the status LEDs, sound the buzzer and stop the MCU until reset.
void fatal(bool short_circuit, bool water_level) {
  // Regardles of how we got here, always make sure that the pump is disabled.
  xtd::gpio_write(c_pin_pump, false);
  xtd::gpio_write(c_pin_short_circuit_led, short_circuit);
  xtd::gpio_write(c_pin_water_level_led, water_level);
  while (true)
    ;  // TODO: Ring buzzer
}

// This method is oppurtunistically called from the sleep() method when MCU wakes from sleep state.
// In essence it allows "background processing" during a call to "sleep()". Not ran from ISR.
// Attribute(used) is needed to prevent the linker from removing the function as there are no
// (direct)
// calls to it, it is however called through a function pointer.
__attribute__((used)) bool sleeping_irq_callback() {
  g_cmd_interpreter.execute_available();
  return true;
}

// This method is called every time a character is received on the UART.
// It is executed from ISR and must be short.
// Attribute(used) is needed to prevent the linker from removing the function as there are no
// (direct)
// calls to it, it is however called through a function pointer.
__attribute__((used)) void rx_callback(char c, xtd::uart_rx_status status) {
  if (status != xtd::uart_rx_flags::good) {
    g_cmd_interpreter.rx_error();
  } else {
    g_cmd_interpreter.accept(c);
  }
}

// INT0 is connected to the overflow detection and set to trigger on low level.
ISR(INT0_vect) { g_pump.overflow(); }

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
  // xtd::gpio_config(c_pin_tx_led, xtd::gpio_mode::output, true);
  xtd::gpio_config(c_pin_short_circuit_led, xtd::gpio_mode::output, false);
  xtd::gpio_config(c_pin_water_level_led, xtd::gpio_mode::output, false);
  xtd::gpio_config(c_pin_buzzer, xtd::gpio_mode::output, false);

  xtd::uart_configure(rx_callback);

  xtd::cout << xtd::pstr(PSTR("Waterino starting...\n"));

  // Did the MCU reset in the middle of a pump activation?
  if (g_pump.is_pumping()) {
    xtd::cout << xtd::pstr(PSTR("MCU was shutdown due to fuse tripping.\n"));
    xtd::cout << xtd::pstr(
        PSTR("Check PUMP connector/reservoir for short circuit and reset device.\n"));
    xtd::gpio_write(c_pin_short_circuit_led, true);
    g_pump.reset_pumping();  // Clear flag.
    fatal(true, false);      // Never returns.
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
      if (g_probe.is_dry()) {
        if (g_pump.has_overflowed()) {
          // It is possible that the target watering period simply isn't possible due to
          // too small pot or other physical effects. This is indicated by an overflow.
          // Advise the controller.
          //g_controller.report_overflow(); //TODO: FIXME
        }

        auto pump_duration = g_controller.compute(now);
	g_controller.report_activation(now);
        xtd::cout << xtd::pstr(PSTR("Activating pump for: "))
                  << xtd::chrono::milliseconds(pump_duration).count() << xtd::pstr(PSTR("ms\n"));

        auto pump_result = g_pump.activate(pump_duration);
        if (pump_result == Pump::Result::level_short_circuit) {
          fatal(true, false);
        } else if (pump_result == Pump::Result::level_low) {
          fatal(false, true);
        } else if (pump_result == Pump::Result::overflow) {
          xtd::cout << xtd::pstr(PSTR("Pot overflowed!\n"));
        }
      }
    }
    xtd::sleep(probe_period, false, sleeping_irq_callback);
  }
}
