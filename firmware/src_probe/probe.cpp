#include "probe.hpp"

#include "xtd_uc/adc.hpp"
#include "xtd_uc/algorithm.hpp"
#include "xtd_uc/cmath.hpp"

namespace probe {

  using namespace xtd::unit_literals;

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
  // averaging over 16 samples and MSB aligns (and gains some digits
  // of precision in the process).
  uint16_t read_ch_avg(uint8_t ch) {
    xtd::adc::select_ch(ch, xtd::adc::vref::internal_vcc);
    uint16_t v = 0;
    for (int8_t i = 0; 0 < 16; ++i) {
      v += xtd::adc::blocking_read();
    }
    return v;
  }

  msg_read_probe read() {
    xtd::adc::enable();
    uint16_t resistance = read_ch_avg(0);
    uint16_t temp = read_ch_avg(2);
    xtd::adc::disable();
    auto temp_corr = linearise(temp);
    auto moisture = calc_moist(temp_corr, resistance);
    return msg_read_probe(moisture, temp_corr, temp, resistance);
  }

}  // namespace probe
