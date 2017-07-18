#include "xtd/adc.hpp"
#include "xtd/chrono.hpp"
#include "xtd/gpio.hpp"
#include "xtd/sleep.hpp"
#include "xtd/uart.hpp"
#include "xtd/wdt.hpp"

#include "../src/pinmap.hpp"
#include "../src/pump.hpp"

void prompt(const char* str) {
  xtd::uart << str;
  while (!xtd::uart.has_char()) {
    // xtd::uart << '.';
    // xtd::delay(1_s);
  }
  xtd::uart.get();
}

int main() {
  xtd::gpio_config(c_pin_pump, xtd::gpio_mode::output, false);

  xtd::watchdog::disable_reset();
  xtd::uart.enable();
  xtd::uart << "Disconnect connectors before continuing\n";

  xtd::adc::enable();
  xtd::adc::select_ch(c_pin_level_alert_analog, xtd::adc::vref::internal_vcc);
  xtd::adc::blocking_read();  // Discard first read after selecting internal reference.

  // ---------------------------------------------------------------------------
  // Verify PUMP connector first
  // ---------------------------------------------------------------------------
  xtd::uart << "----------- Verifying PUMP Connector and \n";
  xtd::gpio_write(c_pin_pump, true);
  prompt("Check voltage pins 4 -> 3 is +12V on PUMP and PUMP_LED ON\n");
  xtd::gpio_write(c_pin_pump, false);
  prompt("Check voltage pins 4 -> 3 is 0V on PUMP and PUMP_LED OFF\n");

  auto level = xtd::adc::blocking_read();
  if (level > Pump::LEVEL_OK_UB) {
    xtd::uart << "LEVEL_ALERT is above threshold\n";
  } else if (level < Pump::LEVEL_OK_LB) {
    xtd::uart << "LEVEL_ALERT is belov threshold\n";
  } else {
    xtd::uart << "LEVEL_ALERT is OK\n";
  }

  prompt("Supply 12V on pin 1 of PUMP\n");
  level = xtd::adc::blocking_read();
  if (level < Pump::LEVEL_OK_UB) {
    xtd::uart << "LEVEL_ALERT is too low\n";
  }

  prompt("Supply 0V on pin 1 of PUMP\n");
  level = xtd::adc::blocking_read();
  if (level > Pump::LEVEL_OK_LB) {
    xtd::uart << "LEVEL_ALERT is too high\n";
  }

  // ---------------------------------------------------------------------------
  // Then LEDs and Chassis connector
  // ---------------------------------------------------------------------------
  xtd::uart << "----------- Verifying Chassis Connector and LEDs\n";
  prompt("Check pin 4 on CASE is GND\n");

  xtd::gpio_config(c_pin_buzzer, xtd::gpio_mode::output, true);
  prompt("Check BUZ on CASE is +5V\n");
  xtd::gpio_write(c_pin_buzzer, false);
  prompt("Check BUZ on CASE is GND\n");
  xtd::gpio_config(c_pin_buzzer, xtd::gpio_mode::tristate);

  xtd::gpio_config(c_pin_water_level_led, xtd::gpio_mode::output, true);
  prompt("Check LEVEL on CASE is +5V\n");
  xtd::gpio_write(c_pin_water_level_led, false);
  prompt("Check LEVEL on CASE is GND\n");
  xtd::gpio_config(c_pin_water_level_led, xtd::gpio_mode::tristate);

  xtd::gpio_config(c_pin_short_circuit_led, xtd::gpio_mode::output, true);
  prompt("Check SHRT on CASE is +5V\n");
  xtd::gpio_write(c_pin_short_circuit_led, false);
  prompt("Check SHRT on CASE is GND\n");
  xtd::gpio_config(c_pin_short_circuit_led, xtd::gpio_mode::tristate);

  xtd::gpio_config(c_pin_rx_led, xtd::gpio_mode::output, false);
  prompt("Check RX LED on\n");
  xtd::gpio_write(c_pin_rx_led, true);
  prompt("Check RX LED off\n");
  xtd::gpio_config(c_pin_rx_led, xtd::gpio_mode::tristate);

  xtd::gpio_config(c_pin_tx_led, xtd::gpio_mode::output, false);
  prompt("Check TX LED on\n");
  xtd::gpio_write(c_pin_tx_led, true);
  prompt("Check TX LED off\n");
  xtd::gpio_config(c_pin_tx_led, xtd::gpio_mode::tristate, false);

  // ---------------------------------------------------------------------------
  // Check plant connector
  // ---------------------------------------------------------------------------
  xtd::uart << "----------- PLANT connector\n";
  prompt("Check pin 1 and 6 on PLANT is GND\n");
  prompt("Check pin 5 on PLANT is +5V\n");

  if (!xtd::gpio_read(c_pin_overflow)) {
    xtd::uart << "Error: Overflow active\n";
  }
  prompt("Short GND to pin 5 on PLANT \n");
  if (xtd::gpio_read(c_pin_overflow)) {
    xtd::uart << "Error: Overflow not active\n";
  }

  xtd::gpio_config(c_pin_thermal_pos, xtd::gpio_mode::output, true);
  xtd::delay(100_ms);
  xtd::adc::select_ch(c_pin_thermal_analog, xtd::adc::vref::internal_vcc);
  auto therm = xtd::adc::blocking_read();
  if (1023 != therm) {
    xtd::uart << "Expected +5V at THERM, adc read: " << therm << "\n";
  }
  prompt("Short GND to pin 4 on PLANT\n");
  therm = xtd::adc::blocking_read();
  if (0 != therm) {
    xtd::uart << "Expected 0V at THERM, adc read: " << therm << "\n";
  }
  xtd::gpio_config(c_pin_thermal_pos, xtd::gpio_mode::tristate);

  xtd::gpio_config(c_pin_moisture_neg, xtd::gpio_mode::output, true);
  prompt("Check pin 2 on PLANT is +5V\n");
  xtd::gpio_write(c_pin_moisture_neg, false);
  prompt("Check pin 2 on PLANT is GND\n");

  xtd::gpio_config(c_pin_moisture_pos, xtd::gpio_mode::output, true);
  xtd::delay(100_ms);
  xtd::adc::select_ch(c_pin_moisture_analog, xtd::adc::vref::internal_vcc);
  auto moist = xtd::adc::blocking_read();
  if (1023 != moist) {
    xtd::uart << "Expected 5V at MOISTURE, adc read: " << moist << "\n";
  }
  prompt("Short GND to pin 3 on PLANT\n");
  moist = xtd::adc::blocking_read();
  if (0 != moist) {
    xtd::uart << "Expected 0V at MOISTURE, adc read: " << moist << "\n";
  }
  xtd::gpio_config(c_pin_moisture_pos, xtd::gpio_mode::tristate);

  // ---------------------------------------------------------------------------
  // Check extension connectors
  // ---------------------------------------------------------------------------
  prompt("Check pin 1 on EXT_A is +5V\n");
  prompt("Check pin 3 on EXT_A is GND\n");
  xtd::gpio_config(c_pin_int1, xtd::gpio_mode::output, true);
  prompt("Check INT1 on EXT_A is +5V\n");
  xtd::gpio_write(c_pin_int1, false);
  prompt("Check INT1 on EXT_A is GND\n");
  xtd::gpio_config(c_pin_int1, xtd::gpio_mode::tristate);

  prompt("Push reset\n");
  while (1)
    ;
}
