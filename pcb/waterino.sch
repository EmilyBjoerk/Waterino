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
LIBS:uart_header
LIBS:mic94090
LIBS:max6817
LIBS:relays
LIBS:waterino-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R6
U 1 1 59272E25
P 6400 3650
F 0 "R6" V 6500 3650 50  0000 C CNN
F 1 "10K" V 6400 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6330 3650 50  0001 C CNN
F 3 "" H 6400 3650 50  0000 C CNN
	1    6400 3650
	0    -1   -1   0   
$EndComp
Text GLabel 6550 3650 1    39   Input ~ 0
MOISTURE
$Comp
L R R5
U 1 1 59273B85
P 6300 4050
F 0 "R5" V 6380 4050 50  0000 C CNN
F 1 "100K" V 6300 4050 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6230 4050 50  0001 C CNN
F 3 "" H 6300 4050 50  0000 C CNN
	1    6300 4050
	0    1    1    0   
$EndComp
$Comp
L MIC94090 U2
U 1 1 59275684
P 2200 850
F 0 "U2" H 2650 1450 47  0000 C CNN
F 1 "MIC94090" H 2650 950 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 2100 850 47  0001 C CNN
F 3 "" H 2100 850 47  0001 C CNN
	1    2200 850 
	-1   0    0    1   
$EndComp
NoConn ~ 2200 1100
Text GLabel 1350 1300 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON1
U 1 1 59277B44
P 2450 2550
F 0 "CON1" H 2450 2800 50  0000 C CNN
F 1 "POWER" H 2450 2350 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 2450 2550 50  0001 C CNN
F 3 "" H 2450 2550 50  0000 C CNN
	1    2450 2550
	1    0    0    -1  
$EndComp
$Comp
L LM7805CT U1
U 1 1 59277F88
P 5450 2500
F 0 "U1" H 5250 2700 50  0000 C CNN
F 1 "LM7805CT" H 5450 2700 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 5450 2600 50  0001 C CIN
F 3 "http://www.farnell.com/datasheets/2303956.pdf" H 5450 2500 50  0001 C CNN
	1    5450 2500
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 592799BC
P 5950 2650
F 0 "C4" H 5975 2750 50  0000 L CNN
F 1 "100nF" V 5750 2550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5988 2500 50  0001 C CNN
F 3 "" H 5950 2650 50  0000 C CNN
	1    5950 2650
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-waterino D8
U 1 1 5927A727
P 4550 2700
F 0 "D8" H 4550 2850 50  0000 C CNN
F 1 "PWR_LED" H 4550 2600 50  0000 C CNN
F 2 "LEDs:LED_0603" H 4550 2700 50  0001 C CNN
F 3 "" H 4550 2700 50  0000 C CNN
	1    4550 2700
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5927C419
P 4950 5750
F 0 "R1" V 5030 5750 50  0000 C CNN
F 1 "1.5K" V 4950 5750 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4880 5750 50  0001 C CNN
F 3 "" H 4950 5750 50  0000 C CNN
	1    4950 5750
	0    -1   -1   0   
$EndComp
$Comp
L LED-RESCUE-waterino D4
U 1 1 5927C47E
P 5300 5750
F 0 "D4" H 5300 5850 50  0000 C CNN
F 1 "PUMP_LED" H 5600 5850 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5300 5750 50  0001 C CNN
F 3 "" H 5300 5750 50  0000 C CNN
	1    5300 5750
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 59281429
P 7600 5150
F 0 "SW1" H 7750 5260 50  0000 C CNN
F 1 "RESET" H 7600 5070 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 7600 5150 50  0001 C CNN
F 3 "" H 7600 5150 50  0000 C CNN
	1    7600 5150
	-1   0    0    -1  
$EndComp
Text GLabel 4700 5750 1    39   Input ~ 0
PUMP
$Comp
L GND #PWR01
U 1 1 592B0B84
P 6550 5750
F 0 "#PWR01" H 6550 5500 50  0001 C CNN
F 1 "GND" H 6550 5600 50  0000 C CNN
F 2 "" H 6550 5750 50  0000 C CNN
F 3 "" H 6550 5750 50  0000 C CNN
	1    6550 5750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59277F1D
