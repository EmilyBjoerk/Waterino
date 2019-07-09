#include <avr/interrupt.h>
#include <avr/io.h>
#include "xtd_uc/chrono.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/gpio.hpp"
#include "xtd_uc/uart.hpp"
#include "xtd_uc/units.hpp"

using namespace xtd::unit_literals;

constexpr xtd::gpio_pin ref_top(xtd::port_b, 2);
constexpr xtd::gpio_pin ref_bot(xtd::port_d, 5);  // Also T1
xtd::ostream<xtd::uart_stream_tag> uart;

/*
 * Both ends of a 1:2 ratio voltage divider are connected to GPIO pins.
 * The midpoint of the voltage divider is connected to the positive pin
 * of the analog comparator. The top pin is charging an RC net and the
 * output of the RC net is the negative pin of the analog comparator.
 *
 * When the divider is positively oriented (top pin +, bottom pin -) then
 * the positive pin of the comparator is 2/3 VCC and the RC net is being
 * charged from 0 to VCC. One the output of the RC net crosses 2/3 VCC
 * The analog comparator raises an IRQ, swapping the top and bottom pin
 * voltages, changing the positive pin voltage to 1/3 VCC and the RC
 * net starts to discharge from 2/3 VCC to 1/3 VCC and the IRQ trips again
 * swapping the pins and so the output of the RC net will oscillate between
 * 1/3 and 2/3 VCC. This is analoguous to a 555 timer in astable 50% duty
 * cycle mode.
 *
 * On the discharge and charge IRQ from the analog comparator we will toggle
 * the T1 pin manually to cause the TIMER/COUNTER1 (which has been suitably
 * configured) to count up one.
 *
 * On TIMER/COUNTER1 overflow we will stop the the counter, break the
 * charge/discharge cycle, and measure how many CPU clockcycles it took for
 * TIMER/COUNTER1 (which is a 16 bit timer) to overflow. Based on this we
 * know the frequency that the RC net oscillated with.
 *
 * The number of CPU clock cycles it took to count up 2^16 relates to the
 * frequency, F, like so: F = 2^16/cycles.
 *
 * This gives the sensed capacitance as F = 1 / (2*ln(2)*R*C)
 * or C = cycles / (2*ln(2)*R*2^16). (#1)
 *
 * We'll assume that the influence of noise on the RC net is low enough to
 * not affect the frequency of the output.
 *
 * The capacitance of the RC net will consist of a parasitic capacitance
 * to the ground plane along the trace to the sensort track and behind
 * the sensor track. We assume this parasitic capacitance has a negligible
 * temperatur dependency compared to the other parts of the sensor in
 * contact with water. This is motivated by the fact that water has around
 * 80 times higher dielectric constant than air and 20 times higher than FR4,
 * and that the separation from the ground plane is relatively high (1.6 mm).
 * A small part of the sensor track is above the ground and dependent on the
 * humidity and temperature. Again here we will assume that the variance
 * of this capacitance due to humidity and temperature will be dominated by
 * the variance of the capacitance of the sensor in contact with the soil
 * and water in the soil.
 *
 * For the above reasons we consider the total capacitance sensed as:
 * C(m,t) = Ck + Cs(m,t) where m is the soil moisture level and t is the
 * temperature of the soil. We know that capacitance is a linear function
 * of the dielectric value regardless of geometry. We know that the dielectric
 * of water depends on the temperature (non linearly).
 *
 * So we can express Cs(m,t) as: A + B*m*T(t). Where T is the temperature
 * dependency of the water's dielectric value. However we can bake A into
 * Ck and rename B as Cs and thus we get:
 *
 * C(m,t) = Ck + Cs*m*T(t)
 *
 * Let's take two calibration points at temperature: t = t_cal. We'll assume
 * that soil can never have less moisture content than the absolute humidity
 * of the air. So our "dry" reference is free air (at some humidity). And
 * our "wet" refrence is with the sensor submerged in water to the same level
 * as the soil will be when in use.
 *
 * Then we have: Cair = C(m_min, t_cal) and Cwater = C(m_max, t_cal).
 *
 * And if we have a measurement of C(m=M,t=t_cal) as C we can solve for 'm' as:
 *
 * m = (C - Cair) / (Cwater - Cair)
 *   = /Substitute and simplify/
 *   = (M*T(t=t_cal) - m_min*T(t_cal))/(m_max*T(t_cal) - m_min*T(t_cal))
 *   = (M*T(t=t_cal)/T(t_cal) - m_min)/(m_max - m_min)
 *
 * So if we let C' = C * T(t_cal)/T(t) and do the above exercise again but let
 * 't' be a free variable, we end up with:
 *
 * m = (M - m_min + E)/(m_max - m_min)
 * E = Ck/Cs*(T(t_cal)/T(t) -1)
 *
 * We know T(t) and can compute it. And because T(t) varies slowly with 't',
 * T(t_cal)/T(t) ~= 1 for t_cal close to 't' and Ck is small compared to Cs
 * using C' = instead of C will yield a smaller error for m than using C directly.
 *
 * Using (#1) above to convert from cycles to capacitance we can see that if
 * the calibration points are also taken as cycle counts, the constant factor
 * 1/(2*ln(2)*R*2^16) will cancel out.
 *
 * So the final formula for 'm':
 *
 * m = (cycles*T(t_cal)/T(t) - cycles_air) / (cycles_water - cycles_air), m = [0,1].
 *
 * Note that it is possible for m to be slightly outside the above ranget due
 * to the fact that we have ignored the (small) dependency on air moisture
 * and air temperature and the approximations made.
 *
 * The calibration points should be taken at the middle of the typical operating
 * temperature range for best accuracy.
 */

ISR(ANALOG_COMP_vect, ISR_NAKED) {
  if (PORTB & _BV(PINB2)) {
    // We were charging, start discharging
    PORTB &= ~_BV(PINB2);
    PORTD |= _BV(PIND5);
    // TODO: toggle T1 (and thus LED) because I fail layout
  } else {
    // We were discharging, start charging
    PORTB |= _BV(PINB2);
    PORTD &= ~_BV(PIND5);
    // TODO: toggle T1 (and thus LED) because I fail layout
  }
}

ISR(TIMER1_OVF_vect) { TCCR1B = 0; }

void init() {
  cli();
  xtd::gpio_config(ref_top, xtd::output, false);
  xtd::gpio_config(ref_bot, xtd::output, false);
  xtd::delay(100_ms);
  ADCSRB = 0;       // ACME = 0, use AIN1
  ACSR = _BV(ACI);  // | _BV(ACIS1);
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
    while (TCCR1B)
      ;
    auto end = xtd::chrono::steady_clock::now();

    auto duration = end - start;
    using inv_scale = decltype(1 / duration)::scale;
    auto hz = xtd::ratio_scale<inv_scale>(0xFFFF) / duration;
    uart << hz.count() << " hz\n";
    xtd::uart_flush();
  }
}
