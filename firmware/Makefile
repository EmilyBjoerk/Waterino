# Configuration
XTD_UC_PATH=xtd_uc
CFG_UART=-DUART_BAUD=1200 -DUART_DATA_BITS=8 -DUART_PARITY_BITS=2 -DUART_STOP_BITS=1 -DUART_TX_LED_PIN=5 -DUART_TX_LED_PORT=xtd::gpio_port::port_c
CFG_MCU=-DF_CPU=1000000UL
GOOGLE_TEST_LIB = gtest
GOOGLE_TEST_INCLUDE = /usr/local/include

# BASE_* are shared between target device and native compilation
BASE_CXXFLAGS=-Os -std=c++14 -Werror -Wall -Wextra -pedantic
BASE_INCLUDES=-Iinclude -I$(XTD_UC_PATH)/include
BASE_HEADERS=$(wildcard include/*.hpp) $(wildcard $(XTD_UC_PATH)/include/*.hpp) $(wildcard src/*.hpp)

# TARGET_* are used when compiling for the target
TARGET_CXX=avr-g++
TARGET_LDFLAGS=-Wl,-u,vfscanf -lscanf_flt -lm
TARGET_CXXFLAGS=-mmcu=atmega328p -fno-threadsafe-statics -fuse-linker-plugin -fpack-struct -fshort-enums -ffunction-sections
TARGET_CXXFLAGS_FLTO=-flto -fwhole-program

# FLTO is not included here
TARGET_CXXFLAGS_COMBINED=$(BASE_CXXFLAGS) $(TARGET_CXXFLAGS) $(BASE_INCLUDES) $(CFG_UART) $(CFG_MCU)

#SOURCES=src/main.cpp src/gpio.cpp src/chrono.cpp src/bootstrap.cpp src/adc.cpp src/uart.cpp \
#        src/blink.cpp src/sleep.cpp src/delay.cpp src/pump.cpp src/cmdinterpreter.cpp

TARGET_BINARY_SOURCES=$(wildcard src/*.cpp)
TARGET_SELFTEST_SOURCES=$(wildcard selftest/*.cpp) src/gpio.cpp src/uart.cpp src/adc.cpp src/delay.cpp

TARGET_BINARY_OBJECTS=$(TARGET_BINARY_SOURCES:.cpp=.o)
TARGET_BINARY_ASSEMBLY=$(TARGET_BINARY_SOURCES:.cpp=.s)
TARGET_SELFTEST_OBJECTS=$(TARGET_SELFTEST_SOURCES:.cpp=.o)
TARGET_SELFTEST_ASSEMBLY=$(TARGET_SELFTEST_SOURCES:.cpp=.s)

TARGET_BINARY=waterino.bin
TARGET_BINARY_BITSTREAM=$(TARGET_BINARY:.bin=.hex)
TARGET_SELFTEST=selftest.bin
TARGET_SELFTEST_BITSTREAM=$(TARGET_SELFTEST:.bin=.hex)

# NATIVE_* are used for compiling native targets
NATIVE_CXX=clang++
NATIVE_LDFLAGS=-lm -l$(GOOGLE_TEST_LIB)
NATIVE_CXXFLAGS=-pipe -I$(GOOGLE_TEST_INCLUDE)
NATIVE_CXXFLAGS_COMBINED=$(BASE_CXXFLAGS) $(NATIVE_CXXFLAGS) $(BASE_INCLUDES) $(CFG_UART) $(CFG_MCU)

NATIVE_TEST_SOURCES=$(wildcard test/*.cpp)
NATIVE_TEST_OBJECTS=$(NATIVE_TEST_SOURCES:.cpp=.o)
NATIVE_TEST=native_tests

# Rules

all: $(TARGET_BINARY_BITSTREAM) $(TARGET_SELFTEST_BITSTREAM) $(NATIVE_TEST) test

$(TARGET_BINARY): $(TARGET_BINARY_OBJECTS)
	$(TARGET_CXX) $(TARGET_CXXFLAGS_COMBINED) $(TARGET_CXXFLAGS_FLTO) $(TARGET_LDFLAGS) $(TARGET_BINARY_OBJECTS) -o $@

$(TARGET_SELFTEST): $(TARGET_BINARY_OBJECTS)
	$(TARGET_CXX) $(TARGET_CXXFLAGS_COMBINED) $(TARGET_CXXFLAGS_FLTO) $(TARGET_LDFLAGS) $(TARGET_SELFTEST_OBJECTS) -o $@

$(NATIVE_TEST): $(NATIVE_TEST_OBJECTS)
	$(NATIVE_CXX) $(NATIVE_CXXFLAGS_COMBINED) $(NATIVE_LDFLAGS) $(NATIVE_TEST_OBJECTS) -o $@

upload-binary: $(TARGET_BINARY_BITSTREAM)
	avrdude -v -p m328p -b 115200 -c arduino -P /dev/ttyACM0 -U flash:w:$(TARGET_BINARY_BITSTREAM):i

upload-selftest: $(TARGET_SELFTEST_BITSTREAM)
	avrdude -v -p m328p -b 19200 -c avrisp -P /dev/ttyACM0 -U flash:w:$(TARGET_SELFTEST_BITSTREAM):i

asm-binary: $(TARGET_BINARY_ASSEMBLY)

asm-selftest: $(TARGET_SELFTEST_ASSEMBLY)

size-binary: $(TARGET_BINARY)
	avr-nm -C -S --size-sort $(TARGET_BINARY)

size-selftest: $(TARGET_SELFTEST)
	avr-nm -C -S --size-sort $(TARGET_SELFTEST)

src/%.o: %.cpp
	$(TARGET_CXX) $(TARGET_CXXFLAGS_COMBINED) $(TARGET_CXXFLAGS_FLTO) -c $< -o $@

test/%.o: %.cpp
	$(NATIVE_CXX) $(NATIVE_CXXFLAGS_COMBINED) -c $< -o $@

%.s: %.cpp
	$(TARGET_CXX) -S -fverbose-asm $(TARGET_CXXFLAGS_COMBINED) -c $< -o $@

%.hex: %.bin
	avr-objcopy -O ihex -R .eeprom $< $@
	avr-size $@
clean:
	rm -f src/*.s src/*.o selftest/*.s selftest/*.o
	rm -f $(TARGET_BINARY_BITSTREAM) $(TARGET_BINARY)
	rm -f $(TARGET_SELFTEST_BITSTREAM) $(TARGET_SELFTEST)
	rm -f $(NATIVE_TEST)