P 900 1450
F 0 "#PWR02" H 900 1200 50  0001 C CNN
F 1 "GND" H 900 1300 50  0000 C CNN
F 2 "" H 900 1450 50  0000 C CNN
F 3 "" H 900 1450 50  0000 C CNN
	1    900  1450
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P3
U 1 1 5928A55A
P 5700 5450
F 0 "P3" H 5700 5700 50  0000 C CNN
F 1 "UART" V 5800 5450 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5700 5450 50  0001 C CNN
F 3 "" H 5700 5450 50  0000 C CNN
	1    5700 5450
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5928C863
P 5500 4950
F 0 "R8" V 5580 4950 50  0000 C CNN
F 1 "150" V 5500 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5430 4950 50  0001 C CNN
F 3 "" H 5500 4950 50  0000 C CNN
	1    5500 4950
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-waterino D7
U 1 1 5928C9A7
P 5150 4950
F 0 "D7" H 5150 5050 50  0000 C CNN
F 1 "TX_LED" H 5150 4850 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5150 4950 50  0001 C CNN
F 3 "" H 5150 4950 50  0000 C CNN
	1    5150 4950
	1    0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D6
U 1 1 5928CC0E
P 5150 4650
F 0 "D6" H 5150 4750 50  0000 C CNN
F 1 "RX_LED" H 5150 4550 50  0000 C CNN
F 2 "LEDs:LED_0603" H 5150 4650 50  0001 C CNN
F 3 "" H 5150 4650 50  0000 C CNN
	1    5150 4650
	1    0    0    1   
$EndComp
$Comp
L R R7
U 1 1 5928CCC0
P 5500 4650
F 0 "R7" V 5580 4650 50  0000 C CNN
F 1 "150" V 5500 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5430 4650 50  0001 C CNN
F 3 "" H 5500 4650 50  0000 C CNN
	1    5500 4650
	0    1    1    0   
$EndComp
$Comp
L CONN_02X02 P1
U 1 1 5929A575
P 4250 1500
F 0 "P1" H 4250 1650 50  0000 C CNN
F 1 "PUMP" H 4250 1350 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 4250 300 50  0001 C CNN
F 3 "" H 4250 300 50  0000 C CNN
	1    4250 1500
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 592A0DF0
P 2500 1200
F 0 "#PWR03" H 2500 950 50  0001 C CNN
F 1 "GND" H 2500 1050 50  0000 C CNN
F 2 "" H 2500 1200 50  0000 C CNN
F 3 "" H 2500 1200 50  0000 C CNN
	1    2500 1200
	1    0    0    1   
$EndComp
Text GLabel 4050 5500 2    39   Input ~ 0
~OVRFLW
Text GLabel 5950 2450 1    47   Input ~ 0
Vcc
Text GLabel 5500 5300 0    47   Input ~ 0
Vcc
Text GLabel 900  1100 1    47   Input ~ 0
Vcc
Text Notes 4800 4500 0    39   ~ 0
Yellow LED (2.1V, 20mA, 8mcd): \n(5V - 2.1V) / 20mA = 145 Ohm.\nPick 150 Ohm (E12)
Text Notes 4050 3250 0    39   ~ 0
Green LED (2.2V, 20mA, 15mcd): \nWe want 8mcd brightness: \n(12V -0.7V - 2.2V) / (20mA * 8mcd/15mcd) = 853 Ohm.  \nPick 1.5K Ohm (E12, BOM reuse).
Text Notes 7500 4350 0    39   ~ 0
MOIST+ and MOIST- are normally tristate.\nWhen measuring + is driven high and - is driven low causing a current to flow through\nR6 and the soil (two electrodes connected between pin 2 and 3 of P2). Then the polarity\nis reversed to counteract electron migration on the electrodes.\nThe voltage at the divider is measured using ADC. \nR6 is chosen based on earlier experiments for the designed target soil. \n\nBetween pins 5 and 6 of P2 are two electrodes that short if the pot overflows with water.\nR5 forms a series resistance with the electrodes and is weakly pulled high.  The value for\nR5 is chosen based on measured resistance of tap water with large electrodes.\nThe resistance measured was around 2k for 3cm galvanized screws submerged\nin water. The expected voltage on INT0 when in water is 0.02*Vcc. Internal pull-up\nmust be disabled. An IRQ will trigger up to 72k resistance between the probes. \n(ATmega has 2.6V input threshold on pins and .5V hysteresis)\n\n\nR12 likewise forms a voltage divider but with a thermistor, the datasheet suggest a \n5k11 series resistor to linearise the thermistor. We use THERM+ to drive the divider\nwhen we want to measure. Otherwise THERM+ is tristate. 5V/5K = 1mA which the GPIO\npin can easily drive.
Text Notes 4550 6100 0    39   ~ 0
Red LED (1.85V , 20mA, 80mcd): We want 8mcd brightness:\n(5V - 1.85V) / (20mA * 8mcd/80mcd) = 1575 Ohm.\nPick 1.5K Ohm (E12).
$Comp
L D D1
U 1 1 59321D7A
P 3500 2450
F 0 "D1" H 3500 2550 50  0000 C CNN
F 1 "D" H 3500 2350 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 3500 2450 50  0001 C CNN
F 3 "" H 3500 2450 50  0000 C CNN
	1    3500 2450
	-1   0    0    1   
