EESchema Schematic File Version 2
LIBS:waterino-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:mic94090
LIBS:max6817
LIBS:relays
LIBS:waterino-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Waternio"
Date "2017-07-08"
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R6
U 1 1 59272E25
P 6600 3950
F 0 "R6" V 6700 3950 50  0000 C CNN
F 1 "10K" V 6600 3950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6530 3950 50  0001 C CNN
F 3 "" H 6600 3950 50  0000 C CNN
	1    6600 3950
	0    -1   -1   0   
$EndComp
Text GLabel 6750 3950 1    39   Input ~ 0
MOISTURE
$Comp
L R R5
U 1 1 59273B85
P 6500 4350
F 0 "R5" V 6580 4350 50  0000 C CNN
F 1 "100K" V 6500 4350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4350 50  0001 C CNN
F 3 "" H 6500 4350 50  0000 C CNN
	1    6500 4350
	0    1    1    0   
$EndComp
$Comp
L MIC94090 U2
U 1 1 59275684
P 2400 1150
F 0 "U2" H 2850 1750 47  0000 C CNN
F 1 "MIC94090" H 2850 1250 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 2300 1150 47  0001 C CNN
F 3 "" H 2300 1150 47  0001 C CNN
	1    2400 1150
	-1   0    0    1   
$EndComp
NoConn ~ 2400 1400
Text GLabel 1550 1600 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON1
U 1 1 59277B44
P 2650 2850
F 0 "CON1" H 2650 3100 50  0000 C CNN
F 1 "POWER" H 2650 2650 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 2650 2850 50  0001 C CNN
F 3 "" H 2650 2850 50  0000 C CNN
	1    2650 2850
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 592799BC
P 6150 2950
F 0 "C4" H 6175 3050 50  0000 L CNN
F 1 "100nF" V 5950 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6188 2800 50  0001 C CNN
F 3 "" H 6150 2950 50  0000 C CNN
	1    6150 2950
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-waterino D8
U 1 1 5927A727
P 4750 3000
F 0 "D8" H 4750 3150 50  0000 C CNN
F 1 "PWR_LED" H 4750 2900 50  0000 C CNN
F 2 "LEDs:LED_0603" H 4750 3000 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 4750 3000 50  0001 C CNN
	1    4750 3000
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5927C419
P 5150 6050
F 0 "R1" V 5230 6050 50  0000 C CNN
F 1 "1K5" V 5150 6050 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5080 6050 50  0001 C CNN
F 3 "" H 5150 6050 50  0000 C CNN
	1    5150 6050
	0    -1   -1   0   
$EndComp
$Comp
L LED-RESCUE-waterino D4
U 1 1 5927C47E
P 5500 6050
F 0 "D4" H 5500 6150 50  0000 C CNN
F 1 "PUMP_LED" H 5800 6150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5500 6050 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5500 6050 50  0001 C CNN
	1    5500 6050
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 59281429
P 7800 5450
F 0 "SW1" H 7950 5560 50  0000 C CNN
F 1 "RESET" H 7800 5370 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 7800 5450 50  0001 C CNN
F 3 "" H 7800 5450 50  0000 C CNN
	1    7800 5450
	-1   0    0    -1  
$EndComp
Text GLabel 4900 6050 1    39   Input ~ 0
PUMP
$Comp
L GND #PWR9
U 1 1 592B0B84
P 6750 6050
F 0 "#PWR9" H 6750 5800 50  0001 C CNN
F 1 "GND" H 6750 5900 50  0000 C CNN
F 2 "" H 6750 6050 50  0000 C CNN
F 3 "" H 6750 6050 50  0000 C CNN
	1    6750 6050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR1
U 1 1 59277F1D
P 1100 1750
F 0 "#PWR1" H 1100 1500 50  0001 C CNN
F 1 "GND" H 1100 1600 50  0000 C CNN
F 2 "" H 1100 1750 50  0000 C CNN
F 3 "" H 1100 1750 50  0000 C CNN
	1    1100 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P3
U 1 1 5928A55A
P 5900 5750
F 0 "P3" H 5900 6000 50  0000 C CNN
F 1 "UART" V 6000 5750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5900 5750 50  0001 C CNN
F 3 "" H 5900 5750 50  0000 C CNN
	1    5900 5750
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5928C863
P 5700 5250
F 0 "R8" V 5780 5250 50  0000 C CNN
F 1 "1K5" V 5700 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 5250 50  0001 C CNN
F 3 "" H 5700 5250 50  0000 C CNN
	1    5700 5250
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-waterino D7
U 1 1 5928C9A7
P 5350 5250
F 0 "D7" H 5350 5350 50  0000 C CNN
F 1 "TX_LED" H 5350 5150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 5250 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 5250 50  0001 C CNN
	1    5350 5250
	1    0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D6
U 1 1 5928CC0E
P 5350 4950
F 0 "D6" H 5350 5050 50  0000 C CNN
F 1 "RX_LED" H 5350 4850 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 4950 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 4950 50  0001 C CNN
	1    5350 4950
	1    0    0    1   
$EndComp
$Comp
L R R7
U 1 1 5928CCC0
P 5700 4950
F 0 "R7" V 5780 4950 50  0000 C CNN
F 1 "1K5" V 5700 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 4950 50  0001 C CNN
F 3 "" H 5700 4950 50  0000 C CNN
	1    5700 4950
	0    1    1    0   
$EndComp
$Comp
L CONN_02X02 P1
U 1 1 5929A575
P 4450 1800
F 0 "P1" H 4450 1950 50  0000 C CNN
F 1 "PUMP" H 4450 1650 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 4450 600 50  0001 C CNN
F 3 "" H 4450 600 50  0000 C CNN
	1    4450 1800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR5
U 1 1 592A0DF0
P 2700 1500
F 0 "#PWR5" H 2700 1250 50  0001 C CNN
F 1 "GND" H 2700 1350 50  0000 C CNN
F 2 "" H 2700 1500 50  0000 C CNN
F 3 "" H 2700 1500 50  0000 C CNN
	1    2700 1500
	1    0    0    1   
$EndComp
Text GLabel 4250 5800 2    39   Input ~ 0
~OVRFLW
Text GLabel 6150 2750 2    47   Input ~ 0
Vcc
Text GLabel 5700 5600 0    47   Input ~ 0
Vcc
Text GLabel 1100 1400 1    47   Input ~ 0
Vcc
Text Notes 5000 4800 0    39   ~ 0
Yellow LED (2.2V, 20mA, 100mcd): \n(5V - 2.2V) / (20mA*8mcd/100mcd) = 1750 Ohm.\nPick 1k5 Ohm (E12)
Text Notes 4250 3550 0    39   ~ 0
Green LED (2.2V, 20mA, 6mcd): \nWe want 8mcd brightness: \n(12V -0.7V - 2.2V) / 20mA = 455 Ohm.  \nPick 1.5K Ohm (E12, BOM reuse).
Text Notes 7700 4650 0    39   ~ 0
MOIST+ and MOIST- are normally tristate.\nWhen measuring + is driven high and - is driven low causing a current to flow through\nR6 and the soil (two electrodes connected between pin 2 and 3 of P2). Then the polarity\nis reversed to counteract electron migration on the electrodes.\nThe voltage at the divider is measured using ADC. \nR6 is chosen based on earlier experiments for the designed target soil. \n\nBetween pins 5 and 6 of P2 are two electrodes that short if the pot overflows with water.\nR5 forms a series resistance with the electrodes and is weakly pulled high.  The value for\nR5 is chosen based on measured resistance of tap water with large electrodes.\nThe resistance measured was around 2k for 3cm galvanized screws submerged\nin water. The expected voltage on INT0 when in water is 0.02*Vcc. Internal pull-up\nmust be disabled. An IRQ will trigger up to 72k resistance between the probes. \n(ATmega has 2.6V input threshold on pins and .5V hysteresis)\n\n\nR12 likewise forms a voltage divider but with a thermistor, the datasheet suggest a \n5k11 series resistor to linearise the thermistor. We use THERM+ to drive the divider\nwhen we want to measure. Otherwise THERM+ is tristate. 5V/5K = 1mA which the GPIO\npin can easily drive.
Text Notes 4750 6400 0    39   ~ 0
Red LED (2.2V , 20mA, 40mcd): We want 8mcd brightness:\n(5V - 2.2V) / (20mA * 8mcd/40mcd) = 700 Ohm.\nPick 1K5 Ohm (E12) for bom reuse.
$Comp
L D D1
U 1 1 59321D7A
P 3700 2750
F 0 "D1" H 3700 2850 50  0000 C CNN
F 1 "D" H 3700 2650 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 3700 2750 50  0001 C CNN
F 3 "" H 3700 2750 50  0000 C CNN
	1    3700 2750
	-1   0    0    1   
$EndComp
$Comp
L CP C2
U 1 1 59323AB3
P 3900 2950
F 0 "C2" H 3925 3050 50  0000 L CNN
F 1 "100µF" H 3650 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3938 2800 50  0001 C CNN
F 3 "" H 3900 2950 50  0000 C CNN
	1    3900 2950
	1    0    0    -1  
$EndComp
$Comp
L CP C1
U 1 1 5932A26F
P 3500 2950
F 0 "C1" H 3525 3050 50  0000 L CNN
F 1 "100µF" H 3250 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3538 2800 50  0001 C CNN
F 3 "" H 3500 2950 50  0000 C CNN
	1    3500 2950
	1    0    0    -1  
$EndComp
Text Label 3700 1400 0    47   ~ 0
PUMP+
Text GLabel 6650 4350 3    39   Input ~ 0
~OVRFLW
$Comp
L PWR_FLAG #FLG1
U 1 1 59302DDD
P 1950 4300
F 0 "#FLG1" H 1950 4395 50  0001 C CNN
F 1 "PWR_FLAG" H 1950 4480 50  0000 C CNN
F 2 "" H 1950 4300 50  0000 C CNN
F 3 "" H 1950 4300 50  0000 C CNN
	1    1950 4300
	-1   0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 5930E0B4
P 3700 3200
F 0 "R9" V 3780 3200 50  0000 C CNN
F 1 "0" V 3700 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_2010" V 3630 3200 50  0001 C CNN
F 3 "" H 3700 3200 50  0000 C CNN
	1    3700 3200
	0    1    1    0   
$EndComp
Text Label 2900 2100 2    60   ~ 0
COIL_PWR
Text Notes 1200 3950 0    39   ~ 0
AVcc LC circuit taken from AVR datasheet.
$Comp
L R R11
U 1 1 593391B6
P 5100 3000
F 0 "R11" V 5200 3000 50  0000 C CNN
F 1 "1K5" V 5100 3000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5030 3000 50  0001 C CNN
F 3 "" H 5100 3000 50  0000 C CNN
	1    5100 3000
	0    1    -1   0   
$EndComp
$Comp
L C C3
U 1 1 59347036
P 4200 2950
F 0 "C3" H 4225 3050 50  0000 L CNN
F 1 "100nF" H 4225 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4238 2800 50  0001 C CNN
F 3 "" H 4200 2950 50  0000 C CNN
	1    4200 2950
	1    0    0    -1  
$EndComp
$Comp
L FINDER-32.21-x300 RL1
U 1 1 5934B795
P 3300 1800
F 0 "RL1" H 3550 1800 50  0000 L CNN
F 1 "FINDER-32.21-x300" V 3350 1450 50  0000 L CNN
F 2 "Relays_THT:Relay_SPST_Finder_32.21-x300" H 3300 1800 50  0001 C CNN
F 3 "" H 3300 1800 50  0000 C CNN
	1    3300 1800
	1    0    0    -1  
$EndComp
Text Notes 2450 2250 0    60   ~ 0
40mA @ 5V
Text Notes 8000 2700 0    39   ~ 0
5V Load Summary:\n - MCU: 1MHz@5V (internal RC)  < 1mA active \n - Moisture probe: 5V/10KR = 500µA (when shorted)\n - Overflow sensor: 5V/100KR = 50µA (when shorted)\n - Level alert:  50µA when active (pullup from ground)\n - Thermal probe 1mA (when shorted)\n - Pump relay 40mA (nominal)\n - MIC94090 20µA\n - Pump LED max 2mA.\n - RX/TX should be low but max 40mA total\n - RX/TX LED max 40mA total. \n\nTotal MAX: < 140 mA (without extension ports)\n - Typical Sleep: <  100µA\n - Typical Active: < 70 mA\n - Typical Duty Cycle: 0.13% \n\nThermal dissipation LM7805:\n - Max: (12- 0.6 - 5) *0.140 = 896mW\n - Typical Sleep: (12- 0.6 - 5) *0.0001 = 0.64mW\n - Typical Active: (12- 0.6 - 5) *0.070 = 448mW \n - Average expected: 0.0013*448  + 0.9987 *0.64 = 1.2 mW \n - TO220 package safe dissipation without heat sink 1W.\n
Text GLabel 1650 2600 3    39   Input ~ 0
MISO
Text GLabel 1750 2600 3    39   Input ~ 0
SCK
Text GLabel 1850 2600 3    39   Input ~ 0
~RESET
Text GLabel 1750 2100 1    39   Input ~ 0
MOSI
$Comp
L GND #PWR3
U 1 1 5934D270
P 1850 2100
F 0 "#PWR3" H 1850 1850 50  0001 C CNN
F 1 "GND" H 1850 1950 50  0000 C CNN
F 2 "" H 1850 2100 50  0000 C CNN
F 3 "" H 1850 2100 50  0000 C CNN
	1    1850 2100
	0    -1   -1   0   
