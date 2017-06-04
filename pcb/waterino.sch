EESchema Schematic File Version 2
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
L Crystal Y1
U 1 1 5927112E
P 9000 3900
F 0 "Y1" H 9000 4050 50  0000 C CNN
F 1 "Crystal" H 9000 3750 50  0000 C CNN
F 2 "Crystals:Crystal_HC49-U_Vertical" H 9000 3900 50  0001 C CNN
F 3 "" H 9000 3900 50  0000 C CNN
	1    9000 3900
	0    1    1    0   
$EndComp
$Comp
L C C8
U 1 1 59271D76
P 9150 3650
F 0 "C8" V 9100 3500 50  0000 L CNN
F 1 "22pF" V 9000 3600 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 9188 3500 50  0001 C CNN
F 3 "" H 9150 3650 50  0000 C CNN
	1    9150 3650
	0    1    1    0   
$EndComp
$Comp
L C C9
U 1 1 59271E1B
P 9150 4150
F 0 "C9" V 9200 4000 50  0000 L CNN
F 1 "22pF" V 9300 4100 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 9188 4000 50  0001 C CNN
F 3 "" H 9150 4150 50  0000 C CNN
	1    9150 4150
	0    1    1    0   
$EndComp
Text GLabel 6800 4100 2    47   Input ~ 0
MOISTURE
$Comp
L R R8
U 1 1 59272E25
P 7450 3550
F 0 "R8" V 7550 3550 50  0000 C CNN
F 1 "10k" V 7450 3550 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7380 3550 50  0001 C CNN
F 3 "" H 7450 3550 50  0000 C CNN
	1    7450 3550
	0    1    1    0   
$EndComp
Text GLabel 7800 3750 2    47   Input ~ 0
MOISTURE
$Comp
L R R9
U 1 1 59273B85
P 7750 3050
F 0 "R9" V 7830 3050 50  0000 C CNN
F 1 "100k" V 7750 3050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7680 3050 50  0001 C CNN
F 3 "" H 7750 3050 50  0000 C CNN
	1    7750 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3450 8550 3450
Wire Wire Line
	6800 3550 7300 3550
Wire Wire Line
	7600 3550 8650 3550
$Comp
L MIC94090 U3
U 1 1 59275684
P 3450 1550
F 0 "U3" H 3900 2150 47  0000 C CNN
F 1 "MIC94090" H 3900 1650 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 3350 1550 47  0001 C CNN
F 3 "" H 3350 1550 47  0001 C CNN
	1    3450 1550
	-1   0    0    1   
$EndComp
NoConn ~ 3450 1800
Text GLabel 2350 2000 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON1
U 1 1 59277B44
P 800 3350
F 0 "CON1" H 800 3600 50  0000 C CNN
F 1 "BARREL_JACK" H 800 3150 50  0000 C CNN
F 2 "Connect:BARREL_JACK" H 800 3350 50  0001 C CNN
F 3 "" H 800 3350 50  0000 C CNN
	1    800  3350
	1    0    0    -1  
$EndComp
$Comp
L LM7805CT U2
U 1 1 59277F88
P 2650 3300
F 0 "U2" H 2450 3500 50  0000 C CNN
F 1 "LM7805CT" H 2650 3500 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 2650 3400 50  0001 C CIN
F 3 "" H 2650 3300 50  0000 C CNN
	1    2650 3300
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 592799BC
P 3150 3450
F 0 "C4" H 3175 3550 50  0000 L CNN
F 1 "100nF" H 3175 3350 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3188 3300 50  0001 C CNN
F 3 "" H 3150 3450 50  0000 C CNN
	1    3150 3450
	1    0    0    -1  
$EndComp
$Comp
L LED D5
U 1 1 5927A727
P 3450 3650
F 0 "D5" H 3550 3600 50  0000 C CNN
F 1 "LED" H 3450 3550 50  0000 C CNN
F 2 "LEDs:LED_1206" H 3450 3650 50  0001 C CNN
F 3 "" H 3450 3650 50  0000 C CNN
	1    3450 3650
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 5927A83C
P 3900 3450
F 0 "R6" V 3980 3450 50  0000 C CNN
F 1 "150R" V 3900 3450 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 3830 3450 50  0001 C CNN
F 3 "" H 3900 3450 50  0000 C CNN
	1    3900 3450
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 5927C419
P 2600 2150
F 0 "R5" V 2680 2150 50  0000 C CNN
F 1 "1.5k" V 2600 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2530 2150 50  0001 C CNN
F 3 "" H 2600 2150 50  0000 C CNN
	1    2600 2150
	-1   0    0    1   