$EndComp
$Comp
L CP C2
U 1 1 59323AB3
P 3700 2650
F 0 "C2" H 3725 2750 50  0000 L CNN
F 1 "100µF" H 3450 2550 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3738 2500 50  0001 C CNN
F 3 "" H 3700 2650 50  0000 C CNN
	1    3700 2650
	1    0    0    -1  
$EndComp
$Comp
L CP C1
U 1 1 5932A26F
P 3300 2650
F 0 "C1" H 3325 2750 50  0000 L CNN
F 1 "100µF" H 3050 2550 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 3338 2500 50  0001 C CNN
F 3 "" H 3300 2650 50  0000 C CNN
	1    3300 2650
	1    0    0    -1  
$EndComp
Text Label 3500 1100 0    47   ~ 0
PUMP+
Text GLabel 6450 4050 3    39   Input ~ 0
~OVRFLW
$Comp
L PWR_FLAG #FLG04
U 1 1 59302DDD
P 1750 4000
F 0 "#FLG04" H 1750 4095 50  0001 C CNN
F 1 "PWR_FLAG" H 1750 4180 50  0000 C CNN
F 2 "" H 1750 4000 50  0000 C CNN
F 3 "" H 1750 4000 50  0000 C CNN
	1    1750 4000
	-1   0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 5930E0B4
P 3500 2900
F 0 "R9" V 3580 2900 50  0000 C CNN
F 1 "0" V 3500 2900 50  0000 C CNN
F 2 "Resistors_SMD:R_2010" V 3430 2900 50  0001 C CNN
F 3 "" H 3500 2900 50  0000 C CNN
	1    3500 2900
	0    1    1    0   
$EndComp
Text Label 2700 1800 2    60   ~ 0
COIL_PWR
Text Notes 1000 3650 0    39   ~ 0
AVcc LC circuit taken from AVR datasheet.
$Comp
L R R11
U 1 1 593391B6
P 4900 2700
F 0 "R11" V 5000 2700 50  0000 C CNN
F 1 "1.5K" V 4900 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4830 2700 50  0001 C CNN
F 3 "" H 4900 2700 50  0000 C CNN
	1    4900 2700
	0    1    -1   0   
$EndComp
$Comp
L C C3
U 1 1 59347036
P 4000 2650
F 0 "C3" H 4025 2750 50  0000 L CNN
F 1 "100nF" H 4025 2550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4038 2500 50  0001 C CNN
F 3 "" H 4000 2650 50  0000 C CNN
	1    4000 2650
	1    0    0    -1  
$EndComp
$Comp
L FINDER-32.21-x300 RL1
U 1 1 5934B795
P 3100 1500
F 0 "RL1" H 3350 1500 50  0000 L CNN
F 1 "FINDER-32.21-x300" V 3150 1150 50  0000 L CNN
F 2 "Relays_THT:Relay_SPST_Finder_32.21-x300" H 3100 1500 50  0001 C CNN
F 3 "" H 3100 1500 50  0000 C CNN
	1    3100 1500
	1    0    0    -1  
$EndComp
Text Notes 2250 1950 0    60   ~ 0
40mA @ 5V
Text Notes 7800 2400 0    39   ~ 0
5V Load Summary:\n - MCU: 1MHz@5V (internal RC)  < 1mA active \n - Moisture probe: 5V/10KR = 500µA (when shorted)\n - Overflow sensor: 5V/100KR = 50µA (when shorted)\n - Level alert:  50µA when active (pullup from ground)\n - Thermal probe 1mA (when shorted)\n - Pump relay 40mA (nominal)\n - MIC94090 20µA\n - Pump LED max 2mA.\n - RX/TX should be low but max 40mA total\n - RX/TX LED max 40mA total. \n\nTotal MAX: < 140 mA (without extension ports)\n - Typical Sleep: <  100µA\n - Typical Active: < 70 mA\n - Typical Duty Cycle: 0.13% \n\nThermal dissipation LM7805:\n - Max: (12- 0.6 - 5) *0.140 = 896mW\n - Typical Sleep: (12- 0.6 - 5) *0.0001 = 0.64mW\n - Typical Active: (12- 0.6 - 5) *0.070 = 448mW \n - Average expected: 0.0013*448  + 0.9987 *0.64 = 1.2 mW \n - TO220 package safe dissipation without heat sink 1W.\n
Text GLabel 1450 2300 3    39   Input ~ 0
MISO
Text GLabel 1550 2300 3    39   Input ~ 0
SCK
Text GLabel 1650 2300 3    39   Input ~ 0
~RESET
Text GLabel 1550 1800 1    39   Input ~ 0
MOSI
$Comp
L GND #PWR05
U 1 1 5934D270
P 1650 1800
F 0 "#PWR05" H 1650 1550 50  0001 C CNN
F 1 "GND" H 1650 1650 50  0000 C CNN
F 2 "" H 1650 1800 50  0000 C CNN
F 3 "" H 1650 1800 50  0000 C CNN
	1    1650 1800
	0    -1   -1   0   
