#ifndef GUARD_WATERINO_HARDWARE_HPP
#define GUARD_WATERINO_HARDWARE_HPP

#include "config.hpp"

using callback_void_t = void (*)(void);

// Sets up default state for the hardware, must be called prior to calling any other functions here.
void hardware_initialize();

// Light the PUMP_LED
void pump_led_on();

// Turn off the PUMP_LED
void pump_led_off();

// Activates the pump until stopped, synchronization between shared pump users
// must be done else where.
void pump_activate();

// Stop the pump
void pump_stop();

// Senses the capacitance over the probes co-planar capacitor
// Returns our best estimate of the true capacitance.
cycles sense_rc_delay();

// Senses the temperature at the tip of the co-planar capacitor
// Returns a raw reading from the ADC, it may be filtered for noise
adc_voltage sense_ntc_drop();

// Senses the voltage drop across the overflow electrodes.
// A drop of Aref V indicates disconnection and a drop of 0 V indicates a shortcircuit.
// Typically we expect around 3/4*Aref during a short circuit
adc_voltage sense_overflow();

// Connects the overflow sensor to analog comparator IRQ.
// When the overflow sensor detects water, the ANALOG_COMP_vect ISR will run.
// May not be active when sense_rc_delay() is called.
void sense_overflow_enable_irq(callback_void_t cb);

// Disable the overflow sensor ISR
void sense_overflow_disable_irq();

#endif