$EndComp
$Comp
L LED D4
U 1 1 5927C47E
P 2800 2300
F 0 "D4" H 2800 2400 50  0000 C CNN
F 1 "LED" H 2800 2200 50  0000 C CNN
F 2 "LEDs:LED_1206" H 2800 2300 50  0001 C CNN
F 3 "" H 2800 2300 50  0000 C CNN
	1    2800 2300
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 59281429
P 2650 1050
F 0 "SW1" H 2800 1160 50  0000 C CNN
F 1 "SW_PUSH" H 2650 970 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm" H 2650 1050 50  0001 C CNN
F 3 "" H 2650 1050 50  0000 C CNN
	1    2650 1050
	1    0    0    -1  
$EndComp
Text GLabel 6800 3750 2    47   Input ~ 0
PUMP
$Comp
L GND #PWR01
U 1 1 592B0412
P 2950 1050
F 0 "#PWR01" H 2950 800 50  0001 C CNN
F 1 "GND" H 2950 900 50  0000 C CNN
F 2 "" H 2950 1050 50  0000 C CNN
F 3 "" H 2950 1050 50  0000 C CNN
	1    2950 1050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR02
U 1 1 592B0B84
P 8800 5400
F 0 "#PWR02" H 8800 5150 50  0001 C CNN
F 1 "GND" H 8800 5250 50  0000 C CNN
F 2 "" H 8800 5400 50  0000 C CNN
F 3 "" H 8800 5400 50  0000 C CNN
	1    8800 5400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 592B3137
P 9300 4150
F 0 "#PWR03" H 9300 3900 50  0001 C CNN
F 1 "GND" H 9300 4000 50  0000 C CNN
F 2 "" H 9300 4150 50  0000 C CNN
F 3 "" H 9300 4150 50  0000 C CNN
	1    9300 4150
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR04
U 1 1 59277F1D
P 2600 1900
F 0 "#PWR04" H 2600 1650 50  0001 C CNN
F 1 "GND" H 2600 1750 50  0000 C CNN
F 2 "" H 2600 1900 50  0000 C CNN
F 3 "" H 2600 1900 50  0000 C CNN
	1    2600 1900
	0    1    1    0   
$EndComp
$Comp
L GND #PWR05
U 1 1 59278014
P 3000 2300
F 0 "#PWR05" H 3000 2050 50  0001 C CNN
F 1 "GND" H 3000 2150 50  0000 C CNN
F 2 "" H 3000 2300 50  0000 C CNN
F 3 "" H 3000 2300 50  0000 C CNN
	1    3000 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5928541B
P 4850 5600
F 0 "#PWR06" H 4850 5350 50  0001 C CNN
F 1 "GND" H 4850 5450 50  0000 C CNN
F 2 "" H 4850 5600 50  0000 C CNN
F 3 "" H 4850 5600 50  0000 C CNN
	1    4850 5600
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P4
U 1 1 5928A55A
P 9000 5250
F 0 "P4" H 9000 5500 50  0000 C CNN
F 1 "CONN_01X04" V 9100 5250 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 9000 5250 50  0001 C CNN
F 3 "" H 9000 5250 50  0000 C CNN
	1    9000 5250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5928C3F6
P 2350 5950
F 0 "#PWR07" H 2350 5700 50  0001 C CNN
F 1 "GND" H 2350 5800 50  0000 C CNN
F 2 "" H 2350 5950 50  0000 C CNN
F 3 "" H 2350 5950 50  0000 C CNN
	1    2350 5950
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG08
U 1 1 5928C455
P 2350 5950
F 0 "#FLG08" H 2350 6045 50  0001 C CNN
F 1 "PWR_FLAG" H 2350 6130 50  0000 C CNN
F 2 "" H 2350 5950 50  0000 C CNN
F 3 "" H 2350 5950 50  0000 C CNN
	1    2350 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 3250 4900 3250