$EndComp
Text GLabel 4050 4100 2    39   Input ~ 0
MISO
Text GLabel 4050 4200 2    39   Input ~ 0
SCK
Text GLabel 4050 4000 2    39   Input ~ 0
MOSI
$Comp
L INDUCTOR_SMALL L1
U 1 1 5935DA81
P 1400 4000
F 0 "L1" H 1400 4100 50  0000 C CNN
F 1 "10µH" H 1400 3950 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 1400 4000 50  0001 C CNN
F 3 "" H 1400 4000 50  0000 C CNN
	1    1400 4000
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 5935DB3D
P 1750 4250
F 0 "C11" H 1775 4350 50  0000 L CNN
F 1 "100nF" V 1900 4000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1788 4100 50  0001 C CNN
F 3 "" H 1750 4250 50  0000 C CNN
	1    1750 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5935EACE
P 5450 2900
F 0 "#PWR06" H 5450 2650 50  0001 C CNN
F 1 "GND" H 5450 2750 50  0000 C CNN
F 2 "" H 5450 2900 50  0000 C CNN
F 3 "" H 5450 2900 50  0000 C CNN
	1    5450 2900
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 59369493
P 6550 4900
F 0 "R2" V 6630 4900 50  0000 C CNN
F 1 "4K7" V 6550 4900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6480 4900 50  0001 C CNN
F 3 "" H 6550 4900 50  0000 C CNN
	1    6550 4900
	1    0    0    1   
$EndComp
$Comp
L C C6
U 1 1 59369607
P 6550 5400
F 0 "C6" H 6575 5500 50  0000 L CNN
F 1 "100nF" H 6575 5300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6588 5250 50  0001 C CNN
F 3 "" H 6550 5400 50  0000 C CNN
	1    6550 5400
	-1   0    0    -1  
$EndComp
Text GLabel 6100 5150 1    39   Input ~ 0
~RESET
Text GLabel 4050 4850 2    39   Input ~ 0
~LEVEL_ALERT
$Comp
L D_Schottky D5
U 1 1 5936D8F4
P 6300 4900
F 0 "D5" H 6300 5000 50  0000 C CNN
F 1 "D_Schottky" H 6300 4800 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 6300 4900 50  0001 C CNN
F 3 "" H 6300 4900 50  0001 C CNN
	1    6300 4900
	0    -1   1    0   
$EndComp
Text GLabel 6550 4650 1    47   Input ~ 0
Vcc
$Comp
L R R4
U 1 1 5936EA26
P 6800 5150
F 0 "R4" V 6880 5150 50  0000 C CNN
F 1 "150" V 6800 5150 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6730 5150 50  0001 C CNN
F 3 "" H 6800 5150 50  0000 C CNN
	1    6800 5150
	0    1    -1   0   
$EndComp
$Comp
L D_Schottky D3
U 1 1 5936FBB6
P 2500 1500
F 0 "D3" H 2500 1600 50  0000 C CNN
F 1 "D_Schottky" H 2500 1400 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 2500 1500 50  0001 C CNN
F 3 "" H 2500 1500 50  0001 C CNN
	1    2500 1500
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 593710E5
P 7150 5150
F 0 "R3" V 7230 5150 50  0000 C CNN
F 1 "150" V 7150 5150 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7080 5150 50  0001 C CNN
F 3 "" H 7150 5150 50  0000 C CNN
	1    7150 5150
	0    1    -1   0   
$EndComp
Text GLabel 4850 800  2    39   Input ~ 0
~LEVEL_ALERT
Text Notes 5050 700  0    39   ~ 0
Level alert is debounced\nin software.
Text Notes 7650 4900 2    39   ~ 0
Recommended reset circuit\nfrom AVR HW considerations.
$Comp
L C C5
U 1 1 59377CB1
P 900 1250
F 0 "C5" H 925 1350 50  0000 L CNN
F 1 "100nF" V 750 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 938 1100 50  0001 C CNN
F 3 "" H 900 1250 50  0000 C CNN
	1    900  1250
	1    0    0    -1  
