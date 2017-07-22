#ifndef GUARD_XTD_OSTREAM_HPP
#define GUARD_XTD_OSTREAM_HPP

#include <avr/pgmspace.h>
#include "limits.hpp"

namespace xtd {

  template <typename stream_tag>
  class ostream;

  struct pstr {
    explicit pstr(const char* s) : str(s){};
    const char* str;
  };

  template <typename stream_tag>
  auto& operator<<(ostream<stream_tag>& os, const char* data) {
    while (*data) {
      os.put(*data++);
    }
    return os;
  }

  template <typename stream_tag>
  auto& operator<<(ostream<stream_tag>& os, pstr data) {
    while (pgm_read_byte(data.str)) {
      os.put(pgm_read_byte(data.str++));
    }
    return os;
  }

  template <typename stream_tag, typename T>
  xtd::enable_if_t<xtd::numeric_limits<T>::is_integer, ostream<stream_tag>&> operator<<(
      ostream<stream_tag>& os, T data) {
    if (data < 0) {
      os.put('-');
      data = -data;
    } else if (data == 0) {
      os.put('0');
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
      os.put(*out);
    }
    return os;
  }
}

#endif
