#include "xtd_uc/adc.hpp"
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/gpio.hpp"
#include "xtd_uc/sleep.hpp"
#include "xtd_uc/uart.hpp"
#include "xtd_uc/wdt.hpp"

#include "xtd_uc/ostream.hpp"

#include "../src/pinmap.hpp"
#include "../src/pump.hpp"

namespace xtd {
  xtd::ostream<xtd::uart_stream_tag> cout;
}

volatile bool received_keypress = false;

__attribute__((used)) void uart_rx_cb(char, xtd::uart_rx_status s) {
  if (s == xtd::uart_rx_flags::good) {
    received_keypress = true;
  }
}

void prompt(const char* str) {
  xtd::cout << str;
  received_keypress = false;
  while (!received_keypress) {
    /* no-op */
  }
}

int main() {
  xtd::gpio_config(c_pin_pump, xtd::gpio_mode::output, false);

  xtd::watchdog::disable_reset();
  xtd::uart_configure(uart_rx_cb);
  xtd::cout << "Disconnect connectors before continuing\n";

  xtd::adc::enable();
  xtd::adc::select_ch(c_pin_level_alert_analog, xtd::adc::vref::internal_vcc);
  xtd::adc::blocking_read();  // Discard first read after selecting internal reference.

  // ---------------------------------------------------------------------------
  // Verify PUMP connector first
  // ---------------------------------------------------------------------------
  xtd::cout << "----------- Verifying PUMP Connector and \n";
  xtd::gpio_write(c_pin_pump, true);
  prompt("Check voltage pins 4 -> 3 is +12V on PUMP and PUMP_LED ON\n");
  xtd::gpio_write(c_pin_pump, false);
  prompt("Check voltage pins 4 -> 3 is 0V on PUMP and PUMP_LED OFF\n");

  auto level = xtd::adc::blocking_read();
  if (level > Pump::LEVEL_OK_UB) {
    xtd::cout << "LEVEL_ALERT is above threshold\n";
  } else if (level < Pump::LEVEL_OK_LB) {
    xtd::cout << "LEVEL_ALERT is belov threshold\n";
  } else {
    xtd::cout << "LEVEL_ALERT is OK\n";
  }

  prompt("Supply 12V on pin 1 of PUMP\n");
  level = xtd::adc::blocking_read();
  if (level < Pump::LEVEL_OK_UB) {
    xtd::cout << "LEVEL_ALERT is too low\n";
  }

  prompt("Supply 0V on pin 1 of PUMP\n");
  level = xtd::adc::blocking_read();
  if (level > Pump::LEVEL_OK_LB) {
    xtd::cout << "LEVEL_ALERT is too high\n";
  }

  // ---------------------------------------------------------------------------
  // Then LEDs and Chassis connector
  // ---------------------------------------------------------------------------
  xtd::cout << "----------- Verifying Chassis Connector and LEDs\n";
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
  xtd::cout << "----------- PLANT connector\n";
  prompt("Check pin 1 and 6 on PLANT is GND\n");
  prompt("Check pin 5 on PLANT is +5V\n");

  if (!xtd::gpio_read(c_pin_overflow)) {
    xtd::cout << "Error: Overflow active\n";
  }
  prompt("Short GND to pin 5 on PLANT \n");
  if (xtd::gpio_read(c_pin_overflow)) {
    xtd::cout << "Error: Overflow not active\n";
  }

  xtd::gpio_config(c_pin_thermal_pos, xtd::gpio_mode::output, true);
  xtd::delay(100_ms);
  xtd::adc::select_ch(c_pin_thermal_analog, xtd::adc::vref::internal_vcc);
  auto therm = xtd::adc::blocking_read();
  if (1023 != therm) {
    xtd::cout << "Expected +5V at THERM, adc read: " << therm << "\n";
  }
  prompt("Short GND to pin 4 on PLANT\n");
  therm = xtd::adc::blocking_read();
  if (0 != therm) {
    xtd::cout << "Expected 0V at THERM, adc read: " << therm << "\n";
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
    xtd::cout << "Expected 5V at MOISTURE, adc read: " << moist << "\n";
  }
  prompt("Short GND to pin 3 on PLANT\n");
  moist = xtd::adc::blocking_read();
  if (0 != moist) {
    xtd::cout << "Expected 0V at MOISTURE, adc read: " << moist << "\n";
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