$EndComp
$Comp
L ATMEGA168-20AU U3
U 1 1 59379191
P 3050 4800
F 0 "U3" H 2300 6050 50  0000 L BNN
F 1 "ATMEGA168-20AU" H 3500 3400 50  0000 L BNN
F 2 "Housings_QFP:TQFP-32_7x7mm_Pitch0.8mm" H 3050 4800 50  0001 C CIN
F 3 "" H 3050 4800 50  0001 C CNN
	1    3050 4800
	1    0    0    -1  
$EndComp
Text GLabel 2150 4000 3    47   Input ~ 0
AVcc
$Comp
L C C9
U 1 1 5937AF02
P 1300 4850
F 0 "C9" H 1325 4950 50  0000 L CNN
F 1 "100nF" V 1150 4750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1338 4700 50  0001 C CNN
F 3 "" H 1300 4850 50  0000 C CNN
	1    1300 4850
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5937B7FA
P 950 4850
F 0 "C7" H 975 4950 50  0000 L CNN
F 1 "100nF" V 800 4750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 988 4700 50  0001 C CNN
F 3 "" H 950 4850 50  0000 C CNN
	1    950  4850
	1    0    0    -1  
$EndComp
Text GLabel 850  3700 0    47   Input ~ 0
Vcc
Text GLabel 4050 4650 2    39   Input ~ 0
MOIST+
Text GLabel 4050 4550 2    39   Input ~ 0
MOIST-
Text GLabel 2150 5050 0    39   Input ~ 0
MOISTURE
Text GLabel 6250 3650 1    39   Input ~ 0
MOIST+
Text GLabel 7000 3750 0    39   Input ~ 0
MOIST-
Text GLabel 6450 3950 1    39   Input ~ 0
THERM
Text GLabel 4050 3700 2    39   Input ~ 0
EXT_D0
Text GLabel 4050 3800 2    39   Input ~ 0
EXT_D1
Text GLabel 1350 2300 3    39   Input ~ 0
EXT_D7
$Comp
L C C12
U 1 1 5939665B
P 2100 4500
F 0 "C12" H 2125 4600 50  0000 L CNN
F 1 "10nF" V 2200 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2138 4350 50  0001 C CNN
F 3 "" H 2100 4500 50  0000 C CNN
	1    2100 4500
	1    0    0    -1  
$EndComp
Text GLabel 1150 1800 1    39   Input ~ 0
EXT_D0
Text GLabel 1250 1800 1    39   Input ~ 0
EXT_D1
Text GLabel 4050 3900 2    39   Input ~ 0
EXT_D2
Text GLabel 1450 1800 1    47   Input ~ 0
Vcc
$Comp
L D_Schottky_AKA D2
U 1 1 593C27E0
P 3800 1450
F 0 "D2" H 3800 1550 50  0000 C CNN
F 1 "D_Schottky_AKA" H 3800 1350 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 3800 1450 50  0001 C CNN
F 3 "" H 3800 1450 50  0001 C CNN
	1    3800 1450
	0    1    1    0   
$EndComp
$Comp
L R R12
U 1 1 593B812B
P 6300 3950
F 0 "R12" V 6200 3950 50  0000 C CNN
F 1 "5K11" V 6300 3950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6230 3950 50  0001 C CNN
F 3 "" H 6300 3950 50  0000 C CNN
	1    6300 3950
	0    1    1    0   
$EndComp
Text GLabel 6150 3950 0    39   Input ~ 0
THERM+
$Comp
L CONN_01X06 P2
U 1 1 593BAF43
P 7200 3900
F 0 "P2" H 7200 4250 50  0000 C CNN
F 1 "PLANT" V 7300 3900 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S6B-PH-K_06x2.00mm_Angled" H 7200 3900 50  0001 C CNN
F 3 "" H 7200 3900 50  0000 C CNN
	1    7200 3900
	1    0    0    -1  
$EndComp
Text GLabel 2150 5150 0    39   Input ~ 0
THERM
Text GLabel 4050 4750 2    39   Input ~ 0
THERM+
Text GLabel 1250 2300 3    39   Input ~ 0
EXT_D6
Text GLabel 6150 4050 0    47   Input ~ 0
AVcc
$Comp
L GND #PWR07
U 1 1 593C6E3D
P 1300 6000
F 0 "#PWR07" H 1300 5750 50  0001 C CNN
F 1 "GND" H 1300 5850 50  0000 C CNN
F 2 "" H 1300 6000 50  0000 C CNN
F 3 "" H 1300 6000 50  0000 C CNN
	1    1300 6000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 593C72D3