Connection ~ 3150 3250
Connection ~ 2650 3650
Wire Wire Line
	4550 5450 4900 5450
Connection ~ 1100 3450
Text GLabel 1150 3200 1    47   Input ~ 0
+12V
Text GLabel 5150 1500 2    47   Input ~ 0
+12V
$Comp
L MAX6817 U1
U 1 1 59289E23
P 1800 1150
F 0 "U1" H 1800 1450 60  0000 C CNN
F 1 "MAX6817" H 1800 900 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6_Handsoldering" H 1800 750 60  0001 C CNN
F 3 "" H 1800 750 60  0001 C CNN
	1    1800 1150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2250 1050 2350 1050
Text GLabel 1350 1050 0    47   Input ~ 0
RESET
Text GLabel 6800 4700 2    47   Input ~ 0
RESET
$Comp
L GND #PWR09
U 1 1 5928AED0
P 2250 1150
F 0 "#PWR09" H 2250 900 50  0001 C CNN
F 1 "GND" H 2250 1000 50  0000 C CNN
F 2 "" H 2250 1150 50  0000 C CNN
F 3 "" H 2250 1150 50  0000 C CNN
	1    2250 1150
	0    -1   -1   0   
$EndComp
Text GLabel 1350 1150 0    47   Input ~ 0
Vcc
Text GLabel 1350 1250 0    47   Input ~ 0
LEVEL_ALERT
Text GLabel 6800 5150 2    47   Input ~ 0
LEVEL_ALERT
$Comp
L R R4
U 1 1 5928C863
P 2100 4950
F 0 "R4" V 2180 4950 50  0000 C CNN
F 1 "150R" V 2100 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2030 4950 50  0001 C CNN
F 3 "" H 2100 4950 50  0000 C CNN
	1    2100 4950
	0    1    1    0   
$EndComp
$Comp
L LED D3
U 1 1 5928C9A7
P 1750 4950
F 0 "D3" H 1750 5050 50  0000 C CNN
F 1 "LED" H 1750 4850 50  0000 C CNN
F 2 "LEDs:LED_1206" H 1750 4950 50  0001 C CNN
F 3 "" H 1750 4950 50  0000 C CNN
	1    1750 4950
	1    0    0    1   
$EndComp
$Comp
L LED D2
U 1 1 5928CC0E
P 1750 4650
F 0 "D2" H 1750 4750 50  0000 C CNN
F 1 "LED" H 1750 4550 50  0000 C CNN
F 2 "LEDs:LED_1206" H 1750 4650 50  0001 C CNN
F 3 "" H 1750 4650 50  0000 C CNN
	1    1750 4650
	1    0    0    1   
$EndComp
$Comp
L R R3
U 1 1 5928CCC0
P 2100 4650
F 0 "R3" V 2180 4650 50  0000 C CNN
F 1 "150R" V 2100 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2030 4650 50  0001 C CNN
F 3 "" H 2100 4650 50  0000 C CNN
	1    2100 4650
	0    1    1    0   
$EndComp
Text Notes 9150 5550 1    47   ~ 0
UART Debugger
Text Notes 1600 750  0    47   ~ 0
Debouncing
$Comp
L CONN_02X02 P1
U 1 1 5929A575
P 3400 1200
F 0 "P1" H 3400 1350 50  0000 C CNN
F 1 "CONN_02X02" H 3400 1050 50  0001 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 3400 0   50  0001 C CNN
F 3 "" H 3400 0   50  0000 C CNN
	1    3400 1200
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR010
U 1 1 592A0DF0
P 3950 1900
F 0 "#PWR010" H 3950 1650 50  0001 C CNN
F 1 "GND" H 3950 1750 50  0000 C CNN
F 2 "" H 3950 1900 50  0000 C CNN
F 3 "" H 3950 1900 50  0000 C CNN
	1    3950 1900
	1    0    0    1   
$EndComp
Wire Wire Line
	2250 1250 3200 1250
Text Notes 2950 800  0    47   ~ 0
Reservoir Molex\n(Pump Power and Water Level Alert)
Wire Wire Line
	6800 3350 8450 3350
