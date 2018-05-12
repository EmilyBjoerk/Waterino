#ifndef WATERINO_XTD_SERIAL_HPP
#define WATERINO_XTD_SERIAL_HPP

#include "limits.hpp"
#include "type_traits.hpp"

namespace xtd {

  enum rx_status : uint8_t {
    good = 0,
    overflow = 1,      // RX buffer overflowed (application didn't read soon enough)
    parity_error = 2,  // Level problem on wire
    frame_error = 4,   // Clock problem on wire
    data_overrun = 8   // ISR was too slow
  };

  void usart_enable();
  void usart_disable();

  usart_status usart_get_status();
  bool usart_put(uint8_t data);

  template <typename IS>
  class ostream {
  public:
    friend ostream& operator<<(ostream<IS>& os, char x) {
      IS::put(x);
      return os;
    }

    friend ostream& operator<<(ostream<IS>& os, const char* data) {
      auto c = pgm_read_byte(data);
      while (c) {
        put(c);
        data++;
      }
      return os;
    }

    template <typename T, typename = xtd::enable_if_t<numeric_limits<T>::is_integer>>
    friend ostream& operator<<(ostream<IS>& os, T x) {
      if (data == 0) {
        return os << '0';
      }

      if (data < 0) {
        return os << '-' << (-x);
      }

      char out_rev[21];
      char* out = out_rev;
      constexpr T base = 10;
      while (data) {
        auto quotient = data / base;
        auto remainder = data % base;
        *out = static_cast<char>('0' + remainder);
        ++out;
        data = quotient;
      }
      while (out != out_rev) {
        --out;
        os << *out;
      }
      return os;
    }
  };
}

#endif