P 7000 4150
F 0 "#PWR08" H 7000 3900 50  0001 C CNN
F 1 "GND" H 7000 4000 50  0000 C CNN
F 2 "" H 7000 4150 50  0000 C CNN
F 3 "" H 7000 4150 50  0000 C CNN
	1    7000 4150
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG09
U 1 1 593C7C84
P 2100 6450
F 0 "#FLG09" H 2100 6545 50  0001 C CNN
F 1 "PWR_FLAG" H 2100 6630 50  0000 C CNN
F 2 "" H 2100 6450 50  0000 C CNN
F 3 "" H 2100 6450 50  0000 C CNN
	1    2100 6450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 593C7D0A
P 2100 6450
F 0 "#PWR010" H 2100 6200 50  0001 C CNN
F 1 "GND" H 2100 6300 50  0000 C CNN
F 2 "" H 2100 6450 50  0000 C CNN
F 3 "" H 2100 6450 50  0000 C CNN
	1    2100 6450
	1    0    0    -1  
$EndComp
Text GLabel 1350 1800 1    39   Input ~ 0
EXT_D2
Text GLabel 4050 4300 2    39   Input ~ 0
EXT_D6
Text GLabel 4050 4400 2    39   Input ~ 0
EXT_D7
$Comp
L GND #PWR011
U 1 1 593BAE88
P 7000 3650
F 0 "#PWR011" H 7000 3400 50  0001 C CNN
F 1 "GND" V 7000 3450 50  0000 C CNN
F 2 "" H 7000 3650 50  0000 C CNN
F 3 "" H 7000 3650 50  0000 C CNN
	1    7000 3650
	0    1    -1   0   
$EndComp
$Comp
L FUSE F1
U 1 1 594010CA
P 3000 2450
F 0 "F1" H 3100 2500 50  0000 C CNN
F 1 "FUSE" H 2900 2400 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_SMD2920" H 3000 2450 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2038617.pdf" H 3000 2450 50  0001 C CNN
	1    3000 2450
	1    0    0    -1  
$EndComp
Text Label 4200 5050 0    39   ~ 0
TX_LED
Text Label 4200 4950 0    39   ~ 0
RX_LED
Text Label 4200 5300 0    39   ~ 0
RX
Text Label 4200 5400 0    39   ~ 0
TX
Text Notes 1450 850  0    39   ~ 0
IC Max 20 µA \nNominal 40mA from relay
Text Label 3300 2200 1    39   ~ 0
+12V
Text Label 3150 2900 3    39   ~ 0
PGND
Text Notes 750  5200 1    39   ~ 0
C7 near pins 4 and 3
Text Notes 1500 5200 1    39   ~ 0
C9 near pins 5 and 6
Connection ~ 5950 2450
Connection ~ 2750 2650
Wire Wire Line
	5650 4650 5650 4950
Wire Wire Line
	5950 2500 5950 2450
Wire Wire Line
	5450 2900 5450 2750
Connection ~ 3700 2450
Wire Wire Line
	2750 2550 2750 2900
Wire Wire Line
	3700 2500 3700 2450
Wire Wire Line
	3700 2800 3700 2900
Wire Wire Line
	3300 1800 3300 2500
Connection ~ 3300 2450
Wire Wire Line
	3300 2900 3300 2800
Connection ~ 4000 2450
Wire Wire Line
	4000 2450 4000 2500
Wire Wire Line
	4000 2900 4000 2800
Wire Wire Line
	5950 2900 5950 2800
Wire Wire Line
	3650 2450 5050 2450
Connection ~ 4000 2900
Wire Wire Line
	6300 4650 6300 4750
Connection ~ 6550 4650
Wire Wire Line
	6300 5150 6300 5050
Wire Wire Line
	6550 5050 6550 5250
Connection ~ 6550 5150
Wire Wire Line
	7000 5150 6950 5150
Wire Wire Line
	900  1100 1350 1100
Wire Wire Line
	900  1400 900  1450
Wire Wire Line
	6550 4650 6550 4750
Wire Wire Line
	5650 4650 6550 4650
Wire Wire Line
	4050 5150 6650 5150
Wire Wire Line
	5950 2450 5850 2450
Wire Wire Line
	3650 2900 5950 2900
Wire Wire Line
	6450 3950 7000 3950