$EndComp
Text GLabel 4250 4400 2    39   Input ~ 0
MISO
Text GLabel 4250 4500 2    39   Input ~ 0
SCK
Text GLabel 4250 4300 2    39   Input ~ 0
MOSI
$Comp
L INDUCTOR_SMALL L1
U 1 1 5935DA81
P 1600 4300
F 0 "L1" H 1600 4400 50  0000 C CNN
F 1 "10µH" H 1600 4250 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 1600 4300 50  0001 C CNN
F 3 "" H 1600 4300 50  0000 C CNN
	1    1600 4300
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 5935DB3D
P 1950 4550
F 0 "C11" H 1975 4650 50  0000 L CNN
F 1 "100nF" V 2100 4300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1988 4400 50  0001 C CNN
F 3 "" H 1950 4550 50  0000 C CNN
	1    1950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR8
U 1 1 5935EACE
P 5650 3200
F 0 "#PWR8" H 5650 2950 50  0001 C CNN
F 1 "GND" H 5650 3050 50  0000 C CNN
F 2 "" H 5650 3200 50  0000 C CNN
F 3 "" H 5650 3200 50  0000 C CNN
	1    5650 3200
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 59369493
P 6750 5200
F 0 "R2" V 6830 5200 50  0000 C CNN
F 1 "4K7" V 6750 5200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6680 5200 50  0001 C CNN
F 3 "" H 6750 5200 50  0000 C CNN
	1    6750 5200
	1    0    0    1   
$EndComp
$Comp
L C C6
U 1 1 59369607
P 6750 5700
F 0 "C6" H 6775 5800 50  0000 L CNN
F 1 "100nF" H 6775 5600 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6788 5550 50  0001 C CNN
F 3 "" H 6750 5700 50  0000 C CNN
	1    6750 5700
	-1   0    0    -1  
$EndComp
Text GLabel 6300 5450 1    39   Input ~ 0
~RESET
Text GLabel 4250 5150 2    39   Input ~ 0
~LEVEL_ALERT
$Comp
L D_Schottky D5
U 1 1 5936D8F4
P 6500 5200
F 0 "D5" H 6500 5300 50  0000 C CNN
F 1 "D_Schottky" H 6500 5100 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 6500 5200 50  0001 C CNN
F 3 "" H 6500 5200 50  0001 C CNN
	1    6500 5200
	0    -1   1    0   
$EndComp
Text GLabel 6750 4950 1    47   Input ~ 0
Vcc
$Comp
L R R4
U 1 1 5936EA26
P 7000 5450
F 0 "R4" V 7080 5450 50  0000 C CNN
F 1 "150" V 7000 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6930 5450 50  0001 C CNN
F 3 "" H 7000 5450 50  0000 C CNN
	1    7000 5450
	0    1    -1   0   
$EndComp
$Comp
L D_Schottky D3
U 1 1 5936FBB6
P 2700 1800
F 0 "D3" H 2700 1900 50  0000 C CNN
F 1 "D_Schottky" H 2700 1700 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 2700 1800 50  0001 C CNN
F 3 "" H 2700 1800 50  0001 C CNN
	1    2700 1800
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 593710E5
P 7350 5450
F 0 "R3" V 7430 5450 50  0000 C CNN
F 1 "150" V 7350 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7280 5450 50  0001 C CNN
F 3 "" H 7350 5450 50  0000 C CNN
	1    7350 5450
	0    1    -1   0   
$EndComp
Text GLabel 5050 1100 2    39   Input ~ 0
~LEVEL_ALERT
Text Notes 4950 1150 2    39   ~ 0
Level alert is debounced\nin software.
Text Notes 7850 5200 2    39   ~ 0
Recommended reset circuit\nfrom AVR HW considerations.
$Comp
L C C5
U 1 1 59377CB1
P 1100 1550
F 0 "C5" H 1125 1650 50  0000 L CNN
F 1 "100nF" V 950 1450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1138 1400 50  0001 C CNN
F 3 "" H 1100 1550 50  0000 C CNN
	1    1100 1550
	1    0    0    -1  
$EndComp
$Comp
L ATMEGA168-20AU U3
U 1 1 59379191
P 3250 5100
F 0 "U3" H 2500 6350 50  0000 L BNN
F 1 "ATMEGA168-20AU" H 3700 3700 50  0000 L BNN
F 2 "Housings_QFP:TQFP-32_7x7mm_Pitch0.8mm" H 3250 5100 50  0001 C CIN
F 3 "" H 3250 5100 50  0001 C CNN
	1    3250 5100
	1    0    0    -1  
$EndComp
Text GLabel 2350 4300 3    47   Input ~ 0
AVcc
$Comp
L C C9
U 1 1 5937AF02
P 1500 5150
F 0 "C9" H 1525 5250 50  0000 L CNN
F 1 "100nF" V 1350 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1538 5000 50  0001 C CNN
F 3 "" H 1500 5150 50  0000 C CNN
	1    1500 5150
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5937B7FA
P 1150 5150
F 0 "C7" H 1175 5250 50  0000 L CNN
F 1 "100nF" V 1000 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1188 5000 50  0001 C CNN
F 3 "" H 1150 5150 50  0000 C CNN
	1    1150 5150
	1    0    0    -1  
$EndComp
Text GLabel 1050 4000 0    47   Input ~ 0
Vcc
Text GLabel 4250 4950 2    39   Input ~ 0
MOIST+
Text GLabel 4250 4850 2    39   Input ~ 0
MOIST-
Text GLabel 2350 5350 0    39   Input ~ 0
MOISTURE
Text GLabel 6450 3950 1    39   Input ~ 0
MOIST+
Text GLabel 7200 4050 0    39   Input ~ 0
MOIST-
Text GLabel 6650 4250 1    39   Input ~ 0
THERM
Text GLabel 4250 4000 2    39   Input ~ 0
EXT_D0
Text GLabel 4250 4100 2    39   Input ~ 0
EXT_D1
Text GLabel 1550 2600 3    39   Input ~ 0
EXT_D7
$Comp
L C C12
U 1 1 5939665B
P 2300 4800
F 0 "C12" H 2325 4900 50  0000 L CNN
F 1 "10nF" V 2400 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2338 4650 50  0001 C CNN
F 3 "" H 2300 4800 50  0000 C CNN
	1    2300 4800
	1    0    0    -1  
$EndComp
Text GLabel 1350 2100 1    39   Input ~ 0
EXT_D0
Text GLabel 1450 2100 1    39   Input ~ 0
EXT_D1
Text GLabel 4250 4200 2    39   Input ~ 0
EXT_D2
Text GLabel 1650 2100 1    47   Input ~ 0
Vcc
$Comp
L D_Schottky_AKA D2
U 1 1 593C27E0
P 4000 1750
F 0 "D2" H 4000 1850 50  0000 C CNN
F 1 "D_Schottky_AKA" H 4000 1650 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 4000 1750 50  0001 C CNN
F 3 "" H 4000 1750 50  0001 C CNN
	1    4000 1750
	0    1    1    0   
$EndComp
$Comp
L R R12
U 1 1 593B812B
P 6500 4250
F 0 "R12" V 6400 4250 50  0000 C CNN
F 1 "5K11" V 6500 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4250 50  0001 C CNN
F 3 "" H 6500 4250 50  0000 C CNN
	1    6500 4250
	0    1    1    0   
$EndComp
Text GLabel 6350 4250 0    39   Input ~ 0
THERM+
$Comp
L CONN_01X06 P2
U 1 1 593BAF43
P 7400 4200
F 0 "P2" H 7400 4550 50  0000 C CNN
F 1 "PLANT" V 7500 4200 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S6B-PH-K_06x2.00mm_Angled" H 7400 4200 50  0001 C CNN
F 3 "" H 7400 4200 50  0000 C CNN
	1    7400 4200
	1    0    0    -1  
$EndComp
Text GLabel 2350 5450 0    39   Input ~ 0
THERM
Text GLabel 4250 5050 2    39   Input ~ 0
THERM+
Text GLabel 1450 2600 3    39   Input ~ 0
EXT_D6
Text GLabel 6350 4350 0    47   Input ~ 0
AVcc
$Comp
L GND #PWR2
U 1 1 593C6E3D
P 1500 6300
F 0 "#PWR2" H 1500 6050 50  0001 C CNN
F 1 "GND" H 1500 6150 50  0000 C CNN
F 2 "" H 1500 6300 50  0000 C CNN
F 3 "" H 1500 6300 50  0000 C CNN
	1    1500 6300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR11
U 1 1 593C72D3
P 7200 4450
F 0 "#PWR11" H 7200 4200 50  0001 C CNN
F 1 "GND" H 7200 4300 50  0000 C CNN
F 2 "" H 7200 4450 50  0000 C CNN
F 3 "" H 7200 4450 50  0000 C CNN
	1    7200 4450
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG2
U 1 1 593C7C84
P 2300 6750
F 0 "#FLG2" H 2300 6845 50  0001 C CNN
F 1 "PWR_FLAG" H 2300 6930 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 593C7D0A
P 2300 6750
F 0 "#PWR4" H 2300 6500 50  0001 C CNN
F 1 "GND" H 2300 6600 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
Text GLabel 1550 2100 1    39   Input ~ 0
EXT_D2
Text GLabel 4250 4600 2    39   Input ~ 0
EXT_D6
Text GLabel 4250 4700 2    39   Input ~ 0
EXT_D7
$Comp
L GND #PWR10
U 1 1 593BAE88
P 7200 3950
F 0 "#PWR10" H 7200 3700 50  0001 C CNN
F 1 "GND" V 7200 3750 50  0000 C CNN
F 2 "" H 7200 3950 50  0000 C CNN
F 3 "" H 7200 3950 50  0000 C CNN
	1    7200 3950
	0    1    -1   0   
$EndComp
$Comp
L FUSE F1
U 1 1 594010CA
P 3200 2750
F 0 "F1" H 3300 2800 50  0000 C CNN
F 1 "FUSE" H 3100 2700 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_SMD2920" H 3200 2750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2038617.pdf" H 3200 2750 50  0001 C CNN
	1    3200 2750
	1    0    0    -1  
$EndComp
Text Label 4400 5350 0    39   ~ 0
TX_LED
Text Label 4400 5250 0    39   ~ 0
RX_LED
Text Label 4400 5600 0    39   ~ 0
RX
Text Label 4400 5700 0    39   ~ 0
TX
Text Notes 1650 1150 0    39   ~ 0
IC Max 20 µA \nNominal 40mA from relay
Text Label 3500 2400 1    39   ~ 0
+12V
Text Label 3350 3200 3    39   ~ 0
PGND
Text Notes 950  5500 1    39   ~ 0
C7 near pins 4 and 3
Text Notes 1700 5500 1    39   ~ 0
C9 near pins 5 and 6
Connection ~ 6150 2750
Connection ~ 2950 2950
Wire Wire Line
	5850 4950 5850 5250
Wire Wire Line
	6150 2450 6150 2800
Wire Wire Line
	5650 3200 5650 3050
Connection ~ 3900 2750
Wire Wire Line
	2950 2850 2950 3200
Wire Wire Line
	3900 2800 3900 2750
Wire Wire Line
	3900 3100 3900 3200
Wire Wire Line
	3500 2100 3500 2800
Connection ~ 3500 2750
Wire Wire Line
	3500 3200 3500 3100
Connection ~ 4200 2750
Wire Wire Line
	4200 2750 4200 2800
Wire Wire Line
	4200 3200 4200 3100
Wire Wire Line
	6150 3200 6150 3100
Wire Wire Line
	3850 2750 5250 2750
Connection ~ 4200 3200
Wire Wire Line
	6500 4950 6500 5050
Connection ~ 6750 4950
Wire Wire Line
	6500 5450 6500 5350
Wire Wire Line
	6750 5350 6750 5550
Connection ~ 6750 5450
Wire Wire Line
	7200 5450 7150 5450
Wire Wire Line
	1100 1400 1550 1400
Wire Wire Line
	1100 1700 1100 1750
Wire Wire Line
	6750 4950 6750 5050
Wire Wire Line
	5850 4950 6750 4950
Wire Wire Line
	4250 5450 6850 5450
Wire Wire Line
	6150 2750 6050 2750
Wire Wire Line
	3850 3200 6150 3200
Wire Wire Line
	6650 4250 7200 4250
Wire Wire Line
	6650 4350 7200 4350
Wire Wire Line
	6750 3950 6750 4150
Wire Wire Line
	6750 4150 7200 4150
Connection ~ 6500 5450
Wire Wire Line
	4250 5350 5150 5350
Wire Wire Line
	5150 5350 5150 5250
Wire Wire Line
	5150 4950 5050 4950
Wire Wire Line
	5050 4950 5050 5250
Wire Wire Line
	5050 5250 4250 5250
Connection ~ 6500 4950
Wire Wire Line
	8100 6050 8100 5450
