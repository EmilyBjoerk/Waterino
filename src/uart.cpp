#include "xtd/uart.hpp"

#include "xtd/delay.hpp"
#include "xtd/queue.hpp"
#include "xtd/utility.hpp"

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/sfr_defs.h>
#include <avr/sleep.h>
#include <util/atomic.h>

enum rx_status_flag : uint8_t {
  good = 0,
  overflow = 1,      // RX buffer overflowed (application didn't read soon enough)
  parity_error = 2,  // Level problem on wire
  frame_error = 4,   // Clock problem on wire
  data_overrun = 8   // ISR was too slow
};

xtd::queue<uint8_t, xtd::usart::trx_buffer_len> tx_queue;
xtd::queue<uint8_t, xtd::usart::trx_buffer_len> rx_queue;
uint8_t rx_status = rx_status_flag::good;

// This interrupt is raised if TXCIE0 is set in UCSR0B and it is raised when the last bit is on
// the wire and UDR0 is empty. It is automatically cleared after the ISR returns.
// This UART implementation is of the "fire and forget" kind so we do not use this ISR.
//
// ISR(USART_TX_vect) {}

ISR(USART_RX_vect) {
  uint8_t status = UCSR0A;
  uint8_t data = UDR0;  // Data must always be read, otherwise IRQ will not be cleared.

  if (status & _BV(FE0)) {
    rx_status |= rx_status_flag::frame_error;
  }
  if (status & _BV(DOR0)) {
    rx_status |= rx_status_flag::data_overrun;
  }
  if (status & _BV(UPE0)) {
    rx_status |= rx_status_flag::parity_error;
  }
  if (rx_queue.full()) {
    rx_status |= rx_status_flag::overflow;
  }

  //  if (rx_status == rx_status_flag::good) {
  rx_queue.push(data);
  //}
}

// This interrupt is raised as long as the user data register is empty.
// If there is no data to send, the interrupt needs to be disabled.
ISR(USART_UDRE_vect) {
  if (!tx_queue.empty()) {
    UDR0 = tx_queue.peek();
    tx_queue.pop();
  } else {
    xtd::clr_bit(UCSR0B, UDRIE0);  // No more data, disable interrupts on empty data register.
  }
}

namespace xtd {

  usart uart;

  void usart::enable() {
    // Writing of the control registers has to happen with interrupts disabled as we are enabling
    // interrupt processing. Further more when we're done we want global interrupts to remain on
    // as this is an interrupt based UART driver.
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      // See table 20-1 in Atmega 328P datasheet
      constexpr uint16_t ubrr = ratio_subtract<
          ratio_divide<ratio<F_CPU, baud_rate>, ratio<(UART_SYNC ? 2 : (UART_X2 ? 8 : 16))>>,
          ratio<1>>::value_round;
      // Enable power to the UART
      clr_bit(PRR, PRUSART0);
      UBRR0H = static_cast<uint8_t>(ubrr >> 8);
      UBRR0L = static_cast<uint8_t>(ubrr);
      UCSR0A = UART_X2 ? _BV(U2X0) : uint8_t();
      UCSR0B = _BV(RXCIE0)                 // IRQ on RX Complete
               | _BV(RXEN0) | _BV(TXEN0);  // Enable RX/TX

      const auto paritybit_mask = parity_bits == 0 ? 0b00 : (parity_bits == 1 ? 0b10 : 0b11);
      const auto stopbit_mask = stop_bits == 1 ? 0b0 : 0b1;
      const auto databit_mask = data_bits - 5;

      UCSR0C = (paritybit_mask << UPM00) | (stopbit_mask << USBS0) | (databit_mask << UCSZ00) |
               ((UART_SYNC ? 1 : 0) << UMSEL00);

      // In UCSR0B:
      // _BV(TXCIE0) (Not used) IRQ on TX Complete (last bit is on the wire)
      // _BV(UDRIE0) (Only set when we have data) IRQ on Data register Empty (feed me more)
    }
  }

  void usart::disable() {
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      UCSR0A = 0;
      UCSR0B = 0;
      UCSR0C = 0;
      PRR |= _BV(PRUSART0);  // Kill power to UART
    }
  }

  void usart::flush() {
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      set_sleep_mode(SLEEP_MODE_IDLE);
      sleep_enable();
      while (!tx_queue.empty()) {
        cli();
        sleep_cpu();
        sei();
      }
      sleep_disable();
    }
  }

  void usart::put(const char* data) {
    while (*data) {
      put(*data++);
    }
  }

  void usart::put_P(PGM_P data) {
    while (pgm_read_byte(data)) {
      put(pgm_read_byte(data++));
    }
  }

  void usart::put(char data) {
    bool full = true;
    while (full) {
      ATOMIC_BLOCK(ATOMIC_FORCEON) { full = tx_queue.full(); }
      if (full) {
        // The buffer is full, sleep the expected time required to empty a quarter of it.
        // We don't want to busy poll as that constant disabling of interrupts would
        // mess with the transmitter.
        delay(symbol_duration(trx_buffer_len / 4));
      }
    }

    ATOMIC_BLOCK(ATOMIC_FORCEON) { tx_queue.push(data); }

    // Enable interrupt processing if it was disabled.
    UCSR0B |= _BV(UDRIE0);
  }

  bool usart::has_char() {
    bool e;
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) { e = rx_queue.empty(); }
    return !e;
  }

  char usart::peek() { return rx_queue.peek(); }

  char usart::get() {
    auto x = peek();
    rx_queue.pop();
    return x;
  }
}
