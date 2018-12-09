#ifndef GUARD_WATERINO_IERRORREPORTER_HPP
#define GUARD_WATERINO_IERRORREPORTER_HPP

#include "xtd_uc/avr.hpp"
#include "xtd_uc/cstdint.hpp"

#ifdef ENABLE_TEST
#include <ostream>
#else
#include "xtd_uc/uart.hpp"
#include "xtd_uc/ostream.hpp"
#endif

enum class error_type : xtd::fast_size_t { pump_failure, underflow, overflow, short_circuit, fuse_blown };


class IErrorReporter {
public:
  virtual void report(error_type) = 0;
#ifdef ENABLE_TEST
  virtual std::ostream& log() = 0;
#else
  virtual xtd::ostream<xtd::uart_stream_tag>& log() = 0;
#endif
};

#endif