Wire Wire Line
	6450 4050 7000 4050
Wire Wire Line
	6550 3650 6550 3850
Wire Wire Line
	6550 3850 7000 3850
Connection ~ 6300 5150
Wire Wire Line
	4050 5050 4950 5050
Wire Wire Line
	4950 5050 4950 4950
Wire Wire Line
	4950 4650 4850 4650
Wire Wire Line
	4850 4650 4850 4950
Wire Wire Line
	4850 4950 4050 4950
Connection ~ 6300 4650
Wire Wire Line
	7900 5750 7900 5150
Wire Wire Line
	5500 5750 7900 5750
Wire Wire Line
	6550 5750 6550 5550
Wire Wire Line
	5500 5750 5500 5600
Connection ~ 6550 5750
Wire Wire Line
	4050 5300 5150 5300
Wire Wire Line
	5150 5300 5150 5400
Wire Wire Line
	5150 5400 5500 5400
Wire Wire Line
	5500 5500 5050 5500
Wire Wire Line
	5050 5500 5050 5400
Wire Wire Line
	5050 5400 4050 5400
Wire Wire Line
	2200 1200 2900 1200
Wire Wire Line
	2500 1350 2500 1200
Connection ~ 2500 1200
Wire Wire Line
	2200 1300 2200 1800
Wire Wire Line
	2200 1800 2900 1800
Wire Wire Line
	2500 1650 2500 1800
Connection ~ 2500 1800
Wire Wire Line
	4050 5700 4550 5700
Wire Wire Line
	4550 5700 4550 5750
Wire Wire Line
	4550 5750 4800 5750
Wire Wire Line
	900  1400 1050 1400
Wire Wire Line
	1350 1200 1050 1200
Wire Wire Line
	1050 1200 1050 1400
Wire Wire Line
	3400 1200 3400 1100
Wire Wire Line
	3400 1100 4200 1100
Wire Wire Line
	3800 1100 3800 1300
Wire Wire Line
	3800 1650 3800 1900
Connection ~ 3800 1900
Wire Wire Line
	3900 1900 3900 1650
Connection ~ 3900 1900
Wire Wire Line
	4200 1100 4200 1250
Connection ~ 3800 1100
Wire Wire Line
	3000 1900 4850 1900
Wire Wire Line
	3250 2450 3350 2450
Wire Wire Line
	2750 2900 3350 2900
Connection ~ 3300 2900
Connection ~ 3700 2900
Wire Wire Line
	3000 1900 3000 2900
Connection ~ 3000 2900
Wire Wire Line
	5050 2450 5050 2700
Wire Wire Line
	4350 2700 4350 2900
Connection ~ 4350 2900
Connection ~ 5450 2900
Wire Wire Line
	2100 4350 2100 4300
Wire Wire Line
	2100 4300 2150 4300
Wire Wire Line
	1750 4650 2100 4650
Wire Wire Line
	1750 6000 1750 4400
Wire Wire Line
	1650 4000 2150 4000
Wire Wire Line
	1750 4000 1750 4100
Connection ~ 1750 4000
Wire Wire Line
	850  3700 2150 3700
Wire Wire Line
	2150 3700 2150 3800
Connection ~ 1150 3700
Wire Wire Line
	2150 6000 2150 5800
Connection ~ 2150 5900
Wire Wire Line
	950  6000 2150 6000
Connection ~ 950  3700
Wire Wire Line
	1300 4700 1300 4500
Wire Wire Line
	1300 4500 950  4500
Connection ~ 950  4500
Wire Wire Line
	950  6000 950  5000
Wire Wire Line
	1300 5000 1300 6000
Connection ~ 1300 6000
Wire Wire Line
	1150 4000 1150 3700
Wire Wire Line
	950  3700 950  4700
Connection ~ 1750 6000
Connection ~ 1750 4650
Text Label 4300 2450 0    39   ~ 0
REG_PWR
Text GLabel 4850 500  0    47   Input ~ 0
Vcc
Wire Wire Line
	4300 1100 4300 1250
