#include "application.hpp"
#include "hardware.hpp"

#include "xtd_uc/sleep.hpp"

int main() {
  xtd::uart_configure(nullptr);
  Application app;
  
  HAL::uart << xtd::pstr(PSTR("Waterino starting\n"));

  while (true) {
    auto can_deep_sleep = app.run();
    xtd::sleep(HAL::sense_period, can_deep_sleep);
  }
}