Wire Wire Line
	5700 6050 8100 6050
Wire Wire Line
	6750 6050 6750 5850
Wire Wire Line
	5700 6050 5700 5900
Connection ~ 6750 6050
Wire Wire Line
	4250 5600 5350 5600
Wire Wire Line
	5350 5600 5350 5700
Wire Wire Line
	5350 5700 5700 5700
Wire Wire Line
	5700 5800 5250 5800
Wire Wire Line
	5250 5800 5250 5700
Wire Wire Line
	5250 5700 4250 5700
Wire Wire Line
	2400 1500 3100 1500
Wire Wire Line
	2700 1650 2700 1500
Connection ~ 2700 1500
Wire Wire Line
	2400 1600 2400 2100
Wire Wire Line
	2400 2100 3100 2100
Wire Wire Line
	2700 1950 2700 2100
Connection ~ 2700 2100
Wire Wire Line
	4250 6000 4750 6000
Wire Wire Line
	4750 6000 4750 6050
Wire Wire Line
	4750 6050 5000 6050
Wire Wire Line
	1100 1700 1250 1700
Wire Wire Line
	1550 1500 1250 1500
Wire Wire Line
	1250 1500 1250 1700
Wire Wire Line
	3600 1500 3600 1400
Wire Wire Line
	3600 1400 4400 1400
Wire Wire Line
	4000 1400 4000 1600
Wire Wire Line
	4000 1950 4000 2200
Connection ~ 4000 2200
Wire Wire Line
	4100 2200 4100 1950
Connection ~ 4100 2200
Wire Wire Line
	4400 1400 4400 1550
Connection ~ 4000 1400
Wire Wire Line
	3200 2200 5050 2200
Wire Wire Line
	3450 2750 3550 2750
Wire Wire Line
	2950 3200 3550 3200
Connection ~ 3500 3200
Connection ~ 3900 3200
Wire Wire Line
	3200 2200 3200 3200
Connection ~ 3200 3200
Wire Wire Line
	4550 3000 4550 3200
Connection ~ 4550 3200
Connection ~ 5650 3200
Wire Wire Line
	2300 4650 2300 4600
Wire Wire Line
	2300 4600 2350 4600
Wire Wire Line
	1950 4950 2300 4950
Wire Wire Line
	1950 6300 1950 4700
Wire Wire Line
	1850 4300 2350 4300
Wire Wire Line
	1950 4300 1950 4400
Connection ~ 1950 4300
Wire Wire Line
	1050 4000 2350 4000
Wire Wire Line
	2350 4000 2350 4100
Connection ~ 1350 4000
Wire Wire Line
	2350 6300 2350 6100
Connection ~ 2350 6200
Wire Wire Line
	1150 6300 2350 6300
Connection ~ 1150 4000
Wire Wire Line
	1500 5000 1500 4800
Wire Wire Line
	1500 4800 1150 4800
Connection ~ 1150 4800
Wire Wire Line
	1150 6300 1150 5300
Wire Wire Line
	1500 5300 1500 6300
Connection ~ 1500 6300
Wire Wire Line
	1350 4300 1350 4000
Wire Wire Line
	1150 4000 1150 5000
Connection ~ 1950 6300
Connection ~ 1950 4950
Text Label 4500 2750 0    39   ~ 0
REG_PWR
Text GLabel 5050 800  0    47   Input ~ 0
Vcc
Wire Wire Line
	4500 1400 4500 1550
Text Notes 5550 1600 0    39   ~ 0
Failure analysis P1:\nPin:  ~LEVEL_ALERT:\n - May short to GND or PGND, both are equivalent to\n   level alert triggering normally.\n - May short to +12V.  Diode becomes reverse biased\n   and level_alert goes to 5V. \n\nPin: 12V\n - May short to PGND, fuse will trip.\n - May short to GND, fuse will trip. May damage traces \n   and zero ohm resistor between GND and PGND.\nPin: PGND\n - May short to GND. Harmless. 
Text Notes 6300 2500 0    39   ~ 0
Vcc = 5 ±0.36V
$Comp
L R R10
U 1 1 5943E431
P 5050 950
F 0 "R10" V 5130 950 50  0000 C CNN
F 1 "10K" V 5050 950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 950 50  0001 C CNN
F 3 "" H 5050 950 50  0000 C CNN
	1    5050 950 
	1    0    0    -1  
$EndComp
$Comp
L R R13
U 1 1 5943E533
P 5050 1550
F 0 "R13" V 5130 1550 50  0000 C CNN
F 1 "10K" V 5050 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 1550 50  0001 C CNN
F 3 "" H 5050 1550 50  0000 C CNN
	1    5050 1550
	1    0    0    -1  
$EndComp
$Comp
L D D9
U 1 1 5943E5C5
P 5050 1250
F 0 "D9" H 5050 1350 50  0000 C CNN
F 1 "D" H 5050 1150 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 5050 1250 50  0001 C CNN
F 3 "" H 5050 1250 50  0000 C CNN
	1    5050 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4500 1400 5050 1400
Wire Wire Line
	5050 2200 5050 1700
$Comp
L CONN_01X04 P5
U 1 1 59448982
P 4950 7200
F 0 "P5" H 4950 7450 50  0000 C CNN
F 1 "CONN_01X04" V 5050 7200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x02_Pitch2.54mm" H 4950 7200 50  0001 C CNN
F 3 "" H 4950 7200 50  0000 C CNN
	1    4950 7200
	1    0    0    -1  
$EndComp
Text GLabel 4750 7050 0    39   Input ~ 0
SHORT_LED
Text GLabel 4750 7250 0    39   Input ~ 0
LEVEL_LED
Text GLabel 4750 7150 0    39   Input ~ 0
BUZZER
$Comp
L GND #PWR6
U 1 1 59448EAB
P 4750 7350
F 0 "#PWR6" H 4750 7100 50  0001 C CNN
F 1 "GND" H 4750 7200 50  0000 C CNN
F 2 "" H 4750 7350 50  0000 C CNN
F 3 "" H 4750 7350 50  0000 C CNN
	1    4750 7350
	1    0    0    -1  
$EndComp
Text GLabel 4250 6100 2    39   Input ~ 0
SHORT_LED
Text GLabel 4250 6200 2    39   Input ~ 0
LEVEL_LED
Text GLabel 4250 6300 2    39   Input ~ 0
BUZZER
$Comp
L CONN_01X03 P6
U 1 1 5944D8B8
P 5700 6800
F 0 "P6" H 5700 7000 50  0000 C CNN
F 1 "CONN_01X03" V 5800 6800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5700 6800 50  0001 C CNN
F 3 "" H 5700 6800 50  0000 C CNN
	1    5700 6800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR7
U 1 1 5944D95E
P 5500 6900
F 0 "#PWR7" H 5500 6650 50  0001 C CNN
F 1 "GND" H 5500 6750 50  0000 C CNN
F 2 "" H 5500 6900 50  0000 C CNN
F 3 "" H 5500 6900 50  0000 C CNN
	1    5500 6900
	1    0    0    -1  
$EndComp
Text GLabel 5500 6700 0    47   Input ~ 0
Vcc
Text GLabel 4250 5900 2    39   Input ~ 0
INT1
Text GLabel 5500 6800 0    39   Input ~ 0
INT1
Wire Wire Line
	4500 2200 4500 2050
Wire Wire Line
	4400 2200 4400 2050
Connection ~ 4400 2200
Connection ~ 4500 2200
Text GLabel 1350 2600 3    39   Input ~ 0
Vcc
$Comp
L CONN_02X06 P4
U 1 1 59459832
P 1600 2350
F 0 "P4" H 1600 2700 50  0000 C CNN
F 1 "CONN_02X06" H 1600 2000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x06_Pitch2.54mm" H 1600 1150 50  0001 C CNN
F 3 "" H 1600 1150 50  0000 C CNN
	1    1600 2350
	0    1    1    0   
$EndComp
Text Label 2950 2750 1    39   ~ 0
PWR
Text Notes 3450 3400 0    60   ~ 0
750mW max
$Comp
L D D10
U 1 1 596E0149
P 5600 2450
F 0 "D10" H 5600 2550 50  0000 C CNN
F 1 "D" H 5600 2350 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 5600 2450 50  0001 C CNN
F 3 "" H 5600 2450 50  0000 C CNN
	1    5600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 2450 5750 2450
Text Notes 5200 2200 0    39   ~ 0
Reverse bias protection diode. Also makes sure the \nelectrolytes have a well defined voltage over them.\nAnd that the PWR_LED illuminates (very weakly) when \nprogramming the device.
Wire Wire Line
	3500 2450 5450 2450
$Comp
L LM7805CT U1
U 1 1 59277F88
P 5650 2800
F 0 "U1" H 5450 3000 50  0000 C CNN
F 1 "LM7805CT" H 5650 3000 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 5650 2900 50  0001 C CIN
F 3 "http://www.farnell.com/datasheets/2303956.pdf" H 5650 2800 50  0001 C CNN
	1    5650 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2750 5250 3000
Connection ~ 3500 2450
Text Notes 3600 2450 0    39   ~ 0
5A max peak. 3A max sustain Trip: 5s@8A 
NoConn ~ 6550 1900
NoConn ~ 6050 2000
$Comp
L R R?
U 1 1 5B016988
P 6600 3950
F 0 "R?" V 6700 3950 50  0000 C CNN
F 1 "10K" V 6600 3950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6530 3950 50  0001 C CNN
F 3 "" H 6600 3950 50  0000 C CNN
	1    6600 3950
	0    -1   -1   0   
$EndComp
Text GLabel 6750 3950 1    39   Input ~ 0
MOISTURE
$Comp
L R R?
U 1 1 5B016989
P 6500 4350
F 0 "R?" V 6580 4350 50  0000 C CNN
F 1 "100K" V 6500 4350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4350 50  0001 C CNN
F 3 "" H 6500 4350 50  0000 C CNN
	1    6500 4350
	0    1    1    0   
$EndComp
$Comp
L MIC94090 U?
U 1 1 5B01698A
P 2400 1150
F 0 "U?" H 2850 1750 47  0000 C CNN
F 1 "MIC94090" H 2850 1250 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 2300 1150 47  0001 C CNN
F 3 "" H 2300 1150 47  0001 C CNN
	1    2400 1150
	-1   0    0    1   
$EndComp
NoConn ~ 2400 1400
Text GLabel 1550 1600 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON?
U 1 1 5B01698B
P 2650 2850
F 0 "CON?" H 2650 3100 50  0000 C CNN
F 1 "POWER" H 2650 2650 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 2650 2850 50  0001 C CNN
F 3 "" H 2650 2850 50  0000 C CNN
	1    2650 2850
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B01698C
P 6150 2950
F 0 "C?" H 6175 3050 50  0000 L CNN
F 1 "100nF" V 5950 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6188 2800 50  0001 C CNN
F 3 "" H 6150 2950 50  0000 C CNN
	1    6150 2950
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B01698D
P 4750 3000
F 0 "D?" H 4750 3150 50  0000 C CNN
F 1 "PWR_LED" H 4750 2900 50  0000 C CNN
F 2 "LEDs:LED_0603" H 4750 3000 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 4750 3000 50  0001 C CNN
	1    4750 3000
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B01698E
P 5150 6050
F 0 "R?" V 5230 6050 50  0000 C CNN
F 1 "1K5" V 5150 6050 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5080 6050 50  0001 C CNN
F 3 "" H 5150 6050 50  0000 C CNN
	1    5150 6050
	0    -1   -1   0   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B01698F
P 5500 6050
F 0 "D?" H 5500 6150 50  0000 C CNN
F 1 "PUMP_LED" H 5800 6150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5500 6050 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5500 6050 50  0001 C CNN
	1    5500 6050
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW?
U 1 1 5B016990
P 7800 5450
F 0 "SW?" H 7950 5560 50  0000 C CNN
F 1 "RESET" H 7800 5370 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 7800 5450 50  0001 C CNN
F 3 "" H 7800 5450 50  0000 C CNN
	1    7800 5450
	-1   0    0    -1  
$EndComp
Text GLabel 4900 6050 1    39   Input ~ 0
PUMP
$Comp
L GND #PWR?
U 1 1 5B016991
P 6750 6050
F 0 "#PWR?" H 6750 5800 50  0001 C CNN
F 1 "GND" H 6750 5900 50  0000 C CNN
F 2 "" H 6750 6050 50  0000 C CNN
F 3 "" H 6750 6050 50  0000 C CNN
	1    6750 6050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B016992
P 1100 1750
F 0 "#PWR?" H 1100 1500 50  0001 C CNN
F 1 "GND" H 1100 1600 50  0000 C CNN
F 2 "" H 1100 1750 50  0000 C CNN
F 3 "" H 1100 1750 50  0000 C CNN
	1    1100 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P?
U 1 1 5B016993
P 5900 5750
F 0 "P?" H 5900 6000 50  0000 C CNN
F 1 "UART" V 6000 5750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5900 5750 50  0001 C CNN
F 3 "" H 5900 5750 50  0000 C CNN
	1    5900 5750
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B016994
P 5700 5250
F 0 "R?" V 5780 5250 50  0000 C CNN
F 1 "1K5" V 5700 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 5250 50  0001 C CNN
F 3 "" H 5700 5250 50  0000 C CNN
	1    5700 5250
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B016995
P 5350 5250
F 0 "D?" H 5350 5350 50  0000 C CNN
F 1 "TX_LED" H 5350 5150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 5250 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 5250 50  0001 C CNN
	1    5350 5250
	1    0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B016996