Text Notes 5100 1900 0    39   ~ 0
Failure analysis P1:\nPin:  ~LEVEL_ALERT:\n - May short to GND or PGND, both are equivalent to\n   level alert triggering normally.\n - May short to +12V.  Diode becomes reverse biased\n   and level_alert goes to 5V. \n\nPin: 12V\n - May short to PGND, fuse will trip.\n - May short to GND, fuse will trip. May damage traces \n   and zero ohm resistor between GND and PGND.\nPin: PGND\n - May short to GND. Harmless. 
Text Notes 2550 250  0    39   ~ 0
LM78M05CT - http://uk.farnell.com/fairchild-semiconductor/lm78m05ct/ic-v-reg-5v-0-5a-3to220/dp/1417671\nMF-LSMF300/24X - http://uk.farnell.com/bourns/lsmf300-24x-2/fuse-resettable-ptc-24v-3a-2920/dp/2057925
Text Notes 6050 2400 0    39   ~ 0
Vcc = 5 ±0.36V
$Comp
L R R10
U 1 1 5943E431
P 4850 650
F 0 "R10" V 4930 650 50  0000 C CNN
F 1 "10K" V 4850 650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4780 650 50  0001 C CNN
F 3 "" H 4850 650 50  0000 C CNN
	1    4850 650 
	1    0    0    -1  
$EndComp
$Comp
L R R13
U 1 1 5943E533
P 4850 1250
F 0 "R13" V 4930 1250 50  0000 C CNN
F 1 "10K" V 4850 1250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4780 1250 50  0001 C CNN
F 3 "" H 4850 1250 50  0000 C CNN
	1    4850 1250
	1    0    0    -1  
$EndComp
$Comp
L D D9
U 1 1 5943E5C5
P 4850 950
F 0 "D9" H 4850 1050 50  0000 C CNN
F 1 "D" H 4850 850 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 4850 950 50  0001 C CNN
F 3 "" H 4850 950 50  0000 C CNN
	1    4850 950 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4300 1100 4850 1100
Wire Wire Line
	4850 1900 4850 1400
$Comp
L CONN_01X04 P5
U 1 1 59448982
P 4750 6900
F 0 "P5" H 4750 7150 50  0000 C CNN
F 1 "CONN_01X04" V 4850 6900 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x02_Pitch2.54mm" H 4750 6900 50  0001 C CNN
F 3 "" H 4750 6900 50  0000 C CNN
	1    4750 6900
	1    0    0    -1  
$EndComp
Text GLabel 4550 6750 0    39   Input ~ 0
SHORT_LED
Text GLabel 4550 6950 0    39   Input ~ 0
LEVEL_LED
Text GLabel 4550 6850 0    39   Input ~ 0
BUZZER
$Comp
L GND #PWR012
U 1 1 59448EAB
P 4550 7050
F 0 "#PWR012" H 4550 6800 50  0001 C CNN
F 1 "GND" H 4550 6900 50  0000 C CNN
F 2 "" H 4550 7050 50  0000 C CNN
F 3 "" H 4550 7050 50  0000 C CNN
	1    4550 7050
	1    0    0    -1  
$EndComp
Text GLabel 4050 5800 2    39   Input ~ 0
SHORT_LED
Text GLabel 4050 5900 2    39   Input ~ 0
LEVEL_LED
Text GLabel 4050 6000 2    39   Input ~ 0
BUZZER
$Comp
L CONN_01X03 P6
U 1 1 5944D8B8
P 5500 6500
F 0 "P6" H 5500 6700 50  0000 C CNN
F 1 "CONN_01X03" V 5600 6500 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5500 6500 50  0001 C CNN
F 3 "" H 5500 6500 50  0000 C CNN
	1    5500 6500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 5944D95E
P 5300 6600
F 0 "#PWR013" H 5300 6350 50  0001 C CNN
F 1 "GND" H 5300 6450 50  0000 C CNN
F 2 "" H 5300 6600 50  0000 C CNN
F 3 "" H 5300 6600 50  0000 C CNN
	1    5300 6600
	1    0    0    -1  
$EndComp
Text GLabel 5300 6400 0    47   Input ~ 0
Vcc
Text GLabel 4050 5600 2    39   Input ~ 0
INT1
Text GLabel 5300 6500 0    39   Input ~ 0
INT1
Wire Wire Line
	4300 1900 4300 1750
Wire Wire Line
	4200 1900 4200 1750
Connection ~ 4200 1900
Connection ~ 4300 1900
Text GLabel 1150 2300 3    39   Input ~ 0
Vcc
$Comp
L CONN_02X06 P4
U 1 1 59459832
P 1400 2050
F 0 "P4" H 1400 2400 50  0000 C CNN
F 1 "CONN_02X06" H 1400 1700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x06_Pitch2.54mm" H 1400 850 50  0001 C CNN
F 3 "" H 1400 850 50  0000 C CNN
	1    1400 2050
	0    1    1    0   
$EndComp
Text Label 2750 2450 1    39   ~ 0
PWR
Text Notes 3250 3100 0    60   ~ 0
750mW max
$EndSCHEMATC
