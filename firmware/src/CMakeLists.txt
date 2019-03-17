cmake_minimum_required(VERSION 2.8)

set(AVRCPP   /usr/bin/avr-g++)
set(AVRSTRIP avr-strip)
set(OBJCOPY  avr-objcopy)
set(OBJDUMP  avr-objdump)
set(AVRSIZE  avr-size)
set(AVRDUDE  avrdude)

set(CXXSTANDARD "-std=c++14")
set(COPT      "-O3")
set(CWARN     "-Werror -Wall -Wextra -pedantic -Wno-attributes")
set(CTUNING   "-fno-threadsafe-statics -fpack-struct -fshort-enums -fno-stack-protector")

set(BASE_AVR_CXXFLAGS "${CXXSTANDARD} ${COPT} ${CWARN} ${CTUNING}")

set(CMAKE_SYSTEM_NAME  Generic)
set(CMAKE_CXX_COMPILER ${AVRCPP})

#
# Tests
#


#
# Probe project
#
project(probe CXX)

set(MCU "atmega328p")
set(CMCU "-mmcu=${MCU} -DF_CPU=16000000UL")
set(CDEFS "-DUART_BAUD=9600 -DUART_DATA_BITS=8 -DUART_PARITY_BITS=0 -DUART_STOP_BITS=1")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${BASE_AVR_CXXFLAGS} ${CMCU} ${CDEFS}")

set(BASE_PATH    "${${PROJECT_NAME}_SOURCE_DIR}/..")
set(INC_PATH     "${BASE_PATH}/include")
set(SRC_PATH     "${BASE_PATH}/src")
set(LIB_DIR_PATH "${BASE_PATH}/lib")
set(XTD_SRC_PATH "${BASE_PATH}/xtd_uc/src")

include_directories(${INC_PATH} "${BASE_PATH}/xtd_uc/include")
file(GLOB SRC_FILES "${SRC_PATH}/*.cpp")
set(XTD_SRC_FILES 
  ${XTD_SRC_PATH}/delay.cpp
  ${XTD_SRC_PATH}/atmega/adc.cpp
  ${XTD_SRC_PATH}/atmega/bootstrap.cpp
  ${XTD_SRC_PATH}/atmega/chrono.cpp
  ${XTD_SRC_PATH}/atmega/gpio.cpp
  ${XTD_SRC_PATH}/atmega/sleep.cpp
  ${XTD_SRC_PATH}/atmega/uart.cpp
  ${XTD_SRC_PATH}/atmega/wdt.cpp
  )
add_executable(${PROJECT_NAME} ${SRC_FILES} ${XTD_SRC_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.elf")

# Compiling targets
add_custom_target(strip ALL     ${AVRSTRIP} "${PROJECT_NAME}.elf" DEPENDS ${PROJECT_NAME})
add_custom_target(hex   ALL     ${OBJCOPY} -R .eeprom -O ihex "${PROJECT_NAME}.elf" "${PROJECT_NAME}.hex" DEPENDS strip)
add_custom_target(eeprom        ${OBJCOPY} -j .eeprom --change-section-lma .eeprom=0 -O ihex "${PROJECT_NAME}.elf" "${PROJECT_NAME}.eeprom" DEPENDS strip)
add_custom_target(disassemble   ${OBJDUMP} -S "${PROJECT_NAME}.elf" > "${PROJECT_NAME}.lst" DEPENDS strip)

# Flashing targets
set(PROG_TYPE_ARDUINO "-v -c arduino -b 115200 -P /dev/ttyUSB0")
set(PROG_TYPE_AVRISP "-v -c avrisp -b 19200 -P /dev/ttyACM0")
set(PROG_TYPE ${PROG_TYPE_ARDUINO})
add_custom_target(flash_program ${AVRDUDE} ${PROG_TYPE} -p ${MCU} -U flash:w:${PROJECT_NAME}.hex DEPENDS hex)
add_custom_target(flash_eeprom ${AVRDUDE} ${PROG_TYPE} -p ${MCU} -U eeprom:w:${PROJECT_NAME}.hex DEPENDS eeprom)

# Clean all outputs
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${PROJECT_NAME}.hex;${PROJECT_NAME}.eeprom;${PROJECT_NAME}.lst")

# Debug stuff
message("* ")
message("* Project Name:\t${PROJECT_NAME}")
message("* Project Source:\t${SRC_PATH}")
message("* Project Include:\t${INC_PATH}")
message("* Library Include:\t${LIB_INC_PATH}")
message("* ")
message("* Project Source Files:\t${SRC_FILES}")
message("* XTD Source Files:\t${XTD_SRC_FILES}")
message("* ")
message("* CXX Flags:\t${CMAKE_CXX_FLAGS}")
message("* ")