P 5350 4950
F 0 "D?" H 5350 5050 50  0000 C CNN
F 1 "RX_LED" H 5350 4850 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 4950 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 4950 50  0001 C CNN
	1    5350 4950
	1    0    0    1   
$EndComp
$Comp
L R R?
U 1 1 5B016997
P 5700 4950
F 0 "R?" V 5780 4950 50  0000 C CNN
F 1 "1K5" V 5700 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 4950 50  0001 C CNN
F 3 "" H 5700 4950 50  0000 C CNN
	1    5700 4950
	0    1    1    0   
$EndComp
$Comp
L CONN_02X02 P?
U 1 1 5B016998
P 4450 1800
F 0 "P?" H 4450 1950 50  0000 C CNN
F 1 "PUMP" H 4450 1650 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 4450 600 50  0001 C CNN
F 3 "" H 4450 600 50  0000 C CNN
	1    4450 1800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B016999
P 2700 1500
F 0 "#PWR?" H 2700 1250 50  0001 C CNN
F 1 "GND" H 2700 1350 50  0000 C CNN
F 2 "" H 2700 1500 50  0000 C CNN
F 3 "" H 2700 1500 50  0000 C CNN
	1    2700 1500
	1    0    0    1   
$EndComp
Text GLabel 4250 5800 2    39   Input ~ 0
~OVRFLW
Text GLabel 6150 2750 2    47   Input ~ 0
Vcc
Text GLabel 5700 5600 0    47   Input ~ 0
Vcc
Text GLabel 1100 1400 1    47   Input ~ 0
Vcc
Text Notes 5000 4800 0    39   ~ 0
Yellow LED (2.2V, 20mA, 100mcd): \n(5V - 2.2V) / (20mA*8mcd/100mcd) = 1750 Ohm.\nPick 1k5 Ohm (E12)
Text Notes 4250 3550 0    39   ~ 0
Green LED (2.2V, 20mA, 6mcd): \nWe want 8mcd brightness: \n(12V -0.7V - 2.2V) / 20mA = 455 Ohm.  \nPick 1.5K Ohm (E12, BOM reuse).
Text Notes 7700 4650 0    39   ~ 0
MOIST+ and MOIST- are normally tristate.\nWhen measuring + is driven high and - is driven low causing a current to flow through\nR6 and the soil (two electrodes connected between pin 2 and 3 of P2). Then the polarity\nis reversed to counteract electron migration on the electrodes.\nThe voltage at the divider is measured using ADC. \nR6 is chosen based on earlier experiments for the designed target soil. \n\nBetween pins 5 and 6 of P2 are two electrodes that short if the pot overflows with water.\nR5 forms a series resistance with the electrodes and is weakly pulled high.  The value for\nR5 is chosen based on measured resistance of tap water with large electrodes.\nThe resistance measured was around 2k for 3cm galvanized screws submerged\nin water. The expected voltage on INT0 when in water is 0.02*Vcc. Internal pull-up\nmust be disabled. An IRQ will trigger up to 72k resistance between the probes. \n(ATmega has 2.6V input threshold on pins and .5V hysteresis)\n\n\nR12 likewise forms a voltage divider but with a thermistor, the datasheet suggest a \n5k11 series resistor to linearise the thermistor. We use THERM+ to drive the divider\nwhen we want to measure. Otherwise THERM+ is tristate. 5V/5K = 1mA which the GPIO\npin can easily drive.
Text Notes 4750 6400 0    39   ~ 0
Red LED (2.2V , 20mA, 40mcd): We want 8mcd brightness:\n(5V - 2.2V) / (20mA * 8mcd/40mcd) = 700 Ohm.\nPick 1K5 Ohm (E12) for bom reuse.
$Comp
L D D?
U 1 1 5B01699A
P 3700 2750
F 0 "D?" H 3700 2850 50  0000 C CNN
F 1 "D" H 3700 2650 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 3700 2750 50  0001 C CNN
F 3 "" H 3700 2750 50  0000 C CNN
	1    3700 2750
	-1   0    0    1   
$EndComp
$Comp
L CP C?
U 1 1 5B01699B
P 3900 2950
F 0 "C?" H 3925 3050 50  0000 L CNN
F 1 "100µF" H 3650 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3938 2800 50  0001 C CNN
F 3 "" H 3900 2950 50  0000 C CNN
	1    3900 2950
	1    0    0    -1  
$EndComp
$Comp
L CP C?
U 1 1 5B01699C
P 3500 2950
F 0 "C?" H 3525 3050 50  0000 L CNN
F 1 "100µF" H 3250 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3538 2800 50  0001 C CNN
F 3 "" H 3500 2950 50  0000 C CNN
	1    3500 2950
	1    0    0    -1  
$EndComp
Text Label 3700 1400 0    47   ~ 0
PUMP+
Text GLabel 6650 4350 3    39   Input ~ 0
~OVRFLW
$Comp
L PWR_FLAG #FLG?
U 1 1 5B01699D
P 1950 4300
F 0 "#FLG?" H 1950 4395 50  0001 C CNN
F 1 "PWR_FLAG" H 1950 4480 50  0000 C CNN
F 2 "" H 1950 4300 50  0000 C CNN
F 3 "" H 1950 4300 50  0000 C CNN
	1    1950 4300
	-1   0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B01699E
P 3700 3200
F 0 "R?" V 3780 3200 50  0000 C CNN
F 1 "0" V 3700 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_2010" V 3630 3200 50  0001 C CNN
F 3 "" H 3700 3200 50  0000 C CNN
	1    3700 3200
	0    1    1    0   
$EndComp
Text Label 2900 2100 2    60   ~ 0
COIL_PWR
Text Notes 1200 3950 0    39   ~ 0
AVcc LC circuit taken from AVR datasheet.
$Comp
L R R?
U 1 1 5B01699F
P 5100 3000
F 0 "R?" V 5200 3000 50  0000 C CNN
F 1 "1K5" V 5100 3000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5030 3000 50  0001 C CNN
F 3 "" H 5100 3000 50  0000 C CNN
	1    5100 3000
	0    1    -1   0   
$EndComp
$Comp
L C C?
U 1 1 5B0169A0
P 4200 2950
F 0 "C?" H 4225 3050 50  0000 L CNN
F 1 "100nF" H 4225 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4238 2800 50  0001 C CNN
F 3 "" H 4200 2950 50  0000 C CNN
	1    4200 2950
	1    0    0    -1  
$EndComp
$Comp
L FINDER-32.21-x300 RL?
U 1 1 5B0169A1
P 3300 1800
F 0 "RL?" H 3550 1800 50  0000 L CNN
F 1 "FINDER-32.21-x300" V 3350 1450 50  0000 L CNN
F 2 "Relays_THT:Relay_SPST_Finder_32.21-x300" H 3300 1800 50  0001 C CNN
F 3 "" H 3300 1800 50  0000 C CNN
	1    3300 1800
	1    0    0    -1  
$EndComp
Text Notes 2450 2250 0    60   ~ 0
40mA @ 5V
Text Notes 8000 2700 0    39   ~ 0
5V Load Summary:\n - MCU: 1MHz@5V (internal RC)  < 1mA active \n - Moisture probe: 5V/10KR = 500µA (when shorted)\n - Overflow sensor: 5V/100KR = 50µA (when shorted)\n - Level alert:  50µA when active (pullup from ground)\n - Thermal probe 1mA (when shorted)\n - Pump relay 40mA (nominal)\n - MIC94090 20µA\n - Pump LED max 2mA.\n - RX/TX should be low but max 40mA total\n - RX/TX LED max 40mA total. \n\nTotal MAX: < 140 mA (without extension ports)\n - Typical Sleep: <  100µA\n - Typical Active: < 70 mA\n - Typical Duty Cycle: 0.13% \n\nThermal dissipation LM7805:\n - Max: (12- 0.6 - 5) *0.140 = 896mW\n - Typical Sleep: (12- 0.6 - 5) *0.0001 = 0.64mW\n - Typical Active: (12- 0.6 - 5) *0.070 = 448mW \n - Average expected: 0.0013*448  + 0.9987 *0.64 = 1.2 mW \n - TO220 package safe dissipation without heat sink 1W.\n
Text GLabel 1650 2600 3    39   Input ~ 0
MISO
Text GLabel 1750 2600 3    39   Input ~ 0
SCK
Text GLabel 1850 2600 3    39   Input ~ 0
~RESET
Text GLabel 1750 2100 1    39   Input ~ 0
MOSI
$Comp
L GND #PWR?
U 1 1 5B0169A2
P 1850 2100
F 0 "#PWR?" H 1850 1850 50  0001 C CNN
F 1 "GND" H 1850 1950 50  0000 C CNN
F 2 "" H 1850 2100 50  0000 C CNN
F 3 "" H 1850 2100 50  0000 C CNN
	1    1850 2100
	0    -1   -1   0   
$EndComp
Text GLabel 4250 4400 2    39   Input ~ 0
MISO
Text GLabel 4250 4500 2    39   Input ~ 0
SCK
Text GLabel 4250 4300 2    39   Input ~ 0
MOSI
$Comp
L INDUCTOR_SMALL L?
U 1 1 5B0169A3
P 1600 4300
F 0 "L?" H 1600 4400 50  0000 C CNN
F 1 "10µH" H 1600 4250 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 1600 4300 50  0001 C CNN
F 3 "" H 1600 4300 50  0000 C CNN
	1    1600 4300
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B0169A4
P 1950 4550
F 0 "C?" H 1975 4650 50  0000 L CNN
F 1 "100nF" V 2100 4300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1988 4400 50  0001 C CNN
F 3 "" H 1950 4550 50  0000 C CNN
	1    1950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B0169A5
P 5650 3200
F 0 "#PWR?" H 5650 2950 50  0001 C CNN
F 1 "GND" H 5650 3050 50  0000 C CNN
F 2 "" H 5650 3200 50  0000 C CNN
F 3 "" H 5650 3200 50  0000 C CNN
	1    5650 3200
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B0169A6
P 6750 5200
F 0 "R?" V 6830 5200 50  0000 C CNN
F 1 "4K7" V 6750 5200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6680 5200 50  0001 C CNN
F 3 "" H 6750 5200 50  0000 C CNN
	1    6750 5200
	1    0    0    1   
$EndComp
$Comp
L C C?
U 1 1 5B0169A7
P 6750 5700
F 0 "C?" H 6775 5800 50  0000 L CNN
F 1 "100nF" H 6775 5600 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6788 5550 50  0001 C CNN
F 3 "" H 6750 5700 50  0000 C CNN
	1    6750 5700
	-1   0    0    -1  
$EndComp
Text GLabel 6300 5450 1    39   Input ~ 0
~RESET
Text GLabel 4250 5150 2    39   Input ~ 0
~LEVEL_ALERT
$Comp
L D_Schottky D?
U 1 1 5B0169A8
P 6500 5200
F 0 "D?" H 6500 5300 50  0000 C CNN
F 1 "D_Schottky" H 6500 5100 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 6500 5200 50  0001 C CNN
F 3 "" H 6500 5200 50  0001 C CNN
	1    6500 5200
	0    -1   1    0   
$EndComp
Text GLabel 6750 4950 1    47   Input ~ 0
Vcc
$Comp
L R R?
U 1 1 5B0169A9
P 7000 5450
F 0 "R?" V 7080 5450 50  0000 C CNN
F 1 "150" V 7000 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6930 5450 50  0001 C CNN
F 3 "" H 7000 5450 50  0000 C CNN
	1    7000 5450
	0    1    -1   0   
$EndComp
$Comp
L D_Schottky D?
U 1 1 5B0169AA
P 2700 1800
F 0 "D?" H 2700 1900 50  0000 C CNN
F 1 "D_Schottky" H 2700 1700 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 2700 1800 50  0001 C CNN
F 3 "" H 2700 1800 50  0001 C CNN
	1    2700 1800
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 5B0169AB
P 7350 5450
F 0 "R?" V 7430 5450 50  0000 C CNN
F 1 "150" V 7350 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7280 5450 50  0001 C CNN
F 3 "" H 7350 5450 50  0000 C CNN
	1    7350 5450
	0    1    -1   0   
$EndComp
Text GLabel 5050 1100 2    39   Input ~ 0
~LEVEL_ALERT
Text Notes 4950 1150 2    39   ~ 0
Level alert is debounced\nin software.
Text Notes 7850 5200 2    39   ~ 0
Recommended reset circuit\nfrom AVR HW considerations.
$Comp
L C C?
U 1 1 5B0169AC
P 1100 1550
F 0 "C?" H 1125 1650 50  0000 L CNN
F 1 "100nF" V 950 1450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1138 1400 50  0001 C CNN
F 3 "" H 1100 1550 50  0000 C CNN
	1    1100 1550
	1    0    0    -1  
