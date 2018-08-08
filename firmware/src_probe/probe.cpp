#include "probe.hpp"

#include "xtd_uc/adc.hpp"
#include "xtd_uc/algorithm.hpp"
#include "xtd_uc/cmath.hpp"
#include "xtd_uc/delay.hpp"

namespace probe {

  using namespace xtd::unit_literals;
  using namespace xtd::chrono_literals;

  struct correction_point {
    uint16_t raw;
    temperature correct;
  };

  // Increasing order of raw values
  // XXX: Use PROGMEM for this if needed.
  // FIXME: Generate table from wxmaxima
  static correction_point correction_lut[] = {{100, 273_K}, {300, 300_K}};

  temperature linearise(uint16_t raw) {
    auto begin = &(correction_lut[0]);
    auto end = begin + sizeof(correction_lut) / sizeof(correction_lut[0]);
    auto p = begin;

    while (p != end && raw > p->raw) {
      p++;
    }

    if (p == begin) {
      return msg_read_probe::temp_lo;
    }

    if (p == end) {
      return msg_read_probe::temp_hi;
    }

    // Use int64 for everything to avoid overflows.
    // Performance isn't really a concern here.
    auto left_raw = static_cast<int64_t>((p - 1)->raw);
    auto left_corr = static_cast<int64_t>((p - 1)->correct.v);
    auto right_raw = static_cast<int64_t>(p->raw);
    auto right_corr = static_cast<int64_t>(p->correct.v);

    auto num = (left_corr * (right_raw - raw) + right_corr * (raw - left_raw));
    auto den = (right_raw - left_raw);

    auto ans = xtd::divide<int64_t, xtd::round_style::nearest>(num, den);

    return static_cast<int16_t>(xtd::clamp<int64_t>(ans, xtd::numeric_limits<int16_t>::min(),
                                                    xtd::numeric_limits<int16_t>::max()));
  }

  uint16_t calc_moist(temperature temp_corr, uint16_t resistance) {
    return resistance / temp_corr.v;
  }

  // ADC is 10 bits, result is LSB aligned. The below performs
  // averaging over 64 (2^6) samples and MSB aligns (and gains some digits
  // of precision in the process).
  uint16_t read_ch_avg(uint8_t ch) {
    xtd::adc_select_ch(ch);
    uint16_t v = 0;
    for (int8_t i = 0; i < (1 << 6); ++i) {
      v += xtd::adc_read_single_low_noise();
    }
    return v;
  }

  constexpr uint8_t moist_p = PB5;
  constexpr uint8_t moist_n = PB1;
  constexpr uint8_t moist_a_ch = 3;

  // If we consider the probe and pot an RC system, with total resistance bounded by 100k and a
  // total capacitance on 10µF, we get 5T=5RC=5ms, pick 10 for margin

  constexpr auto settling_time = 10_ms;

  void stop_excitation() {
    // Order is important here, this moves from output high to pullup to tristate
    DDRB &= ~(_BV(moist_p) | _BV(moist_n));
    PORTB &= ~(_BV(moist_p) | _BV(moist_n));
  }

  msg_read_probe read() {
    xtd::adc_enable(10000, false, xtd::adc_internal_vcc, moist_a_ch);

    stop_excitation();  // Shouldnt be necessary but doesn't hurt, both pins tristate
    DDRB |= _BV(moist_p) | _BV(moist_n);  // Both low
    xtd::set_bit(PORTB, moist_p);         // MOIST+ high
    xtd::delay(settling_time);

    uint16_t resistance_p = read_ch_avg(moist_a_ch);

    xtd::clr_bit(PORTB, moist_p);  // Both low
    xtd::set_bit(PORTB, moist_n);  // MOIST- high
    xtd::delay(settling_time);

    uint16_t resistance_n = read_ch_avg(moist_a_ch);
    xtd::clr_bit(PORTB, moist_n);  // Both low
    stop_excitation();             // Both pins tristate

    uint16_t temp = read_ch_avg(2);
    xtd::adc_disable();

    uint16_t resistance_avg =
        (resistance_p >> 1) + (resistance_n >> 1) + (resistance_p & resistance_n & 1);

    auto temp_corr = 0;  // linearise(temp);
    auto moisture = 3;   // calc_moist(temp_corr, resistance);
    return msg_read_probe(moisture, temp_corr, temp, resistance_avg, resistance_p, resistance_n);
  }

}  // namespace probe
