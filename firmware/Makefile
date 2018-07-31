# Configuration
XTD_UC_PATH=xtd_uc
GOOGLE_TEST_LIB = -lgtest -lgmock
GOOGLE_TEST_INCLUDE = /usr/local/include

INCLUDES=-Iinclude -I$(XTD_UC_PATH)/include
HEADERS=$(wildcard include/*.hpp) $(wildcard $(XTD_UC_PATH)/include/*.hpp) $(wildcard src/*.hpp)
CXXFLAGS=-std=c++14 -Werror -Wall -Wextra -pedantic $(INCLUDES)
CXXFLAGS_AVR=-Os -fno-threadsafe-statics -fuse-linker-plugin -fpack-struct -fshort-enums -ffunction-sections
CXXFLAGS_AVR_FLTO=-flto -fwhole-program
CXX_ATMEGA=avr-g++ $(CXXFLAGS) -mmcu=atmega328p $(CXXFLAGS_AVR)
CXX_ATTINY=avr-g++ $(CXXFLAGS) -mmcu=attiny85 $(CXXFLAGS_AVR)
CXX_HOST=clang++ $(CXXFLAGS) -O0 -g3 -pipe -I$(GOOGLE_TEST_INCLUDE)

#
# Core Unit
#
CORE=core.bin
CORE_BITSTREAM=$(CORE:.bin=.hex)
CORE_CXX=$(CXX_ATMEGA) -DF_CPU=8000000UL -DUART_BAUD=1200 -DUART_DATA_BITS=8 -DUART_PARITY_BITS=2 -DUART_STOP_BITS=1 -DUART_TX_LED_PIN=5 -DUART_TX_LED_PORT=xtd::gpio_port::port_c
CORE_LDFLAGS=-Wl,-u,vfscanf -lscanf_flt -lm
CORE_XTD_SOURCES=adc.cpp chrono.cpp delay.cpp uart.cpp gpio.cpp bootstrap.cpp sleep.cpp wdt.cpp
CORE_SOURCES=$(wildcard src/*.cpp) $(addprefix $(XTD_UC_PATH)/src/, $(CORE_XTD_SOURCES))
CORE_OBJ_DIR=build/core
CORE_OBJECTS=$(addprefix $(CORE_OBJ_DIR)/, $(CORE_SOURCES:.cpp=.o))
CORE_ASSEMBLY=$(CORE_OBJECTS:.o=.s)

$(CORE): $(CORE_OBJECTS)
	$(CORE_CXX) $(CXXFLAGS_AVR_FLTO) $(CORE_LDFLAGS) $(CORE_OBJECTS) -o $@

$(CORE_OBJ_DIR)/%.o: %.cpp $(HEADERS) | build_dir
	$(CORE_CXX) $(CXXFLAGS_AVR_FLTO) -c $< -o $@

$(CORE_OBJ_DIR)/%.s: %.cpp
	$(CORE_CXX) -S -fverbose-asm -c $< -o $@

upload-core: $(CORE_BITSTREAM)
	avrdude -v -p m328p -b 115200 -c arduino -P /dev/ttyACM0 -U flash:w:$(CORE_BITSTREAM):i

asm-core: $(CORE_ASSEMBLY)

size-core: $(CORE)
	avr-nm -C -S --size-sort $(CORE)

#
# Core Selftest Program
#
CORE_SELFTEST=selftest.bin
CORE_SELFTEST_BITSTREAM=$(CORE_SELFTEST:.bin=.hex)
CORE_SELFTEST_SOURCES=$(wildcard selftest/*.cpp) $(addprefix $(XTD_UC_PATH)/src/, $(CORE_XTD_SOURCES))
CORE_SELFTEST_OBJECTS=$(addprefix $(CORE_OBJ_DIR)/, $(CORE_SELFTEST_SOURCES:.cpp=.o))
CORE_SELFTEST_ASSEMBLY=$(CORE_SELFTEST_OBJECTS:.o=.s)

$(CORE_SELFTEST): $(CORE_SELFTEST_OBJECTS)
	$(CORE_CXX) $(CXXFLAGS_AVR_FLTO) $(CORE_LDFLAGS) $(CORE_SELFTEST_OBJECTS) -o $@

upload-selftest: $(CORE_SELFTEST_BITSTREAM)
	avrdude -v -p m328p -b 115200 -c arduino -P /dev/ttyACM0 -U flash:w:$(CORE_SELFTEST_BITSTREAM):i

asm-selftest: $(CORE_SELFTEST_ASSEMBLY)

size-selftest: $(CORE_SELFTEST)
	avr-nm -C -S --size-sort $(CORE_SELFTEST)

#
# Probe Unit
#
PROBE=probe.bin
PROBE_BITSTREAM=$(PROBE:.bin=.hex)
PROBE_CXX=$(CXX_ATTINY) -DF_CPU=100000UL
PROBE_LDFLAGS=
PROBE_XTD_SOURCES=adc.cpp delay.cpp attiny/i2c.cpp
PROBE_SOURCES=$(wildcard src_probe/*.cpp) $(addprefix $(XTD_UC_PATH)/src/, $(PROBE_XTD_SOURCES))
PROBE_OBJ_DIR=build/probe
PROBE_OBJECTS=$(addprefix $(PROBE_OBJ_DIR)/, $(PROBE_SOURCES:.cpp=.o))
PROBE_ASSEMBLY=$(PROBE_OBJECTS:.o=.s)

$(PROBE): $(PROBE_OBJECTS)
	$(PROBE_CXX) $(CXXFLAGS_AVR_FLTO) $(PROBE_LDFLAGS) $(PROBE_OBJECTS) -o $@

$(PROBE_OBJ_DIR)/%.o: %.cpp $(HEADERS) | build_dir
	$(PROBE_CXX) $(CXXFLAGS_AVR_FLTO) -c $< -o $@

$(PROBE_OBJ_DIR)/%.s: %.cpp
	$(PROBE_CXX) -S -fverbose-asm -c $< -o $@

upload-probe: $(PROBE_BITSTREAM)
	avrdude -v -p t85 -b 19200 -c avrisp -P /dev/ttyACM0 -U flash:w:$(PROBE_BITSTREAM):i

asm-probe: $(PROBE_ASSEMBLY)

size-probe: $(PROBE)
	avr-nm -C -S --size-sort $(PROBE)

#
# Host side unit tests
#
HOST_TEST=unit_tests
HOST_TEST_CXX=$(CXX_HOST) -DF_CPU=1000000 -D__AVR__=1 -D__AVR_MEGA__ -DENABLE_TEST -ftrapv -fsanitize=undefined -fprofile-instr-generate -fcoverage-mapping
HOST_TEST_LDFLAGS=-lm $(GOOGLE_TEST_LIB)
HOST_TEST_SOURCES=$(wildcard test/*.cpp) src/controller.cpp
HOST_TEST_OBJ_DIR=build/host
HOST_TEST_OBJECTS=$(addprefix $(HOST_TEST_OBJ_DIR)/, $(HOST_TEST_SOURCES:.cpp=.o))

$(HOST_TEST): $(HOST_TEST_OBJECTS)
	$(HOST_TEST_CXX) $(HOST_TEST_LDFLAGS) $(HOST_TEST_OBJECTS) -o $@

$(HOST_TEST_OBJ_DIR)/%.o: %.cpp $(HEADERS) | build_dir
	$(HOST_TEST_CXX) -c $< -o $@

test: $(HOST_TEST)
	./$(HOST_TEST)

# Rules

.PHONY:all clean asm-core asm-selftest size-core size-selftest upload-core upload-selftest build_dir

all: $(CORE_BITSTREAM) $(CORE_SELFTEST_BITSTREAM) $(HOST_TEST) test

build_dir:
	@mkdir -p $(PROBE_OBJ_DIR)/{src_probe,xtd_uc/src/attiny}
	@mkdir -p $(CORE_OBJ_DIR)/{src,selftest,xtd_uc/src}
	@mkdir -p $(HOST_TEST_OBJ_DIR)/{test,src}

%.hex: %.bin
	avr-objcopy -O ihex -R .eeprom $< $@
	avr-size $@
clean:
	rm -f src/*.s src/*.o $(CORE_BITSTREAM) $(CORE)
	rm -f src_probe/*.s src_probe/*.o $(PROBE_BITSTREAM) $(PROBE)
	rm -f selftest/*.s selftest/*.o $(CORE_SELFTEST_BITSTREAM) $(CORE_SELFTEST)
	rm -f test/*.s test/*.o $(HOST_TEST)
	rm -rf build/