$EndComp
$Comp
L ATMEGA168-20AU U?
U 1 1 5B0169AD
P 3250 5100
F 0 "U?" H 2500 6350 50  0000 L BNN
F 1 "ATMEGA168-20AU" H 3700 3700 50  0000 L BNN
F 2 "Housings_QFP:TQFP-32_7x7mm_Pitch0.8mm" H 3250 5100 50  0001 C CIN
F 3 "" H 3250 5100 50  0001 C CNN
	1    3250 5100
	1    0    0    -1  
$EndComp
Text GLabel 2350 4300 3    47   Input ~ 0
AVcc
$Comp
L C C?
U 1 1 5B0169AE
P 1500 5150
F 0 "C?" H 1525 5250 50  0000 L CNN
F 1 "100nF" V 1350 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1538 5000 50  0001 C CNN
F 3 "" H 1500 5150 50  0000 C CNN
	1    1500 5150
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B0169AF
P 1150 5150
F 0 "C?" H 1175 5250 50  0000 L CNN
F 1 "100nF" V 1000 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1188 5000 50  0001 C CNN
F 3 "" H 1150 5150 50  0000 C CNN
	1    1150 5150
	1    0    0    -1  
$EndComp
Text GLabel 1050 4000 0    47   Input ~ 0
Vcc
Text GLabel 4250 4950 2    39   Input ~ 0
MOIST+
Text GLabel 4250 4850 2    39   Input ~ 0
MOIST-
Text GLabel 2350 5350 0    39   Input ~ 0
MOISTURE
Text GLabel 6450 3950 1    39   Input ~ 0
MOIST+
Text GLabel 7200 4050 0    39   Input ~ 0
MOIST-
Text GLabel 6650 4250 1    39   Input ~ 0
THERM
Text GLabel 4250 4000 2    39   Input ~ 0
EXT_D0
Text GLabel 4250 4100 2    39   Input ~ 0
EXT_D1
Text GLabel 1550 2600 3    39   Input ~ 0
EXT_D7
$Comp
L C C?
U 1 1 5B0169B0
P 2300 4800
F 0 "C?" H 2325 4900 50  0000 L CNN
F 1 "10nF" V 2400 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2338 4650 50  0001 C CNN
F 3 "" H 2300 4800 50  0000 C CNN
	1    2300 4800
	1    0    0    -1  
$EndComp
Text GLabel 1350 2100 1    39   Input ~ 0
EXT_D0
Text GLabel 1450 2100 1    39   Input ~ 0
EXT_D1
Text GLabel 4250 4200 2    39   Input ~ 0
EXT_D2
Text GLabel 1650 2100 1    47   Input ~ 0
Vcc
$Comp
L D_Schottky_AKA D?
U 1 1 5B0169B1
P 4000 1750
F 0 "D?" H 4000 1850 50  0000 C CNN
F 1 "D_Schottky_AKA" H 4000 1650 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 4000 1750 50  0001 C CNN
F 3 "" H 4000 1750 50  0001 C CNN
	1    4000 1750
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 5B0169B2
P 6500 4250
F 0 "R?" V 6400 4250 50  0000 C CNN
F 1 "5K11" V 6500 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4250 50  0001 C CNN
F 3 "" H 6500 4250 50  0000 C CNN
	1    6500 4250
	0    1    1    0   
$EndComp
Text GLabel 6350 4250 0    39   Input ~ 0
THERM+
$Comp
L CONN_01X06 P?
U 1 1 5B0169B3
P 7400 4200
F 0 "P?" H 7400 4550 50  0000 C CNN
F 1 "PLANT" V 7500 4200 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S6B-PH-K_06x2.00mm_Angled" H 7400 4200 50  0001 C CNN
F 3 "" H 7400 4200 50  0000 C CNN
	1    7400 4200
	1    0    0    -1  
$EndComp
Text GLabel 2350 5450 0    39   Input ~ 0
THERM
Text GLabel 4250 5050 2    39   Input ~ 0
THERM+
Text GLabel 1450 2600 3    39   Input ~ 0
EXT_D6
Text GLabel 6350 4350 0    47   Input ~ 0
AVcc
$Comp
L GND #PWR?
U 1 1 5B0169B4
P 1500 6300
F 0 "#PWR?" H 1500 6050 50  0001 C CNN
F 1 "GND" H 1500 6150 50  0000 C CNN
F 2 "" H 1500 6300 50  0000 C CNN
F 3 "" H 1500 6300 50  0000 C CNN
	1    1500 6300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B0169B5
P 7200 4450
F 0 "#PWR?" H 7200 4200 50  0001 C CNN
F 1 "GND" H 7200 4300 50  0000 C CNN
F 2 "" H 7200 4450 50  0000 C CNN
F 3 "" H 7200 4450 50  0000 C CNN
	1    7200 4450
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG?
U 1 1 5B0169B6
P 2300 6750
F 0 "#FLG?" H 2300 6845 50  0001 C CNN
F 1 "PWR_FLAG" H 2300 6930 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B0169B7
P 2300 6750
F 0 "#PWR?" H 2300 6500 50  0001 C CNN
F 1 "GND" H 2300 6600 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
Text GLabel 1550 2100 1    39   Input ~ 0
EXT_D2
Text GLabel 4250 4600 2    39   Input ~ 0
EXT_D6
Text GLabel 4250 4700 2    39   Input ~ 0
EXT_D7
$Comp
L GND #PWR?
U 1 1 5B0169B8
P 7200 3950
F 0 "#PWR?" H 7200 3700 50  0001 C CNN
F 1 "GND" V 7200 3750 50  0000 C CNN
F 2 "" H 7200 3950 50  0000 C CNN
F 3 "" H 7200 3950 50  0000 C CNN
	1    7200 3950
	0    1    -1   0   
$EndComp
$Comp
L FUSE F?
U 1 1 5B0169B9
P 3200 2750
F 0 "F?" H 3300 2800 50  0000 C CNN
F 1 "FUSE" H 3100 2700 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_SMD2920" H 3200 2750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2038617.pdf" H 3200 2750 50  0001 C CNN
	1    3200 2750
	1    0    0    -1  
$EndComp
Text Label 4400 5350 0    39   ~ 0
TX_LED
Text Label 4400 5250 0    39   ~ 0
RX_LED
Text Label 4400 5600 0    39   ~ 0
RX
Text Label 4400 5700 0    39   ~ 0
TX
Text Notes 1650 1150 0    39   ~ 0
IC Max 20 µA \nNominal 40mA from relay
Text Label 3500 2400 1    39   ~ 0
+12V
Text Label 3350 3200 3    39   ~ 0
PGND
Text Notes 950  5500 1    39   ~ 0
C7 near pins 4 and 3
Text Notes 1700 5500 1    39   ~ 0
C9 near pins 5 and 6
Connection ~ 6150 2750
Connection ~ 2950 2950
Wire Wire Line
	5850 4950 5850 5250
Wire Wire Line
	6150 2450 6150 2800
Wire Wire Line
	5650 3200 5650 3050
Connection ~ 3900 2750
Wire Wire Line
	2950 2850 2950 3200
Wire Wire Line
	3900 2800 3900 2750
Wire Wire Line
	3900 3100 3900 3200
Wire Wire Line
	3500 2100 3500 2800
Connection ~ 3500 2750
Wire Wire Line
	3500 3200 3500 3100
Connection ~ 4200 2750
Wire Wire Line
	4200 2750 4200 2800
Wire Wire Line
	4200 3200 4200 3100
Wire Wire Line
	6150 3200 6150 3100
Wire Wire Line
	3850 2750 5250 2750
Connection ~ 4200 3200
Wire Wire Line
	6500 4950 6500 5050
Connection ~ 6750 4950
Wire Wire Line
	6500 5450 6500 5350
Wire Wire Line
	6750 5350 6750 5550
Connection ~ 6750 5450
Wire Wire Line
	7200 5450 7150 5450
Wire Wire Line
	1100 1400 1550 1400
Wire Wire Line
	1100 1700 1100 1750
Wire Wire Line
	6750 4950 6750 5050
Wire Wire Line
	5850 4950 6750 4950
Wire Wire Line
	4250 5450 6850 5450
Wire Wire Line
	6150 2750 6050 2750
Wire Wire Line
	3850 3200 6150 3200
Wire Wire Line
	6650 4250 7200 4250
Wire Wire Line
	6650 4350 7200 4350
Wire Wire Line
	6750 3950 6750 4150
Wire Wire Line
	6750 4150 7200 4150
Connection ~ 6500 5450
Wire Wire Line
	4250 5350 5150 5350
Wire Wire Line
	5150 5350 5150 5250
Wire Wire Line
	5150 4950 5050 4950
Wire Wire Line
	5050 4950 5050 5250
Wire Wire Line
	5050 5250 4250 5250
Connection ~ 6500 4950
Wire Wire Line
	8100 6050 8100 5450
Wire Wire Line
	5700 6050 8100 6050
Wire Wire Line
	6750 6050 6750 5850
Wire Wire Line
	5700 6050 5700 5900
Connection ~ 6750 6050
Wire Wire Line
	4250 5600 5350 5600
Wire Wire Line
	5350 5600 5350 5700
Wire Wire Line
	5350 5700 5700 5700
Wire Wire Line
	5700 5800 5250 5800
Wire Wire Line
	5250 5800 5250 5700
Wire Wire Line
	5250 5700 4250 5700
Wire Wire Line
	2400 1500 3100 1500
Wire Wire Line
	2700 1650 2700 1500
Connection ~ 2700 1500
Wire Wire Line
	2400 1600 2400 2100
Wire Wire Line
	2400 2100 3100 2100
Wire Wire Line
	2700 1950 2700 2100
Connection ~ 2700 2100
Wire Wire Line
	4250 6000 4750 6000
Wire Wire Line
	4750 6000 4750 6050
Wire Wire Line
	4750 6050 5000 6050
Wire Wire Line
	1100 1700 1250 1700
Wire Wire Line
	1550 1500 1250 1500
Wire Wire Line
	1250 1500 1250 1700
Wire Wire Line
	3600 1500 3600 1400
Wire Wire Line
	3600 1400 4400 1400
Wire Wire Line
	4000 1400 4000 1600
Wire Wire Line
	4000 1950 4000 2200
Connection ~ 4000 2200
Wire Wire Line
	4100 2200 4100 1950
Connection ~ 4100 2200
Wire Wire Line
	4400 1400 4400 1550
Connection ~ 4000 1400
Wire Wire Line
	3200 2200 5050 2200
Wire Wire Line
	3450 2750 3550 2750
Wire Wire Line
	2950 3200 3550 3200
Connection ~ 3500 3200
Connection ~ 3900 3200
Wire Wire Line
	3200 2200 3200 3200
Connection ~ 3200 3200
Wire Wire Line
	4550 3000 4550 3200
Connection ~ 4550 3200
Connection ~ 5650 3200
Wire Wire Line
	2300 4650 2300 4600
Wire Wire Line
	2300 4600 2350 4600
Wire Wire Line
	1950 4950 2300 4950
Wire Wire Line
	1950 6300 1950 4700
Wire Wire Line
	1850 4300 2350 4300
Wire Wire Line
	1950 4300 1950 4400
Connection ~ 1950 4300
Wire Wire Line
	1050 4000 2350 4000
Wire Wire Line
	2350 4000 2350 4100
Connection ~ 1350 4000
Wire Wire Line
	2350 6300 2350 6100
Connection ~ 2350 6200
Wire Wire Line
	1150 6300 2350 6300
Connection ~ 1150 4000
Wire Wire Line
	1500 5000 1500 4800
Wire Wire Line
	1500 4800 1150 4800
Connection ~ 1150 4800
Wire Wire Line
	1150 6300 1150 5300
Wire Wire Line
	1500 5300 1500 6300
Connection ~ 1500 6300
Wire Wire Line
	1350 4300 1350 4000
Wire Wire Line
	1150 4000 1150 5000
Connection ~ 1950 6300
Connection ~ 1950 4950
Text Label 4500 2750 0    39   ~ 0
REG_PWR
Text GLabel 5050 800  0    47   Input ~ 0
Vcc
Wire Wire Line
	4500 1400 4500 1550
Text Notes 5550 1600 0    39   ~ 0
Failure analysis P1:\nPin:  ~LEVEL_ALERT:\n - May short to GND or PGND, both are equivalent to\n   level alert triggering normally.\n - May short to +12V.  Diode becomes reverse biased\n   and level_alert goes to 5V. \n\nPin: 12V\n - May short to PGND, fuse will trip.\n - May short to GND, fuse will trip. May damage traces \n   and zero ohm resistor between GND and PGND.\nPin: PGND\n - May short to GND. Harmless. 
Text Notes 6300 2500 0    39   ~ 0
Vcc = 5 ±0.36V
$Comp
L R R?
U 1 1 5B0169BA
P 5050 950
F 0 "R?" V 5130 950 50  0000 C CNN
F 1 "10K" V 5050 950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 950 50  0001 C CNN
F 3 "" H 5050 950 50  0000 C CNN
	1    5050 950 
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B0169BB
P 5050 1550
F 0 "R?" V 5130 1550 50  0000 C CNN
F 1 "10K" V 5050 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 1550 50  0001 C CNN
F 3 "" H 5050 1550 50  0000 C CNN
	1    5050 1550
	1    0    0    -1  
