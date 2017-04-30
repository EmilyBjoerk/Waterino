#include "xtd/dio.hpp"

namespace avr {
#define PIN(PORTX, PINX) \
  digital_pin<dio_ports::port_##PORTX> { PINX }

  digital_pin<dio_ports::port_B> gpio_port_B[8] = {PIN(B, 0), PIN(B, 1), PIN(B, 2), PIN(B, 3),
                                                   PIN(B, 4), PIN(B, 5), PIN(B, 6), PIN(B, 7)};

  digital_pin<dio_ports::port_D> gpio_port_D[8] = {PIN(D, 0), PIN(D, 1), PIN(D, 2), PIN(D, 3),
                                                   PIN(D, 4), PIN(D, 5), PIN(D, 6), PIN(D, 7)};
}