Text Notes 9050 2550 0    47   ~ 0
Pot Molex\n(Moisture, Thermal Sensor and Overflow Detector)
Wire Wire Line
	9300 3650 9300 4150
Wire Wire Line
	9000 4150 9000 4050
Wire Wire Line
	9000 3650 9000 3750
Wire Wire Line
	8400 3650 9000 3650
Wire Wire Line
	8400 3650 8400 3850
Wire Wire Line
	8400 3850 6800 3850
Wire Wire Line
	6800 3950 8400 3950
Wire Wire Line
	8400 3950 8400 4150
Wire Wire Line
	8400 4150 9000 4150
Wire Wire Line
	7800 3750 7700 3750
Wire Wire Line
	7700 3750 7700 3550
Connection ~ 7700 3550
Connection ~ 3150 3650
Text Label 7150 3350 0    47   ~ 0
THERM
Text Label 7550 3450 0    47   ~ 0
MOIST-
Text GLabel 7750 3250 0    47   Input ~ 0
~OVRFLW
Wire Wire Line
	7750 3250 7750 3200
$Comp
L GND #PWR011
U 1 1 592B3AA1
P 9000 2850
F 0 "#PWR011" H 9000 2600 50  0001 C CNN
F 1 "GND" V 9000 2650 50  0000 C CNN
F 2 "" H 9000 2850 50  0000 C CNN
F 3 "" H 9000 2850 50  0000 C CNN
	1    9000 2850
	0    1    1    0   
$EndComp
Text GLabel 6800 5050 2    47   Input ~ 0
~OVRFLW
Text GLabel 3900 3250 1    47   Input ~ 0
Vcc
Text GLabel 8800 5100 0    47   Input ~ 0
Vcc
Text GLabel 7750 2900 1    47   Input ~ 0
Vcc
Text Label 2400 1250 0    47   ~ 0
LVL_SWTCH
Text GLabel 2600 1800 1    47   Input ~ 0
Vcc
Wire Wire Line
	2350 2000 2600 2000
$Comp
L C C7
U 1 1 592D75A2
P 4650 4100
F 0 "C7" H 4675 4200 50  0000 L CNN
F 1 "100nF" V 4800 4000 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4688 3950 50  0001 C CNN
F 3 "" H 4650 4100 50  0000 C CNN
	1    4650 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 5600 4850 5550
$Comp
L GND #PWR012
U 1 1 592D7BDA
P 1900 6250
F 0 "#PWR012" H 1900 6000 50  0001 C CNN
F 1 "GND" H 1900 6100 50  0000 C CNN
F 2 "" H 1900 6250 50  0000 C CNN
F 3 "" H 1900 6250 50  0000 C CNN
	1    1900 6250
	1    0    0    -1  
$EndComp
Text GLabel 1900 5950 0    47   Input ~ 0
AVss
Text GLabel 4550 5450 0    47   Input ~ 0
AVss
Text GLabel 9000 3050 0    47   Input ~ 0
Vcc
$Comp
L ATMEGA168A-P IC1
U 1 1 59270F44
P 5800 4350
F 0 "IC1" H 5050 5600 50  0000 L BNN
F 1 "ATMEGA168A-P" H 5300 3800 50  0000 L BNN
F 2 "Housings_DIP:DIP-28_W7.62mm_Socket" H 5800 4350 50  0000 C CIN
F 3 "" H 5800 4350 50  0000 C CNN
	1    5800 4350
	1    0    0    -1  
$EndComp
Text GLabel 6800 3650 2    47   Input ~ 0
RX_LED
Text GLabel 6800 3250 2    47   Input ~ 0
TX_LED
Text GLabel 1550 4950 0    47   Input ~ 0
TX_LED
Text GLabel 1550 4650 0    47   Input ~ 0
RX_LED
Wire Wire Line
	2250 4950 2250 4650
Wire Wire Line
	2350 4800 2250 4800
Connection ~ 2250 4800
Text Notes 8000 4950 1    47   ~ 0
Expansion Port A
Wire Wire Line
	6800 5250 7500 5250
Wire Wire Line
	6800 5350 7500 5350
Wire Wire Line
	6800 5450 7500 5450
