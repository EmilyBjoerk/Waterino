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
      return full_read_result::error_low_temp;
    }

    if (p == end) {
      return full_read_result::error_high_temp;
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

}  // namespace probe

probe::full_read_result Probe::read() {
  xtd::adc::enable();
  xtd::adc::select_ch(0, xtd::adc::vref::internal_vcc);
  auto resistance = xtd::adc::blocking_read();
  xtd::adc::select_ch(2, xtd::adc::vref::internal_vcc);
  auto temp = xtd::adc::blocking_read();
  xtd::adc::disable();

  auto temp_corr = probe::linearise(temp);
  auto moisture = probe::calc_moist(temp_corr, resistance);
  return probe::full_read_result(moisture, temp_corr, temp, resistance);
}
