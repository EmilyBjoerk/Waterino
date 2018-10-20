#ifndef GUARD_WATERINO_PROBE_HPP
#define GUARD_WATERINO_PROBE_HPP

#include "pinmap.hpp"
#include "xtd_uc/adc.hpp"
#include "xtd_uc/algorithm.hpp"
#include "xtd_uc/delay.hpp"
#include "xtd_uc/eeprom.hpp"

#include "iprobe.hpp"

using namespace xtd::chrono_literals;

class Probe : public IProbe{
public:
  // Lets consider the pot as an RC system. We know that R is around 10k and lets assume
  // C is less than 1µF, then: RC = 10k*1µ=10m. So 3*RC is enough to rise well above 90%
  // hence, 30ms should be enough under these assumptions. We go safe and pick 200 ms.
  constexpr static auto stabilisation_time = 200_ms;

  Probe(xtd::gpio_pin moist_pos, xtd::gpio_pin moist_neg, uint8_t moist_analog,
        uint16_t* eeprom_moist_thresh_addr, xtd::gpio_pin therm_pos, uint8_t therm_analog)
      : m_moist_pos(moist_pos),
        m_moist_neg(moist_neg),
        m_moist_analog(moist_analog),
        m_moist_thresh(eeprom_moist_thresh_addr),
        m_therm_pos(therm_pos),
        m_therm_analog(therm_analog) {
    xtd::gpio_config(m_moist_pos, xtd::gpio_mode::tristate);
    xtd::gpio_config(m_moist_neg, xtd::gpio_mode::tristate);
    xtd::gpio_config(m_therm_pos, xtd::gpio_mode::tristate);
  }

  virtual bool is_dry() const override { return read() >= (*m_moist_thresh); }

  // Pre-condition: ADC is enabled and setup to use internal AVcc as VRef.
  virtual adc_value_type read() const override {
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

    auto smaller = xtd::min(first_read, second_read);
    auto larger = xtd::max(first_read, second_read);
    auto avg = xtd::avg(smaller, larger);
    xtd::cout << xtd::pstr(PSTR("Probe value: ")) << avg << ' ' << '(' << first_read << ',' << ' '
              << second_read << xtd::pstr(PSTR(")\n"));
    return avg;
  }

  virtual void print_stat() const override {
      read();
  }

private:
  xtd::gpio_pin m_moist_pos;
  xtd::gpio_pin m_moist_neg;
  uint8_t m_moist_analog;
  xtd::eeprom<uint16_t> m_moist_thresh;

  xtd::gpio_pin m_therm_pos;
  uint8_t m_therm_analog;
};

#endif