$EndComp
$Comp
L D D?
U 1 1 5B0169BC
P 5050 1250
F 0 "D?" H 5050 1350 50  0000 C CNN
F 1 "D" H 5050 1150 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 5050 1250 50  0001 C CNN
F 3 "" H 5050 1250 50  0000 C CNN
	1    5050 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4500 1400 5050 1400
Wire Wire Line
	5050 2200 5050 1700
$Comp
L CONN_01X04 P?
U 1 1 5B0169BD
P 4950 7200
F 0 "P?" H 4950 7450 50  0000 C CNN
F 1 "CONN_01X04" V 5050 7200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x02_Pitch2.54mm" H 4950 7200 50  0001 C CNN
F 3 "" H 4950 7200 50  0000 C CNN
	1    4950 7200
	1    0    0    -1  
$EndComp
Text GLabel 4750 7050 0    39   Input ~ 0
SHORT_LED
Text GLabel 4750 7250 0    39   Input ~ 0
LEVEL_LED
Text GLabel 4750 7150 0    39   Input ~ 0
BUZZER
$Comp
L GND #PWR?
U 1 1 5B0169BE
P 4750 7350
F 0 "#PWR?" H 4750 7100 50  0001 C CNN
F 1 "GND" H 4750 7200 50  0000 C CNN
F 2 "" H 4750 7350 50  0000 C CNN
F 3 "" H 4750 7350 50  0000 C CNN
	1    4750 7350
	1    0    0    -1  
$EndComp
Text GLabel 4250 6100 2    39   Input ~ 0
SHORT_LED
Text GLabel 4250 6200 2    39   Input ~ 0
LEVEL_LED
Text GLabel 4250 6300 2    39   Input ~ 0
BUZZER
$Comp
L CONN_01X03 P?
U 1 1 5B0169BF
P 5700 6800
F 0 "P?" H 5700 7000 50  0000 C CNN
F 1 "CONN_01X03" V 5800 6800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5700 6800 50  0001 C CNN
F 3 "" H 5700 6800 50  0000 C CNN
	1    5700 6800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B0169C0
P 5500 6900
F 0 "#PWR?" H 5500 6650 50  0001 C CNN
F 1 "GND" H 5500 6750 50  0000 C CNN
F 2 "" H 5500 6900 50  0000 C CNN
F 3 "" H 5500 6900 50  0000 C CNN
	1    5500 6900
	1    0    0    -1  
$EndComp
Text GLabel 5500 6700 0    47   Input ~ 0
Vcc
Text GLabel 4250 5900 2    39   Input ~ 0
INT1
Text GLabel 5500 6800 0    39   Input ~ 0
INT1
Wire Wire Line
	4500 2200 4500 2050
Wire Wire Line
	4400 2200 4400 2050
Connection ~ 4400 2200
Connection ~ 4500 2200
Text GLabel 1350 2600 3    39   Input ~ 0
Vcc
$Comp
L CONN_02X06 P?
U 1 1 5B0169C1
P 1600 2350
F 0 "P?" H 1600 2700 50  0000 C CNN
F 1 "CONN_02X06" H 1600 2000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x06_Pitch2.54mm" H 1600 1150 50  0001 C CNN
F 3 "" H 1600 1150 50  0000 C CNN
	1    1600 2350
	0    1    1    0   
$EndComp
Text Label 2950 2750 1    39   ~ 0
PWR
Text Notes 3450 3400 0    60   ~ 0
750mW max
$Comp
L D D?
U 1 1 5B0169C2
P 5600 2450
F 0 "D?" H 5600 2550 50  0000 C CNN
F 1 "D" H 5600 2350 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 5600 2450 50  0001 C CNN
F 3 "" H 5600 2450 50  0000 C CNN
	1    5600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 2450 5750 2450
Text Notes 5200 2200 0    39   ~ 0
Reverse bias protection diode. Also makes sure the \nelectrolytes have a well defined voltage over them.\nAnd that the PWR_LED illuminates (very weakly) when \nprogramming the device.
Wire Wire Line
	3500 2450 5450 2450
$Comp
L LM7805CT U?
U 1 1 5B0169C3
P 5650 2800
F 0 "U?" H 5450 3000 50  0000 C CNN
F 1 "LM7805CT" H 5650 3000 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 5650 2900 50  0001 C CIN
F 3 "http://www.farnell.com/datasheets/2303956.pdf" H 5650 2800 50  0001 C CNN
	1    5650 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2750 5250 3000
Connection ~ 3500 2450
Text Notes 3600 2450 0    39   ~ 0
5A max peak. 3A max sustain Trip: 5s@8A 
NoConn ~ 6550 1900
NoConn ~ 6050 2000
$Comp
L R R?
U 1 1 5B018112
P 6600 3950
F 0 "R?" V 6700 3950 50  0000 C CNN
F 1 "10K" V 6600 3950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6530 3950 50  0001 C CNN
F 3 "" H 6600 3950 50  0000 C CNN
	1    6600 3950
	0    -1   -1   0   
$EndComp
Text GLabel 6750 3950 1    39   Input ~ 0
MOISTURE
$Comp
L R R?
U 1 1 5B018113
P 6500 4350
F 0 "R?" V 6580 4350 50  0000 C CNN
F 1 "100K" V 6500 4350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4350 50  0001 C CNN
F 3 "" H 6500 4350 50  0000 C CNN
	1    6500 4350
	0    1    1    0   
$EndComp
$Comp
L MIC94090 U?
U 1 1 5B018114
P 2400 1150
F 0 "U?" H 2850 1750 47  0000 C CNN
F 1 "MIC94090" H 2850 1250 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 2300 1150 47  0001 C CNN
F 3 "" H 2300 1150 47  0001 C CNN
	1    2400 1150
	-1   0    0    1   
$EndComp
NoConn ~ 2400 1400
Text GLabel 1550 1600 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON?
U 1 1 5B018115
P 2650 2850
F 0 "CON?" H 2650 3100 50  0000 C CNN
F 1 "POWER" H 2650 2650 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 2650 2850 50  0001 C CNN
F 3 "" H 2650 2850 50  0000 C CNN
	1    2650 2850
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B018116
P 6150 2950
F 0 "C?" H 6175 3050 50  0000 L CNN
F 1 "100nF" V 5950 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6188 2800 50  0001 C CNN
F 3 "" H 6150 2950 50  0000 C CNN
	1    6150 2950
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B018117
P 4750 3000
F 0 "D?" H 4750 3150 50  0000 C CNN
F 1 "PWR_LED" H 4750 2900 50  0000 C CNN
F 2 "LEDs:LED_0603" H 4750 3000 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 4750 3000 50  0001 C CNN
	1    4750 3000
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B018118
P 5150 6050
F 0 "R?" V 5230 6050 50  0000 C CNN
F 1 "1K5" V 5150 6050 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5080 6050 50  0001 C CNN
F 3 "" H 5150 6050 50  0000 C CNN
	1    5150 6050
	0    -1   -1   0   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B018119
P 5500 6050
F 0 "D?" H 5500 6150 50  0000 C CNN
F 1 "PUMP_LED" H 5800 6150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5500 6050 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5500 6050 50  0001 C CNN
	1    5500 6050
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW?
U 1 1 5B01811A
P 7800 5450
F 0 "SW?" H 7950 5560 50  0000 C CNN
F 1 "RESET" H 7800 5370 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 7800 5450 50  0001 C CNN
F 3 "" H 7800 5450 50  0000 C CNN
	1    7800 5450
	-1   0    0    -1  
$EndComp
Text GLabel 4900 6050 1    39   Input ~ 0
PUMP
$Comp
L GND #PWR?
U 1 1 5B01811B
P 6750 6050
F 0 "#PWR?" H 6750 5800 50  0001 C CNN
F 1 "GND" H 6750 5900 50  0000 C CNN
F 2 "" H 6750 6050 50  0000 C CNN
F 3 "" H 6750 6050 50  0000 C CNN
	1    6750 6050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B01811C
P 1100 1750
F 0 "#PWR?" H 1100 1500 50  0001 C CNN
F 1 "GND" H 1100 1600 50  0000 C CNN
F 2 "" H 1100 1750 50  0000 C CNN
F 3 "" H 1100 1750 50  0000 C CNN
	1    1100 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P?
U 1 1 5B01811D
P 5900 5750
F 0 "P?" H 5900 6000 50  0000 C CNN
F 1 "UART" V 6000 5750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5900 5750 50  0001 C CNN
F 3 "" H 5900 5750 50  0000 C CNN
	1    5900 5750
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B01811E
P 5700 5250
F 0 "R?" V 5780 5250 50  0000 C CNN
F 1 "1K5" V 5700 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 5250 50  0001 C CNN
F 3 "" H 5700 5250 50  0000 C CNN
	1    5700 5250
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B01811F
P 5350 5250
F 0 "D?" H 5350 5350 50  0000 C CNN
F 1 "TX_LED" H 5350 5150 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 5250 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 5250 50  0001 C CNN
	1    5350 5250
	1    0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D?
U 1 1 5B018120
P 5350 4950
F 0 "D?" H 5350 5050 50  0000 C CNN
F 1 "RX_LED" H 5350 4850 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5350 4950 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D12V8W" H 5350 4950 50  0001 C CNN
	1    5350 4950
	1    0    0    1   
$EndComp
$Comp
L R R?
U 1 1 5B018121
P 5700 4950
F 0 "R?" V 5780 4950 50  0000 C CNN
F 1 "1K5" V 5700 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 4950 50  0001 C CNN
F 3 "" H 5700 4950 50  0000 C CNN
	1    5700 4950
	0    1    1    0   
$EndComp
$Comp
L CONN_02X02 P?
U 1 1 5B018122
P 4450 1800
F 0 "P?" H 4450 1950 50  0000 C CNN
F 1 "PUMP" H 4450 1650 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 4450 600 50  0001 C CNN
F 3 "" H 4450 600 50  0000 C CNN
	1    4450 1800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B018123
P 2700 1500
F 0 "#PWR?" H 2700 1250 50  0001 C CNN
F 1 "GND" H 2700 1350 50  0000 C CNN
F 2 "" H 2700 1500 50  0000 C CNN
F 3 "" H 2700 1500 50  0000 C CNN
	1    2700 1500
	1    0    0    1   
$EndComp
Text GLabel 4250 5800 2    39   Input ~ 0
~OVRFLW
Text GLabel 6150 2750 2    47   Input ~ 0
Vcc
Text GLabel 5700 5600 0    47   Input ~ 0
Vcc
Text GLabel 1100 1400 1    47   Input ~ 0
Vcc
Text Notes 5000 4800 0    39   ~ 0
Yellow LED (2.2V, 20mA, 100mcd): \n(5V - 2.2V) / (20mA*8mcd/100mcd) = 1750 Ohm.\nPick 1k5 Ohm (E12)
Text Notes 4250 3550 0    39   ~ 0
Green LED (2.2V, 20mA, 6mcd): \nWe want 8mcd brightness: \n(12V -0.7V - 2.2V) / 20mA = 455 Ohm.  \nPick 1.5K Ohm (E12, BOM reuse).
Text Notes 7700 4650 0    39   ~ 0
MOIST+ and MOIST- are normally tristate.\nWhen measuring + is driven high and - is driven low causing a current to flow through\nR6 and the soil (two electrodes connected between pin 2 and 3 of P2). Then the polarity\nis reversed to counteract electron migration on the electrodes.\nThe voltage at the divider is measured using ADC. \nR6 is chosen based on earlier experiments for the designed target soil. \n\nBetween pins 5 and 6 of P2 are two electrodes that short if the pot overflows with water.\nR5 forms a series resistance with the electrodes and is weakly pulled high.  The value for\nR5 is chosen based on measured resistance of tap water with large electrodes.\nThe resistance measured was around 2k for 3cm galvanized screws submerged\nin water. The expected voltage on INT0 when in water is 0.02*Vcc. Internal pull-up\nmust be disabled. An IRQ will trigger up to 72k resistance between the probes. \n(ATmega has 2.6V input threshold on pins and .5V hysteresis)\n\n\nR12 likewise forms a voltage divider but with a thermistor, the datasheet suggest a \n5k11 series resistor to linearise the thermistor. We use THERM+ to drive the divider\nwhen we want to measure. Otherwise THERM+ is tristate. 5V/5K = 1mA which the GPIO\npin can easily drive.
Text Notes 4750 6400 0    39   ~ 0
Red LED (2.2V , 20mA, 40mcd): We want 8mcd brightness:\n(5V - 2.2V) / (20mA * 8mcd/40mcd) = 700 Ohm.\nPick 1K5 Ohm (E12) for bom reuse.
$Comp
L D D?
U 1 1 5B018124
P 3700 2750
F 0 "D?" H 3700 2850 50  0000 C CNN
F 1 "D" H 3700 2650 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 3700 2750 50  0001 C CNN
F 3 "" H 3700 2750 50  0000 C CNN
	1    3700 2750
	-1   0    0    1   
$EndComp
$Comp
L CP C?
U 1 1 5B018125
P 3900 2950
F 0 "C?" H 3925 3050 50  0000 L CNN
F 1 "100µF" H 3650 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3938 2800 50  0001 C CNN
F 3 "" H 3900 2950 50  0000 C CNN
	1    3900 2950
	1    0    0    -1  
