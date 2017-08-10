#!/bin/bash

# This script performs bootstrapping of a new Waterino board. This script assumes ATmega 328P MCU.

# Program fuse bits:
# * Default 8MHz internal RC oscillator 65ms startup time (CKSEL=0010 SUT=10)
# * Do not output clock on PORTB0 (CKOUT=0)
# * Divide clock by 8 internally (CKDIV8=0)
# * We use no bootloader (BOOTST=1)
# * Bootloader size is undefined (default BOOTSZ=00)
# * We preserve EEPROM through chip erase EESAVE
# * We will make sure WDT is always on (WDTON=1) (disabled during development)
# * We will allow program download over SPI (SPIEN=0)
# * We do not use debugWIRE (as we have external reset) (DWEN=0)
# * We enable external reset (RSTDISBL=0)

# Program device to 8 MHz internal RC oscillator without clock divider.
#-U lfuse:w:0xe2:m -U hfuse:w:0xd1:m -U efuse:w:0xff:m
avrdude -v -p atmega328p -b 19200 -c avrisp -P /dev/ttyACM0 -O

# Then calibrate the internal RC oscillator


# Then program final fuse bits
#-U lfuse:w:0x62:m -U hfuse:w:0xd1:m -U efuse:w:0xff:m

