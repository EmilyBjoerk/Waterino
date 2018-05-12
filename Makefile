CXX=avr-g++
CXXFLAGS=-Os -mmcu=atmega328p -std=c++14 -Werror -Wall -Wextra -pedantic -fno-threadsafe-statics -flto -fuse-linker-plugin -fwhole-program -fpack-struct -fshort-enums -ffunction-sections
# We need the floating point version of scanf
LDFLAGS=-Wl,-u,vfscanf -lscanf_flt -lm
INCLUDES=-Iinclude -isystem/usr/avr/include

CFG_UART=-DUART_BAUD=1200 -DUART_DATA_BITS=8 -DUART_PARITY_BITS=2 -DUART_STOP_BITS=1 -DUART_TX_LED_PIN=5 -DUART_TX_LED_PORT=xtd::gpio_port::port_c
CFG_MCU=-DF_CPU=1000000UL

SOURCES=src/main.cpp src/gpio.cpp src/chrono.cpp src/bootstrap.cpp src/adc.cpp src/uart.cpp \
	src/blink.cpp src/sleep.cpp src/delay.cpp src/pump.cpp src/cmdinterpreter.cpp
OBJECTS=$(SOURCES:.cpp=.o)
ASSEMBLY=$(SOURCES:.cpp=.s)
BINARY=waterino.bin
BITSTREAM=$(BINARY:.bin=.hex)

TEST_SOURCES=selftest/main.cpp src/gpio.cpp src/uart.cpp src/adc.cpp src/delay.cpp
TEST_OBJECTS=$(TEST_SOURCES:.cpp=.o)
TEST_ASSEMBLY=$(TEST_SOURCES:.cpp=.s)
TEST_BINARY=selftest.bin
TEST_BITSTREAM=$(TEST_BINARY:.bin=.hex)


all: $(BITSTREAM) asm

upload: $(BITSTREAM)
	avrdude -v -p m328p -b 115200 -c arduino -P /dev/ttyACM0 -U flash:w:$(BITSTREAM):i

upload-test: $(TEST_BITSTREAM)
	avrdude -v -p m328p -b 19200 -c avrisp -P /dev/ttyACM0 -U flash:w:$(TEST_BITSTREAM):i

asm: $(ASSEMBLY)

asm-test: $(TEST_ASSEMBLY)

sizes: $(BINARY)
	avr-nm -C -S --size-sort $(BINARY)

$(BITSTREAM): $(BINARY)
	avr-objcopy -O ihex -R .eeprom $(BINARY) $(BITSTREAM)
	avr-size $(BINARY)

$(TEST_BITSTREAM): $(TEST_BINARY)
	avr-objcopy -O ihex -R .eeprom $(TEST_BINARY) $(TEST_BITSTREAM)
	avr-size $(TEST_BINARY)

$(BINARY): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) $(LDFLAGS) $(OBJECTS) -o $@

$(TEST_BINARY): $(TEST_OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) $(LDFLAGS) $(TEST_OBJECTS) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) -c $< -o $@

%.s: %.cpp
	$(CXX) -S -fverbose-asm $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) -fno-lto -fno-whole-program -c $< -o $@

clean:
	rm -f src/*.s  src/*.o selftest/*.s selftest/*.o $(BITSTREAM) $(BINARY) $(TEST_BITSTREAM) $(TEST_BINARY)
