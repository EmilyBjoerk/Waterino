CXX=avr-g++
CXXFLAGS=-Os -mmcu=atmega328p --std=c++14 -Werror -Wall -Wextra -pedantic -fno-threadsafe-statics -flto -fuse-linker-plugin -fwhole-program
LDFLAGS=
INCLUDES=-Iinclude

CFG_UART=-DUART_BAUD=9600 -DUART_DATA_BITS=8 -DUART_PARITY_BITS=1 -DUART_STOP_BITS=1
CFG_MCU=-DF_CPU=16000000UL

SOURCES=src/main.cpp src/dio.cpp src/chrono.cpp src/bootstrap.cpp src/adc.cpp src/uart.cpp src/pumpcontroller.cpp src/arduino.cpp src/sleep.cpp src/delay.cpp
OBJECTS=$(SOURCES:.cpp=.o)
ASSEMBLY=$(SOURCES:.cpp=.s)

BINARY=waterino.bin
BITSTREAM=$(BINARY:.bin=.hex)

all: $(BITSTREAM) asm

upload: $(BITSTREAM)
	avrdude -v -p m328p -b 115200 -c arduino -P /dev/ttyACM0 -U flash:w:$(BITSTREAM):i

asm: $(ASSEMBLY)

sizes: $(BINARY)
	avr-nm -C -S --size-sort $(BINARY)

$(BITSTREAM): $(BINARY)
	avr-objcopy -O ihex -R .eeprom $(BINARY) $(BITSTREAM)
	avr-size $(BITSTREAM)

$(BINARY): $(OBJECTS) 
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) $(LDFLAGS) $(OBJECTS) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) -c $< -o $@

%.s: %.cpp
	$(CXX) -S -fverbose-asm $(CXXFLAGS) $(INCLUDES) $(CFG_UART) $(CFG_MCU) -fno-lto -fno-whole-program -c $< -o $@

clean:
	rm -f src/*.s  src/*.o $(BITSTREAM) $(BINARY)
