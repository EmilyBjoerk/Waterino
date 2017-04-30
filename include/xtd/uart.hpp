#ifndef GUARD_XTD_UART_HPP
#define GUARD_XTD_UART_HPP

#include <avr/pgmspace.h>
#include <stdint.h>
#include "chrono_noclock.hpp"

#if F_CPU < 1
#error "F_CPU must be defined to the frequency of the CPU!"
#endif

#if UART_BAUD < 1
#define UART_BAUD 9600
#warning "UART_BAUD was not defined, using 9600 baud."
#endif

#if UART_DATA_BITS < 5
#define UART_DATA_BITS 8
#endif

#ifndef UART_PARITY_BITS
#define UART_PARITY_BITS 1
#endif

#ifndef UART_STOP_BITS
#define UART_STOP_BITS 1
#endif

#ifndef UART_SYNC
#define UART_SYNC false
#endif

#ifndef UART_X2
#define UART_X2 false
#endif

namespace avr {
  namespace uart {
    static_assert(!(UART_SYNC && UART_X2), "X2 cannot be enabled with SYNC");
    static_assert(5 <= UART_DATA_BITS && UART_DATA_BITS <= 8, "Only 5-8 bit data supported!");
    static_assert(1 == UART_STOP_BITS || 2 == UART_STOP_BITS, "Only 1 or 2 stop bits possible!");
    static_assert(0 <= UART_PARITY_BITS && UART_PARITY_BITS <= 2,
                  "Only 0, 1 or 2 parity bits possible!");

    constexpr static uint8_t trx_buffer_len = 31;  // Effective size for the TRX buffers
    using size_type = uint8_t;
    constexpr static uint8_t data_bits = UART_DATA_BITS;
    constexpr static uint8_t parity_bits = UART_PARITY_BITS;
    constexpr static uint8_t stop_bits = UART_STOP_BITS;
    constexpr static uint8_t frame_len = 1 + data_bits + parity_bits + stop_bits;
    constexpr static uint16_t baud_rate = UART_BAUD;
    using symbol_period = xtd::ratio<frame_len, baud_rate>;
    using symbol_duration = typename xtd::chrono::duration<int16_t, symbol_period>;

    void enable();
    void disable();

    void put(const char* data);
    void put(char data);
    void put(unsigned char data);
    void put(int value);
    void put(unsigned int value);
    void put_P(PGM_P data);

    int get();
  }
}
#endif
