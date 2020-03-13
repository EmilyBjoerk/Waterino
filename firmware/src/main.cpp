/*
This file houses only top level globals and the trivial main loop.

The actual business logic is encapsulated in the Application class in order for it to be testable.
 */
#include "application.hpp"
#include "hardware.hpp"
#include "xtd_uc/eeprom.hpp"

// This could be (and in general best practice should be) in the main body, but that
// makes the whole object part of the stack instead of the .data section meaning that
// it is harder to estimate the total required memory of the application. For this
// reason it's actually better to have globals in this case.
Application app;

int main() {
  while (true) {
    app.execute_loop();
  }
}