$EndComp
$Comp
L CP C?
U 1 1 5B018126
P 3500 2950
F 0 "C?" H 3525 3050 50  0000 L CNN
F 1 "100µF" H 3250 2850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3538 2800 50  0001 C CNN
F 3 "" H 3500 2950 50  0000 C CNN
	1    3500 2950
	1    0    0    -1  
$EndComp
Text Label 3700 1400 0    47   ~ 0
PUMP+
Text GLabel 6650 4350 3    39   Input ~ 0
~OVRFLW
$Comp
L PWR_FLAG #FLG?
U 1 1 5B018127
P 1950 4300
F 0 "#FLG?" H 1950 4395 50  0001 C CNN
F 1 "PWR_FLAG" H 1950 4480 50  0000 C CNN
F 2 "" H 1950 4300 50  0000 C CNN
F 3 "" H 1950 4300 50  0000 C CNN
	1    1950 4300
	-1   0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B018128
P 3700 3200
F 0 "R?" V 3780 3200 50  0000 C CNN
F 1 "0" V 3700 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_2010" V 3630 3200 50  0001 C CNN
F 3 "" H 3700 3200 50  0000 C CNN
	1    3700 3200
	0    1    1    0   
$EndComp
Text Label 2900 2100 2    60   ~ 0
COIL_PWR
Text Notes 1200 3950 0    39   ~ 0
AVcc LC circuit taken from AVR datasheet.
$Comp
L R R?
U 1 1 5B018129
P 5100 3000
F 0 "R?" V 5200 3000 50  0000 C CNN
F 1 "1K5" V 5100 3000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5030 3000 50  0001 C CNN
F 3 "" H 5100 3000 50  0000 C CNN
	1    5100 3000
	0    1    -1   0   
$EndComp
$Comp
L C C?
U 1 1 5B01812A
P 4200 2950
F 0 "C?" H 4225 3050 50  0000 L CNN
F 1 "100nF" H 4225 2850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4238 2800 50  0001 C CNN
F 3 "" H 4200 2950 50  0000 C CNN
	1    4200 2950
	1    0    0    -1  
$EndComp
$Comp
L FINDER-32.21-x300 RL?
U 1 1 5B01812B
P 3300 1800
F 0 "RL?" H 3550 1800 50  0000 L CNN
F 1 "FINDER-32.21-x300" V 3350 1450 50  0000 L CNN
F 2 "Relays_THT:Relay_SPST_Finder_32.21-x300" H 3300 1800 50  0001 C CNN
F 3 "" H 3300 1800 50  0000 C CNN
	1    3300 1800
	1    0    0    -1  
$EndComp
Text Notes 2450 2250 0    60   ~ 0
40mA @ 5V
Text Notes 8000 2700 0    39   ~ 0
5V Load Summary:\n - MCU: 1MHz@5V (internal RC)  < 1mA active \n - Moisture probe: 5V/10KR = 500µA (when shorted)\n - Overflow sensor: 5V/100KR = 50µA (when shorted)\n - Level alert:  50µA when active (pullup from ground)\n - Thermal probe 1mA (when shorted)\n - Pump relay 40mA (nominal)\n - MIC94090 20µA\n - Pump LED max 2mA.\n - RX/TX should be low but max 40mA total\n - RX/TX LED max 40mA total. \n\nTotal MAX: < 140 mA (without extension ports)\n - Typical Sleep: <  100µA\n - Typical Active: < 70 mA\n - Typical Duty Cycle: 0.13% \n\nThermal dissipation LM7805:\n - Max: (12- 0.6 - 5) *0.140 = 896mW\n - Typical Sleep: (12- 0.6 - 5) *0.0001 = 0.64mW\n - Typical Active: (12- 0.6 - 5) *0.070 = 448mW \n - Average expected: 0.0013*448  + 0.9987 *0.64 = 1.2 mW \n - TO220 package safe dissipation without heat sink 1W.\n
Text GLabel 1650 2600 3    39   Input ~ 0
MISO
Text GLabel 1750 2600 3    39   Input ~ 0
SCK
Text GLabel 1850 2600 3    39   Input ~ 0
~RESET
Text GLabel 1750 2100 1    39   Input ~ 0
MOSI
$Comp
L GND #PWR?
U 1 1 5B01812C
P 1850 2100
F 0 "#PWR?" H 1850 1850 50  0001 C CNN
F 1 "GND" H 1850 1950 50  0000 C CNN
F 2 "" H 1850 2100 50  0000 C CNN
F 3 "" H 1850 2100 50  0000 C CNN
	1    1850 2100
	0    -1   -1   0   
$EndComp
Text GLabel 4250 4400 2    39   Input ~ 0
MISO
Text GLabel 4250 4500 2    39   Input ~ 0
SCK
Text GLabel 4250 4300 2    39   Input ~ 0
MOSI
$Comp
L INDUCTOR_SMALL L?
U 1 1 5B01812D
P 1600 4300
F 0 "L?" H 1600 4400 50  0000 C CNN
F 1 "10µH" H 1600 4250 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 1600 4300 50  0001 C CNN
F 3 "" H 1600 4300 50  0000 C CNN
	1    1600 4300
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B01812E
P 1950 4550
F 0 "C?" H 1975 4650 50  0000 L CNN
F 1 "100nF" V 2100 4300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1988 4400 50  0001 C CNN
F 3 "" H 1950 4550 50  0000 C CNN
	1    1950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B01812F
P 5650 3200
F 0 "#PWR?" H 5650 2950 50  0001 C CNN
F 1 "GND" H 5650 3050 50  0000 C CNN
F 2 "" H 5650 3200 50  0000 C CNN
F 3 "" H 5650 3200 50  0000 C CNN
	1    5650 3200
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B018130
P 6750 5200
F 0 "R?" V 6830 5200 50  0000 C CNN
F 1 "4K7" V 6750 5200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6680 5200 50  0001 C CNN
F 3 "" H 6750 5200 50  0000 C CNN
	1    6750 5200
	1    0    0    1   
$EndComp
$Comp
L C C?
U 1 1 5B018131
P 6750 5700
F 0 "C?" H 6775 5800 50  0000 L CNN
F 1 "100nF" H 6775 5600 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6788 5550 50  0001 C CNN
F 3 "" H 6750 5700 50  0000 C CNN
	1    6750 5700
	-1   0    0    -1  
$EndComp
Text GLabel 6300 5450 1    39   Input ~ 0
~RESET
Text GLabel 4250 5150 2    39   Input ~ 0
~LEVEL_ALERT
$Comp
L D_Schottky D?
U 1 1 5B018132
P 6500 5200
F 0 "D?" H 6500 5300 50  0000 C CNN
F 1 "D_Schottky" H 6500 5100 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 6500 5200 50  0001 C CNN
F 3 "" H 6500 5200 50  0001 C CNN
	1    6500 5200
	0    -1   1    0   
$EndComp
Text GLabel 6750 4950 1    47   Input ~ 0
Vcc
$Comp
L R R?
U 1 1 5B018133
P 7000 5450
F 0 "R?" V 7080 5450 50  0000 C CNN
F 1 "150" V 7000 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6930 5450 50  0001 C CNN
F 3 "" H 7000 5450 50  0000 C CNN
	1    7000 5450
	0    1    -1   0   
$EndComp
$Comp
L D_Schottky D?
U 1 1 5B018134
P 2700 1800
F 0 "D?" H 2700 1900 50  0000 C CNN
F 1 "D_Schottky" H 2700 1700 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 2700 1800 50  0001 C CNN
F 3 "" H 2700 1800 50  0001 C CNN
	1    2700 1800
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 5B018135
P 7350 5450
F 0 "R?" V 7430 5450 50  0000 C CNN
F 1 "150" V 7350 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7280 5450 50  0001 C CNN
F 3 "" H 7350 5450 50  0000 C CNN
	1    7350 5450
	0    1    -1   0   
$EndComp
Text GLabel 5050 1100 2    39   Input ~ 0
~LEVEL_ALERT
Text Notes 4950 1150 2    39   ~ 0
Level alert is debounced\nin software.
Text Notes 7850 5200 2    39   ~ 0
Recommended reset circuit\nfrom AVR HW considerations.
$Comp
L C C?
U 1 1 5B018136
P 1100 1550
F 0 "C?" H 1125 1650 50  0000 L CNN
F 1 "100nF" V 950 1450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1138 1400 50  0001 C CNN
F 3 "" H 1100 1550 50  0000 C CNN
	1    1100 1550
	1    0    0    -1  
$EndComp
$Comp
L ATMEGA168-20AU U?
U 1 1 5B018137
P 3250 5100
F 0 "U?" H 2500 6350 50  0000 L BNN
F 1 "ATMEGA168-20AU" H 3700 3700 50  0000 L BNN
F 2 "Housings_QFP:TQFP-32_7x7mm_Pitch0.8mm" H 3250 5100 50  0001 C CIN
F 3 "" H 3250 5100 50  0001 C CNN
	1    3250 5100
	1    0    0    -1  
$EndComp
Text GLabel 2350 4300 3    47   Input ~ 0
AVcc
$Comp
L C C?
U 1 1 5B018138
P 1500 5150
F 0 "C?" H 1525 5250 50  0000 L CNN
F 1 "100nF" V 1350 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1538 5000 50  0001 C CNN
F 3 "" H 1500 5150 50  0000 C CNN
	1    1500 5150
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5B018139
P 1150 5150
F 0 "C?" H 1175 5250 50  0000 L CNN
F 1 "100nF" V 1000 5050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1188 5000 50  0001 C CNN
F 3 "" H 1150 5150 50  0000 C CNN
	1    1150 5150
	1    0    0    -1  
$EndComp
Text GLabel 1050 4000 0    47   Input ~ 0
Vcc
Text GLabel 4250 4950 2    39   Input ~ 0
MOIST+
Text GLabel 4250 4850 2    39   Input ~ 0
MOIST-
Text GLabel 2350 5350 0    39   Input ~ 0
MOISTURE
Text GLabel 6450 3950 1    39   Input ~ 0
MOIST+
Text GLabel 7200 4050 0    39   Input ~ 0
MOIST-
Text GLabel 6650 4250 1    39   Input ~ 0
THERM
Text GLabel 4250 4000 2    39   Input ~ 0
EXT_D0
Text GLabel 4250 4100 2    39   Input ~ 0
EXT_D1
Text GLabel 1550 2600 3    39   Input ~ 0
EXT_D7
$Comp
L C C?
U 1 1 5B01813A
P 2300 4800
F 0 "C?" H 2325 4900 50  0000 L CNN
F 1 "10nF" V 2400 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2338 4650 50  0001 C CNN
F 3 "" H 2300 4800 50  0000 C CNN
	1    2300 4800
	1    0    0    -1  
$EndComp
Text GLabel 1350 2100 1    39   Input ~ 0
EXT_D0
Text GLabel 1450 2100 1    39   Input ~ 0
EXT_D1
Text GLabel 4250 4200 2    39   Input ~ 0
EXT_D2
Text GLabel 1650 2100 1    47   Input ~ 0
Vcc
$Comp
L D_Schottky_AKA D?
U 1 1 5B01813B
P 4000 1750
F 0 "D?" H 4000 1850 50  0000 C CNN
F 1 "D_Schottky_AKA" H 4000 1650 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 4000 1750 50  0001 C CNN
F 3 "" H 4000 1750 50  0001 C CNN
	1    4000 1750
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 5B01813C
P 6500 4250
F 0 "R?" V 6400 4250 50  0000 C CNN
F 1 "5K11" V 6500 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6430 4250 50  0001 C CNN
F 3 "" H 6500 4250 50  0000 C CNN
	1    6500 4250
	0    1    1    0   
$EndComp
Text GLabel 6350 4250 0    39   Input ~ 0
THERM+
$Comp
L CONN_01X06 P?
U 1 1 5B01813D
P 7400 4200
F 0 "P?" H 7400 4550 50  0000 C CNN
F 1 "PLANT" V 7500 4200 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S6B-PH-K_06x2.00mm_Angled" H 7400 4200 50  0001 C CNN
F 3 "" H 7400 4200 50  0000 C CNN
	1    7400 4200
	1    0    0    -1  
$EndComp
Text GLabel 2350 5450 0    39   Input ~ 0
THERM
Text GLabel 4250 5050 2    39   Input ~ 0
THERM+
Text GLabel 1450 2600 3    39   Input ~ 0
EXT_D6
Text GLabel 6350 4350 0    47   Input ~ 0
AVcc
$Comp
L GND #PWR?
U 1 1 5B01813E
P 1500 6300
F 0 "#PWR?" H 1500 6050 50  0001 C CNN
F 1 "GND" H 1500 6150 50  0000 C CNN
F 2 "" H 1500 6300 50  0000 C CNN
F 3 "" H 1500 6300 50  0000 C CNN
	1    1500 6300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B01813F
