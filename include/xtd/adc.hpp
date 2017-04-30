#ifndef GUARD_XTD_ADC_HPP
#define GUARD_XTD_ADC_HPP

#include <avr/io.h>
#include <stdint.h>
#include "chrono_noclock.hpp"
#include "ratio.hpp"
#include "sfr.hpp"

#ifndef ADC_PRESCALER
#define ADC_PRESCALER 7
#endif

namespace avr {
  namespace adc {
    enum class vref : uint8_t { external_aref = 0b00, internal_vcc = 0b01, internal_1_1v = 0b11 };

    constexpr static int prescaler_select = ADC_PRESCALER;
    constexpr static int conv_delay_normal = 13;
    constexpr static int conv_delay_first = 25;

    using period = xtd::ratio<(1 << prescaler_select), F_CPU>;
    using duration = xtd::chrono::duration<int8_t, period>;

    void select_ch(uint8_t ch, vref vref, bool leftadjust = false);

    inline void enable() {
      clr_bit(PRR, PRADC);                  // Give ADC power in Power Reduction Register
      set_bit(ADCSRA, ADEN);                // Enable ADC
      ADCSRA |= prescaler_select << ADPS0;  // Prescale by 128 giving 125KHz ADC clock
    }

    inline bool isenabled() { return ADCSRA &= _BV(ADEN); }

    inline void disable() {
      set_bit(PRR, PRADC);    // Take ADC power in Power Reduction Register
      clr_bit(ADCSRA, ADEN);  // Disable ADC
    }

    inline void disable_digital() {
      // Disable digital inputs from analog pins to save power.
      DIDR0 = 0b111111 << ADC0D;
    }

    uint16_t blocking_read();
  }
}

#endif
