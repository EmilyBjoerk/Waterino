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

void overflow_cb(){
  HAL::uart<<"ovf\n";
}

int main() {
  Application app;
  xtd::uart_configure(nullptr);
  
  HAL::uart << xtd::pstr(PSTR("Waterino starting\n"));

  /*
  while(1){
    if(HAL::sense_overflow()){
      HAL::uart<<"ovf\n";
    }else{
      HAL::uart<<"nof\n";
    }
    xtd::wdt_reset_timeout();
    xtd::delay(1_s);
  }*/

  /*
  while(1){
    HAL::pump_led_on();
    HAL::uart<<"enabled\n";
    HAL::sense_overflow_enable_irq(overflow_cb);

    xtd::wdt_reset_timeout();
    xtd::delay(5_s);
    xtd::wdt_reset_timeout();
    xtd::delay(5_s);
  
    HAL::pump_led_off();
    HAL::sense_overflow_disable_irq();
    HAL::uart << "disabled\n";
    xtd::wdt_reset_timeout();
    xtd::delay(5_s);
  }*/
  
  while (true) {
    /*auto can_deep_sleep =*/ app.run();
    xtd::sleep(HAL::sense_period, false);
    //xtd::delay(5_s);
  }
}