P 7200 4450
F 0 "#PWR?" H 7200 4200 50  0001 C CNN
F 1 "GND" H 7200 4300 50  0000 C CNN
F 2 "" H 7200 4450 50  0000 C CNN
F 3 "" H 7200 4450 50  0000 C CNN
	1    7200 4450
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG?
U 1 1 5B018140
P 2300 6750
F 0 "#FLG?" H 2300 6845 50  0001 C CNN
F 1 "PWR_FLAG" H 2300 6930 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B018141
P 2300 6750
F 0 "#PWR?" H 2300 6500 50  0001 C CNN
F 1 "GND" H 2300 6600 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
Text GLabel 1550 2100 1    39   Input ~ 0
EXT_D2
Text GLabel 4250 4600 2    39   Input ~ 0
EXT_D6
Text GLabel 4250 4700 2    39   Input ~ 0
EXT_D7
$Comp
L GND #PWR?
U 1 1 5B018142
P 7200 3950
F 0 "#PWR?" H 7200 3700 50  0001 C CNN
F 1 "GND" V 7200 3750 50  0000 C CNN
F 2 "" H 7200 3950 50  0000 C CNN
F 3 "" H 7200 3950 50  0000 C CNN
	1    7200 3950
	0    1    -1   0   
$EndComp
$Comp
L FUSE F?
U 1 1 5B018143
P 3200 2750
F 0 "F?" H 3300 2800 50  0000 C CNN
F 1 "FUSE" H 3100 2700 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_SMD2920" H 3200 2750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2038617.pdf" H 3200 2750 50  0001 C CNN
	1    3200 2750
	1    0    0    -1  
$EndComp
Text Label 4400 5350 0    39   ~ 0
TX_LED
Text Label 4400 5250 0    39   ~ 0
RX_LED
Text Label 4400 5600 0    39   ~ 0
RX
Text Label 4400 5700 0    39   ~ 0
TX
Text Notes 1650 1150 0    39   ~ 0
IC Max 20 µA \nNominal 40mA from relay
Text Label 3500 2400 1    39   ~ 0
+12V
Text Label 3350 3200 3    39   ~ 0
PGND
Text Notes 950  5500 1    39   ~ 0
C7 near pins 4 and 3
Text Notes 1700 5500 1    39   ~ 0
C9 near pins 5 and 6
Connection ~ 6150 2750
Connection ~ 2950 2950
Wire Wire Line
	5850 4950 5850 5250
Wire Wire Line
	6150 2450 6150 2800
Wire Wire Line
	5650 3200 5650 3050
Connection ~ 3900 2750
Wire Wire Line
	2950 2850 2950 3200
Wire Wire Line
	3900 2800 3900 2750
Wire Wire Line
	3900 3100 3900 3200
Wire Wire Line
	3500 2100 3500 2800
Connection ~ 3500 2750
Wire Wire Line
	3500 3200 3500 3100
Connection ~ 4200 2750
Wire Wire Line
	4200 2750 4200 2800
Wire Wire Line
	4200 3200 4200 3100
Wire Wire Line
	6150 3200 6150 3100
Wire Wire Line
	3850 2750 5250 2750
Connection ~ 4200 3200
Wire Wire Line
	6500 4950 6500 5050
Connection ~ 6750 4950
Wire Wire Line
	6500 5450 6500 5350
Wire Wire Line
	6750 5350 6750 5550
Connection ~ 6750 5450
Wire Wire Line
	7200 5450 7150 5450
Wire Wire Line
	1100 1400 1550 1400
Wire Wire Line
	1100 1700 1100 1750
Wire Wire Line
	6750 4950 6750 5050
Wire Wire Line
	5850 4950 6750 4950
Wire Wire Line
	4250 5450 6850 5450
Wire Wire Line
	6150 2750 6050 2750
Wire Wire Line
	3850 3200 6150 3200
Wire Wire Line
	6650 4250 7200 4250
Wire Wire Line
	6650 4350 7200 4350
Wire Wire Line
	6750 3950 6750 4150
Wire Wire Line
	6750 4150 7200 4150
Connection ~ 6500 5450
Wire Wire Line
	4250 5350 5150 5350
Wire Wire Line
	5150 5350 5150 5250
Wire Wire Line
	5150 4950 5050 4950
Wire Wire Line
	5050 4950 5050 5250
Wire Wire Line
	5050 5250 4250 5250
Connection ~ 6500 4950
Wire Wire Line
	8100 6050 8100 5450
Wire Wire Line
	5700 6050 8100 6050
Wire Wire Line
	6750 6050 6750 5850
Wire Wire Line
	5700 6050 5700 5900
Connection ~ 6750 6050
Wire Wire Line
	4250 5600 5350 5600
Wire Wire Line
	5350 5600 5350 5700
Wire Wire Line
	5350 5700 5700 5700
Wire Wire Line
	5700 5800 5250 5800
Wire Wire Line
	5250 5800 5250 5700
Wire Wire Line
	5250 5700 4250 5700
Wire Wire Line
	2400 1500 3100 1500
Wire Wire Line
	2700 1650 2700 1500
Connection ~ 2700 1500
Wire Wire Line
	2400 1600 2400 2100
Wire Wire Line
	2400 2100 3100 2100
Wire Wire Line
	2700 1950 2700 2100
Connection ~ 2700 2100
Wire Wire Line
	4250 6000 4750 6000
Wire Wire Line
	4750 6000 4750 6050
Wire Wire Line
	4750 6050 5000 6050
Wire Wire Line
	1100 1700 1250 1700
Wire Wire Line
	1550 1500 1250 1500
Wire Wire Line
	1250 1500 1250 1700
Wire Wire Line
	3600 1500 3600 1400
Wire Wire Line
	3600 1400 4400 1400
Wire Wire Line
	4000 1400 4000 1600
Wire Wire Line
	4000 1950 4000 2200
Connection ~ 4000 2200
Wire Wire Line
	4100 2200 4100 1950
Connection ~ 4100 2200
Wire Wire Line
	4400 1400 4400 1550
Connection ~ 4000 1400
Wire Wire Line
	3200 2200 5050 2200
Wire Wire Line
	3450 2750 3550 2750
Wire Wire Line
	2950 3200 3550 3200
Connection ~ 3500 3200
Connection ~ 3900 3200
Wire Wire Line
	3200 2200 3200 3200
Connection ~ 3200 3200
Wire Wire Line
	4550 3000 4550 3200
Connection ~ 4550 3200
Connection ~ 5650 3200
Wire Wire Line
	2300 4650 2300 4600
Wire Wire Line
	2300 4600 2350 4600
Wire Wire Line
	1950 4950 2300 4950
Wire Wire Line
	1950 6300 1950 4700
Wire Wire Line
	1850 4300 2350 4300
Wire Wire Line
	1950 4300 1950 4400
Connection ~ 1950 4300
Wire Wire Line
	1050 4000 2350 4000
Wire Wire Line
	2350 4000 2350 4100
Connection ~ 1350 4000
Wire Wire Line
	2350 6300 2350 6100
Connection ~ 2350 6200
Wire Wire Line
	1150 6300 2350 6300
Connection ~ 1150 4000
Wire Wire Line
	1500 5000 1500 4800
Wire Wire Line
	1500 4800 1150 4800
Connection ~ 1150 4800
Wire Wire Line
	1150 6300 1150 5300
Wire Wire Line
	1500 5300 1500 6300
Connection ~ 1500 6300
Wire Wire Line
	1350 4300 1350 4000
Wire Wire Line
	1150 4000 1150 5000
Connection ~ 1950 6300
Connection ~ 1950 4950
Text Label 4500 2750 0    39   ~ 0
REG_PWR
Text GLabel 5050 800  0    47   Input ~ 0
Vcc
Wire Wire Line
	4500 1400 4500 1550
Text Notes 5550 1600 0    39   ~ 0
Failure analysis P1:\nPin:  ~LEVEL_ALERT:\n - May short to GND or PGND, both are equivalent to\n   level alert triggering normally.\n - May short to +12V.  Diode becomes reverse biased\n   and level_alert goes to 5V. \n\nPin: 12V\n - May short to PGND, fuse will trip.\n - May short to GND, fuse will trip. May damage traces \n   and zero ohm resistor between GND and PGND.\nPin: PGND\n - May short to GND. Harmless. 
Text Notes 6300 2500 0    39   ~ 0
Vcc = 5 ±0.36V
$Comp
L R R?
U 1 1 5B018144
P 5050 950
F 0 "R?" V 5130 950 50  0000 C CNN
F 1 "10K" V 5050 950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 950 50  0001 C CNN
F 3 "" H 5050 950 50  0000 C CNN
	1    5050 950 
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5B018145
P 5050 1550
F 0 "R?" V 5130 1550 50  0000 C CNN
F 1 "10K" V 5050 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4980 1550 50  0001 C CNN
F 3 "" H 5050 1550 50  0000 C CNN
	1    5050 1550
	1    0    0    -1  
$EndComp
$Comp
L D D?
U 1 1 5B018146
P 5050 1250
F 0 "D?" H 5050 1350 50  0000 C CNN
F 1 "D" H 5050 1150 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 5050 1250 50  0001 C CNN
F 3 "" H 5050 1250 50  0000 C CNN
	1    5050 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4500 1400 5050 1400
Wire Wire Line
	5050 2200 5050 1700
$Comp
L CONN_01X04 P?
U 1 1 5B018147
P 4950 7200
F 0 "P?" H 4950 7450 50  0000 C CNN
F 1 "CONN_01X04" V 5050 7200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x02_Pitch2.54mm" H 4950 7200 50  0001 C CNN
F 3 "" H 4950 7200 50  0000 C CNN
	1    4950 7200
	1    0    0    -1  
$EndComp
Text GLabel 4750 7050 0    39   Input ~ 0
SHORT_LED
Text GLabel 4750 7250 0    39   Input ~ 0
LEVEL_LED
Text GLabel 4750 7150 0    39   Input ~ 0
BUZZER
$Comp
L GND #PWR?
U 1 1 5B018148
P 4750 7350
F 0 "#PWR?" H 4750 7100 50  0001 C CNN
F 1 "GND" H 4750 7200 50  0000 C CNN
F 2 "" H 4750 7350 50  0000 C CNN
F 3 "" H 4750 7350 50  0000 C CNN
	1    4750 7350
	1    0    0    -1  
$EndComp
Text GLabel 4250 6100 2    39   Input ~ 0
SHORT_LED
Text GLabel 4250 6200 2    39   Input ~ 0
LEVEL_LED
Text GLabel 4250 6300 2    39   Input ~ 0
BUZZER
$Comp
L CONN_01X03 P?
U 1 1 5B018149
P 5700 6800
F 0 "P?" H 5700 7000 50  0000 C CNN
F 1 "CONN_01X03" V 5800 6800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5700 6800 50  0001 C CNN
F 3 "" H 5700 6800 50  0000 C CNN
	1    5700 6800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B01814A
P 5500 6900
F 0 "#PWR?" H 5500 6650 50  0001 C CNN
F 1 "GND" H 5500 6750 50  0000 C CNN
F 2 "" H 5500 6900 50  0000 C CNN
F 3 "" H 5500 6900 50  0000 C CNN
	1    5500 6900
	1    0    0    -1  
$EndComp
Text GLabel 5500 6700 0    47   Input ~ 0
Vcc
Text GLabel 4250 5900 2    39   Input ~ 0
INT1
Text GLabel 5500 6800 0    39   Input ~ 0
INT1
Wire Wire Line
	4500 2200 4500 2050
Wire Wire Line
	4400 2200 4400 2050
Connection ~ 4400 2200
Connection ~ 4500 2200
Text GLabel 1350 2600 3    39   Input ~ 0
Vcc
$Comp
L CONN_02X06 P?
U 1 1 5B01814B
P 1600 2350
F 0 "P?" H 1600 2700 50  0000 C CNN
F 1 "CONN_02X06" H 1600 2000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x06_Pitch2.54mm" H 1600 1150 50  0001 C CNN
F 3 "" H 1600 1150 50  0000 C CNN
	1    1600 2350
	0    1    1    0   
$EndComp
Text Label 2950 2750 1    39   ~ 0
PWR
Text Notes 3450 3400 0    60   ~ 0
750mW max
$Comp
L D D?
U 1 1 5B01814C
P 5600 2450
F 0 "D?" H 5600 2550 50  0000 C CNN
F 1 "D" H 5600 2350 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 5600 2450 50  0001 C CNN
F 3 "" H 5600 2450 50  0000 C CNN
	1    5600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 2450 5750 2450
Text Notes 5200 2200 0    39   ~ 0
Reverse bias protection diode. Also makes sure the \nelectrolytes have a well defined voltage over them.\nAnd that the PWR_LED illuminates (very weakly) when \nprogramming the device.
Wire Wire Line
	3500 2450 5450 2450
$Comp
L LM7805CT U?
U 1 1 5B01814D
P 5650 2800
F 0 "U?" H 5450 3000 50  0000 C CNN
F 1 "LM7805CT" H 5650 3000 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 5650 2900 50  0001 C CIN
F 3 "http://www.farnell.com/datasheets/2303956.pdf" H 5650 2800 50  0001 C CNN
	1    5650 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2750 5250 3000
Connection ~ 3500 2450
Text Notes 3600 2450 0    39   ~ 0
5A max peak. 3A max sustain Trip: 5s@8A 
NoConn ~ 6550 1900
NoConn ~ 6050 2000
$EndSCHEMATC
