#include "application.hpp"
#include "hardware.hpp"

#include "xtd_uc/sleep.hpp"
#include "xtd_uc/wdt.hpp"
#include "xtd_uc/blink.hpp"

void blink(){
  for(int i = 0; i < 3;++i){
    HAL::pump_led_on();
    xtd::delay(333_ms);
    HAL::pump_led_off();
    xtd::delay(777_ms);
  }
}

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
