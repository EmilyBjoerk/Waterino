#ifndef GUARD_XTD_DIO_HPP
#define GUARD_XTD_DIO_HPP

#include <avr/io.h>
#include "sfr.hpp"

namespace avr {
  enum class pin_state : uint8_t { tristate, pullup, output };
  enum class dio_ports : uint8_t { port_B, port_D };

  template <dio_ports PORT>
  class digital_pin {
  public:
      digital_pin(uint8_t pin_nr) {
          pin_set = static_cast<uint8_t>(_BV(pin_nr));
          pin_clr = static_cast<uint8_t>(~_BV(pin_nr));
      }

    // Configure this pin to be either tristate input, pullup input or output.
    void configure(pin_state state, bool set_high = false) {
      /**
       Atmega328 datasheet 14.2.3:
         * Switching between tristate and output high.
           - Must go through either pullup or output low state.
         * Switching between pullup and output low.
           - Must go through either tristate or output high state.
       */

      if (state == pin_state::tristate) {
        if (getddr() && read()) {
          // As we are driving the line strongly high, we will go through pull-up to tristate.
          // This is generally safe because the line is already high.
          setddr(false);
          setport(true);
        }
        setddr(false);
        setport(false);
      } else if (state == pin_state::pullup) {
        if (getddr() && !read()) {
          // We are going to a state where we will be (weakly) pulling up a (possibly floating)
          // wire. We don't want to drive wire (strongly) high during the change so we go
          // through tristate.
          setddr(false);
          setport(false);
        }
        setddr(false);
        setport(true);
      } else {
        if (set_high && !getddr() && !getport()) {
          // We choose to go through pullup as this will be safe as we will be driving the line
          // strongly anyway.
          setddr(false);
          setport(true);
        }
        setddr(true);
        setport(set_high);
      }
    }

    // Sets the pin either HIGH (true) or LOW (false).
    // The port must have been configured as output.
    // Otherwise this may trigger pullup/tristate status.
    void write(bool v) { setport(v); }

    // Reads the pin and returns either HIGH (true) or LOW (false). The pin can always be read
    // regardless of how it was configured and will read either the externally driven value
    // if the pin is configured as tristate or pullup or the written value if the pin is output.
    bool read() {
      if (PORT == dio_ports::port_B) {
        return PINB & pin_set;
      } else {
        return PIND & pin_set;
      }
    }

  private:
    bool getddr() {
      if (PORT == dio_ports::port_B) {
        return DDRB & pin_set;
      } else {
        return DDRD & pin_set;
      }
    }
    bool getport() {
      if (PORT == dio_ports::port_B) {
        return PORTB & pin_set;
      } else {
        return PORTD & pin_set;
      }
    }
    void setddr(bool output) {
      if (PORT == dio_ports::port_B) {
        if (output) {
          DDRB |= pin_set;
        } else {
          DDRB &= pin_clr;
        }
      } else {
        if (output) {
          DDRD |= pin_set;
        } else {
          DDRD &= pin_clr;
        }
      }
    }

    void setport(bool high) {
      if (PORT == dio_ports::port_B) {
        if (high) {
          PORTB |= pin_set;
        } else {
          PORTB &= pin_clr;
        }
      } else {
        if (high) {
          PORTD |= pin_set;
        } else {
          PORTD &= pin_clr;
        }
      }
    }

  private:
    uint8_t pin_set;
    uint8_t pin_clr;
  };

  extern digital_pin<dio_ports::port_B> gpio_port_B[8];
  extern digital_pin<dio_ports::port_D> gpio_port_D[8];
}

#endif
