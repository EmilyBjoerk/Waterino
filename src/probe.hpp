#ifndef GUARD_WATERINO_PROBE_HPP
#define GUARD_WATERINO_PROBE_HPP

#include "xtd/delay.hpp"
#include "xtd/adc.hpp"

using namespace xtd::chrono_literals;

class Probe {
public:
  constexpr static auto stabilisation_time = 200_ms;  // TODO: Derive a usefull value here.

  Probe(xtd::gpio_pin moist_pos, xtd::gpio_pin moist_neg, uint8_t moist_analog,
        uint16_t moist_thresh, xtd::gpio_pin therm_pos, uint8_t therm_analog)
      : m_moist_pos(moist_pos),
        m_moist_neg(moist_neg),
        m_moist_analog(moist_analog),
        m_moist_thresh(moist_thresh),
        m_therm_pos(therm_pos),
        m_therm_analog(therm_analog) {
    xtd::gpio_config(m_moist_pos, xtd::gpio_mode::tristate);
    xtd::gpio_config(m_moist_neg, xtd::gpio_mode::tristate);
    xtd::gpio_config(m_therm_pos, xtd::gpio_mode::tristate);
  }

  bool is_dry() const { return read() >= m_moist_thresh; }

  // Pre-condition: ADC is enabled and setup to use internal AVcc as VRef.
  uint16_t read() const {
    xtd::adc::select_ch(m_moist_analog, xtd::adc::vref::internal_vcc);

    // Both pins are tristate (HighZ) initially. We set the sink first and then the source.
    xtd::gpio_config(m_moist_neg, xtd::gpio_mode::output, false);
    xtd::gpio_config(m_moist_pos, xtd::gpio_mode::output, true);
    xtd::delay(stabilisation_time);
    auto first_read = xtd::adc::blocking_read();

    // Change the high to low first so we go through both pins low instead of both high.
    xtd::gpio_write(m_moist_pos, false);
    xtd::gpio_write(m_moist_neg, true);
    xtd::delay(stabilisation_time);
    auto second_read = 1023 - xtd::adc::blocking_read();

    // The bottom is high, change it to tristate first.
    xtd::gpio_config(m_moist_neg, xtd::gpio_mode::tristate);
    xtd::gpio_config(m_moist_pos, xtd::gpio_mode::tristate);

    auto avg = (first_read + second_read) / 2;
    xtd::uart << "Probe value: " << avg << " (" << first_read << ", " << second_read << ")\n";
    return avg;
  }

private:
  xtd::gpio_pin m_moist_pos;
  xtd::gpio_pin m_moist_neg;
  uint8_t m_moist_analog;
  uint16_t m_moist_thresh;

  xtd::gpio_pin m_therm_pos;
  uint8_t m_therm_analog;
};

#endif
