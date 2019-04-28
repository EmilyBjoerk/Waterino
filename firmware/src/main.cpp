#include "application.hpp"
#include "hardware.hpp"

#include "xtd_uc/sleep.hpp"
#include "xtd_uc/wdt.hpp"

int main() {
  Application app;
  xtd::uart_configure(nullptr);
  HAL::uart << xtd::pstr(PSTR("Waterino starting\n"));

  while (true) {
    /*auto can_deep_sleep =*/ app.run();
    xtd::sleep(HAL::sense_period, false);
    //xtd::delay(5_s);
  }
}