Wire Wire Line
	6800 5550 7500 5550
Text Notes 7950 5200 3    47   ~ 0
Expansion Port B
$Comp
L R R10
U 1 1 592EC98D
P 8600 3900
F 0 "R10" V 8680 3900 50  0000 C CNN
F 1 "1M" V 8600 3900 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8530 3900 50  0001 C CNN
F 3 "" H 8600 3900 50  0000 C CNN
	1    8600 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 3650 8600 3750
Connection ~ 8600 3650
Wire Wire Line
	8600 4150 8600 4050
Connection ~ 8600 4150
Text GLabel 2350 4800 2    47   Input ~ 0
Vcc
Text Notes 1250 5300 0    47   ~ 0
Yellow LED (2.1V, 20mA, 8mcd): \n(5V - 2.1V) / 20mA = 145 Ohm.\nPick 150 Ohm (E12)
Text Notes 1600 4300 0    47   ~ 0
Green LED (2.2V, 20mA, 15mcd): We want 8mcd brightness: \n(5V - 2.2V) / (20mA * 8mcd/15mcd) = 262 Ohm.  \nPick 2x150 Ohm in series (E12).
Text Notes 6250 1850 0    47   ~ 0
R3 forms a voltage voltage divider with the electrodes in the water. \nMy measurements put resistance of tap water at around 80-100k for\nsmall electrodes and around 2k for large electrodes (3cm galvanized screws).\nWe'll use large electrodes. The voltage at the divider when the electrodes \nare in water should be: \n\n    Vcc * 2k / 102k = Vcc*0.02 which will trigger a level interrupt on INT0\n\nATMega has 2.6V input threshold on pins and .5V hysteresis. \nEven 30K is safely within the trigger range.
Text Notes 2200 2750 0    47   ~ 0
Red LED (1.85V , 20mA, 80mcd): We want 8mcd brightness:\n(5V - 1.85V) / (20mA * 8mcd/80mcd) = 1575 Ohm.\nPick 1.5K Ohm (E12).
Text GLabel 7600 4700 0    47   Input ~ 0
Vcc
$Comp
L CONN_01X07 P3
U 1 1 59314AC3
P 7800 4500
F 0 "P3" H 7800 4100 50  0000 C CNN
F 1 "CONN_01X07" V 7900 4500 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x07_Pitch2.54mm" H 7800 4500 50  0001 C CNN
F 3 "" H 7800 4500 50  0000 C CNN
	1    7800 4500
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X06 P2
U 1 1 59314B8C
P 7700 5500
F 0 "P2" H 7700 5150 50  0000 C CNN
F 1 "CONN_01X06" V 7800 5500 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x06_Pitch2.54mm" H 7700 5500 50  0001 C CNN
F 3 "" H 7700 5500 50  0000 C CNN
	1    7700 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 4200 7600 4200
Wire Wire Line
	6800 4300 7600 4300
Wire Wire Line
	6800 4400 7600 4400
Wire Wire Line
	6800 4500 7600 4500
Wire Wire Line
	6800 4600 7600 4600
Text GLabel 8800 5200 0    47   Input ~ 0
RX
Text GLabel 8800 5300 0    47   Input ~ 0
TX
Text GLabel 6800 4850 2    47   Input ~ 0
RX
Text GLabel 6800 4950 2    47   Input ~ 0
TX
$Comp
L GND #PWR013
U 1 1 59311E50
P 7600 4800
F 0 "#PWR013" H 7600 4550 50  0001 C CNN
F 1 "GND" H 7600 4650 50  0000 C CNN
F 2 "" H 7600 4800 50  0000 C CNN
F 3 "" H 7600 4800 50  0000 C CNN
	1    7600 4800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 59318FE9
P 7500 5750
F 0 "#PWR014" H 7500 5500 50  0001 C CNN
F 1 "GND" H 7500 5600 50  0000 C CNN
F 2 "" H 7500 5750 50  0000 C CNN
F 3 "" H 7500 5750 50  0000 C CNN
	1    7500 5750
	1    0    0    -1  
