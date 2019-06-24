#include "xtd_uc/delay.hpp"
#include "xtd_uc/gpio.hpp"
#include "xtd_uc/uart.hpp"
#include "xtd_uc/units.hpp"
#include "xtd_uc/chrono.hpp"
#include <avr/interrupt.h>
#include <avr/io.h>

using namespace xtd::unit_literals;

constexpr xtd::gpio_pin ref_top(xtd::port_b, 2);
constexpr xtd::gpio_pin ref_bot(xtd::port_d, 5); // Also T1 
xtd::ostream<xtd::uart_stream_tag> uart;

ISR(ANALOG_COMP_vect, ISR_NAKED){
  if(PORTB & _BV(PINB2)){
    // We were charging, start discharging
    //ACSR |= _BV(ACIS0);
    PORTB &= ~_BV(PINB2);
    PORTD |= _BV(PIND5);
  }else{
    // We were discharging, start charging
    //ACSR &= ~_BV(ACIS0);
    PORTB |= _BV(PINB2);
    PORTD &= ~_BV(PIND5);
  }
}

ISR(TIMER1_OVF_vect){
  TCCR1B = 0;
}

void init(){
  cli();
  xtd::gpio_config(ref_top, xtd::output, false);
  xtd::gpio_config(ref_bot, xtd::output, false);
  xtd::delay(100_ms);
  ADCSRB = 0; // ACME = 0, use AIN1
  ACSR = _BV(ACI);// | _BV(ACIS1);
  DIDR1 = 0x3;
  TCCR1A = 0;
  TCCR1B = 0;
  TCCR1C = 0;
  TCNT1 = 0;
  TIMSK1 = _BV(TOIE1);
  TIFR1 = 0xFF;
  sei();
}

int main() {
  xtd::uart_configure(nullptr);
  uart << xtd::pstr(PSTR("Waterino starting\n"));
  xtd::chrono::steady_clock::now();
 
  while (true) {
    init();
    
    auto start = xtd::chrono::steady_clock::now();
    TCCR1B = _BV(CS12) | _BV(CS11) | _BV(CS10);
    xtd::gpio_config(ref_top, xtd::output, true);
    ACSR |= _BV(ACIE);
    while(TCCR1B);
    auto end = xtd::chrono::steady_clock::now();

    auto duration = end - start;
    using inv_scale = decltype(1/duration)::scale;
    auto    hz = xtd::ratio_scale<inv_scale>(0xFFFF)/duration;
    uart << hz.count() << " hz\n";
    xtd::uart_flush();
  }
}
