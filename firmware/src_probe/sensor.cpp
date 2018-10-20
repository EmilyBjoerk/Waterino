#include "xtd_uc/units.hpp"

#include <avr/interrupt.h>

/*
 * 4 Signals are a part of the moisture sensing circuit:
 * ~RC_EXC = PD5 - Drive low to power RC_REF (Vref).
 * RC_EN = PB0 - Charge/~Drain the RC network for measuring.
 * C_sense = AIN1/PD7 - Sense the charge in the RC network.
 * RC_REF = AIN0/PD6 - Reference voltage for the comparator.
 *
 * Measuring procedure:
 * 1) Drain Csense by driving RC_EN (PB0) low and drive RC_EXC low to power up RC_REF.
 * 2) Wait until C_sense is drained completely
 *    (at 1nF and 1MR around 5 ms through RC_EN if C_sense is charged to 5V).
 * 3) Mask global interrupts.
 * 3) Enable Analog Comparator and setup to trigger IRQ when C_sense >= RC_REF (AIN1 >= AIN0).
 * 6) Clear outstanding analog comparator IRQ flags and clear timer overflow counter.
 * 7) Unmask global IRQ.
 * 8) Start charging C_sense by driving RC_EN (PB0) high.
 * 9) Start timer 
 * 10) Sleep µC until "done"

Timer overflow IRQ: Count up time counter.
Analog comparator IRQ: Read timer value and combine with counter to compute actual time and mark done.

 */

using namespace xtd::unit_literals;

constexpr auto c_max_capacitance = 1_nF;
constexpr auto c_known_resistance = 1_MOhm;
constexpr auto c_5_tau = 5 * c_known_resistance * c_max_capacitance;

volatile uint16_t g_timer_overflows;
volatile uint8_t g_timer_value;
volatile bool g_measurement_done;

ISR(ANALOG_COMP_vect){
  g_timer_value = TCNT0;
  g_measurement_done = true;
}

ISR(TIMER0_OVF_vect){
  g_timer_overflows++;
}

uint8_t measure(){

  
  return 0;
}