$EndComp
Text GLabel 7500 5650 0    47   Input ~ 0
Vcc
$Comp
L C C5
U 1 1 5931D287
P 4250 3800
F 0 "C5" H 4275 3900 50  0000 L CNN
F 1 "100nF" V 4100 3700 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4288 3650 50  0001 C CNN
F 3 "" H 4250 3800 50  0000 C CNN
	1    4250 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 3650 4250 3250
Connection ~ 4250 3250
Connection ~ 4650 3250
Wire Wire Line
	4250 5550 4250 3950
Connection ~ 4850 5550
Connection ~ 4650 5450
NoConn ~ 4900 3850
$Comp
L D D1
U 1 1 59321D7A
P 1650 3250
F 0 "D1" H 1650 3350 50  0000 C CNN
F 1 "D" H 1650 3150 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 1650 3250 50  0001 C CNN
F 3 "" H 1650 3250 50  0000 C CNN
	1    1650 3250
	-1   0    0    1   
$EndComp
Wire Wire Line
	1100 3250 1500 3250
Wire Wire Line
	1150 3250 1150 3200
Connection ~ 1150 3250
$Comp
L CP C2
U 1 1 59323AB3
P 1850 3450
F 0 "C2" H 1875 3550 50  0000 L CNN
F 1 "100µF" H 1600 3350 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 1888 3300 50  0001 C CNN
F 3 "" H 1850 3450 50  0000 C CNN
	1    1850 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 3300 3150 3250
Wire Wire Line
	3150 3650 3150 3600
Wire Wire Line
	2650 3650 2650 3550
Connection ~ 1850 3250
Wire Wire Line
	1100 3350 1100 3650
Connection ~ 1850 3650
Wire Wire Line
	1850 3300 1850 3250
Wire Wire Line
	1850 3650 1850 3600
$Comp
L CP C1
U 1 1 5932A26F
P 1450 3450
F 0 "C1" H 1475 3550 50  0000 L CNN
F 1 "100µF" H 1200 3350 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 1488 3300 50  0001 C CNN
F 3 "" H 1450 3450 50  0000 C CNN
	1    1450 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 3250 1450 3300
Connection ~ 1450 3250
Wire Wire Line
	1450 3600 1450 3650
Connection ~ 1450 3650
Connection ~ 4250 5550
Wire Wire Line
	4250 5550 4900 5550
Text Label 4250 1000 0    47   ~ 0
PUMP-
Text Label 4250 1400 0    47   ~ 0
PUMP+
Wire Wire Line
	3500 1400 4550 1400
Wire Wire Line
	3500 1000 4550 1000
$Comp
L GND #PWR015
U 1 1 592EE26C
P 3350 1450
F 0 "#PWR015" H 3350 1200 50  0001 C CNN
F 1 "GND" H 3350 1300 50  0000 C CNN
F 2 "" H 3350 1450 50  0000 C CNN
F 3 "" H 3350 1450 50  0000 C CNN
	1    3350 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 1250 3200 950 
Wire Wire Line
	3200 950  3350 950 
Text Label 6900 3550 0    47   ~ 0
MOIST+
$Comp
L CONN_01X07 P5
U 1 1 592F857C
P 9200 3050
F 0 "P5" H 9200 3450 50  0000 C CNN
F 1 "CONN_01X07" V 9300 3050 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S7B-PH-K_07x2.00mm_Angled" H 9200 3050 50  0001 C CNN
F 3 "" H 9200 3050 50  0000 C CNN
	1    9200 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 3350 8450 2750
Wire Wire Line
	8450 2750 9000 2750
Text GLabel 9000 3350 0    47   Input ~ 0
~OVRFLW
Text Label 1800 3250 0    60   ~ 0
REG_PWR
$Comp
L R R2
U 1 1 592FE86B
P 1900 6100
F 0 "R2" V 1980 6100 50  0000 C CNN
F 1 "0" V 1900 6100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1830 6100 50  0001 C CNN
F 3 "" H 1900 6100 50  0000 C CNN
	1    1900 6100
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG016
U 1 1 592FFE98
P 1900 5950
F 0 "#FLG016" H 1900 6045 50  0001 C CNN
F 1 "PWR_FLAG" H 1900 6130 50  0000 C CNN
F 2 "" H 1900 5950 50  0000 C CNN
F 3 "" H 1900 5950 50  0000 C CNN
	1    1900 5950
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR_SMALL L1
U 1 1 5930226C
P 4650 3500
F 0 "L1" H 4650 3600 50  0000 C CNN
F 1 "10µH" H 4650 3450 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 4650 3500 50  0001 C CNN
F 3 "" H 4650 3500 50  0000 C CNN
	1    4650 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 3550 4800 3550
Wire Wire Line
	4800 3550 4800 3750
Wire Wire Line
	4800 3750 4650 3750
Wire Wire Line
	4650 3750 4650 3950
Wire Wire Line
	4650 4250 4650 5450
Text GLabel 4800 3750 2    47   Input ~ 0
AVcc
Text GLabel 2800 5950 0    47   Input ~ 0
AVcc
$Comp
L PWR_FLAG #FLG017
U 1 1 59302DDD
P 2800 5950
F 0 "#FLG017" H 2800 6045 50  0001 C CNN
F 1 "PWR_FLAG" H 2800 6130 50  0000 C CNN
F 2 "" H 2800 5950 50  0000 C CNN
F 3 "" H 2800 5950 50  0000 C CNN
	1    2800 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8550 3450 8550 3150
Wire Wire Line
	8550 3150 9000 3150
Wire Wire Line
	8650 3550 8650 3250
Wire Wire Line
	8650 3250 9000 3250
Text GLabel 1450 5950 0    47   Input ~ 0
PGND
$Comp
L PWR_FLAG #FLG018
U 1 1 5930AC6A
P 1450 5950
F 0 "#FLG018" H 1450 6045 50  0001 C CNN
F 1 "PWR_FLAG" H 1450 6130 50  0000 C CNN
F 2 "" H 1450 5950 50  0000 C CNN
F 3 "" H 1450 5950 50  0000 C CNN
	1    1450 5950
	1    0    0    -1  
$EndComp
Text GLabel 4550 1000 2    47   Input ~ 0
PGND
Text GLabel 1450 3650 3    47   Input ~ 0
PGND
$Comp
L GND #PWR019
U 1 1 5930E005
P 1450 6250
F 0 "#PWR019" H 1450 6000 50  0001 C CNN
F 1 "GND" H 1450 6100 50  0000 C CNN
F 2 "" H 1450 6250 50  0000 C CNN
F 3 "" H 1450 6250 50  0000 C CNN
	1    1450 6250
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5930E0B4
P 1450 6100
F 0 "R1" V 1530 6100 50  0000 C CNN
F 1 "0" V 1450 6100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1380 6100 50  0001 C CNN
F 3 "" H 1450 6100 50  0000 C CNN
	1    1450 6100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR020
U 1 1 59315998
P 2650 3650
F 0 "#PWR020" H 2650 3400 50  0001 C CNN
F 1 "GND" H 2650 3500 50  0000 C CNN
F 2 "" H 2650 3650 50  0000 C CNN
F 3 "" H 2650 3650 50  0000 C CNN
	1    2650 3650
	1    0    0    -1  
$EndComp
Text Label 4050 2200 2    60   ~ 0
COIL_PWR
Wire Wire Line
	3500 1400 3500 1450
Wire Wire Line
	3500 1450 3450 1450
Wire Wire Line
	3450 950  3500 950 
Wire Wire Line
	3500 950  3500 1000
Connection ~ 3950 1900
Text Notes 4900 3900 3    47   ~ 0
AVcc LC circuit taken from AVR datasheet.
Text Label 8400 3650 0    47   ~ 0
XTAL1
Text Label 8400 4150 0    47   ~ 0
XTAL2
Text Label 6900 4200 0    47   ~ 0
EXT_A1
Text Label 6900 4300 0    47   ~ 0
EXT_A2
Text Label 6900 4400 0    47   ~ 0
EXT_A3
Text Label 6900 4500 0    47   ~ 0
EXT_A4
Text Label 6900 4600 0    47   ~ 0
EXT_A5
Text Label 7250 5250 0    47   ~ 0
EXT_B1
Text Label 7000 5350 0    47   ~ 0
EXT_B2
Text Label 7000 5450 0    47   ~ 0
EXT_B3
Text Label 7000 5550 0    47   ~ 0
EXT_B4
Wire Wire Line
	9000 2850 9000 2950
$Comp
L R R7
U 1 1 593391B6
P 3900 3800
F 0 "R7" V 4000 3800 50  0000 C CNN
F 1 "150R" V 3900 3800 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 3830 3800 50  0001 C CNN
F 3 "" H 3900 3800 50  0000 C CNN
	1    3900 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 3300 3900 3250
Connection ~ 3900 3250
Wire Wire Line
	3650 3650 3650 3950
Wire Wire Line
	3900 3650 3900 3600
Wire Wire Line
	3650 3950 3900 3950
$Comp
L D D7
U 1 1 593435BC
P 4350 2050
F 0 "D7" H 4350 2150 50  0000 C CNN
F 1 "D" H 4350 1950 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 4350 2050 50  0001 C CNN
F 3 "" H 4350 2050 50  0000 C CNN
	1    4350 2050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3450 2000 3450 2200
Wire Wire Line
	3450 2200 5150 2200
Wire Wire Line
	5150 2200 5150 1900
Connection ~ 4350 2200
Wire Wire Line
	3450 1900 4550 1900
Connection ~ 4350 1900
Connection ~ 2150 3250
Connection ~ 2150 3650
$Comp
L C C3
U 1 1 59347036
P 2150 3450
F 0 "C3" H 2175 3550 50  0000 L CNN
F 1 "100nF" H 2175 3350 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2188 3300 50  0001 C CNN
F 3 "" H 2150 3450 50  0000 C CNN
	1    2150 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 3250 2150 3300
Wire Wire Line
	2150 3650 2150 3600
Wire Wire Line
	1800 3250 2250 3250
$Comp
L FINDER-32.21-x300 RL1
U 1 1 5934B795
P 4850 1700
F 0 "RL1" H 5300 1850 50  0000 L CNN
F 1 "FINDER-32.21-x300" H 5300 1750 50  0000 L CNN
F 2 "Relays_ThroughHole:Relay_SPST_Finder_32.21-x300" H 4850 1700 50  0001 C CNN
F 3 "" H 4850 1700 50  0000 C CNN
	1    4850 1700
	0    -1   -1   0   
$EndComp
$Comp
L D D6
U 1 1 5934C38A
P 4100 1200
F 0 "D6" H 4100 1300 50  0000 C CNN
F 1 "D" H 4100 1100 50  0000 C CNN
F 2 "Diodes_ThroughHole:D_DO-41_SOD81_P7.62mm_Horizontal" H 4100 1200 50  0001 C CNN
F 3 "" H 4100 1200 50  0000 C CNN
	1    4100 1200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4100 1050 4100 1000
Connection ~ 4100 1000
Wire Wire Line
	4100 1350 4100 1400
Connection ~ 4100 1400
Text Notes 3750 2300 0    60   ~ 0
40mA @ 5V
Text Notes 1550 1550 0    60   ~ 0
Max 20 µA
Text Notes 2450 1800 2    60   ~ 0
Max 20 µA + Nominal 40mA from relay
Text Notes 5150 2900 0    60   ~ 0
MCU will source at most 200mA from Vcc. \nPower LED will drain about 10mA\nRX/TX leds will drain about 40mA\nOverflow sensor if shorted will drain at most 50µA\nMoisture probe is included in MCU power. \nThermal probe will drain at most 10mA from Vcc.
Text Notes 3050 3150 0    60   ~ 0
About max 300mA total drain before extension devices, typical 100mA\n during operation and the PWR LED will dominate when the µC is sleeping.
$Comp
L C C6
U 1 1 5935D0D4
P 4400 3450
F 0 "C6" H 4425 3550 50  0000 L CNN
F 1 "10nF" V 4250 3350 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4438 3300 50  0001 C CNN
F 3 "" H 4400 3450 50  0000 C CNN
	1    4400 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 3300 4400 3250
Connection ~ 4400 3250
Wire Wire Line
	4400 3600 4400 4100
Wire Wire Line
	4400 4100 4250 4100
Connection ~ 4250 4100
Wire Wire Line
	1450 3650 1100 3650
Wire Wire Line
	1850 3650 3250 3650
$EndSCHEMATC
