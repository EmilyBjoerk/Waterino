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
P 5300 3950
F 0 "R6" V 5400 3950 50  0000 C CNN
F 1 "10k" V 5300 3950 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5230 3950 50  0001 C CNN
F 3 "" H 5300 3950 50  0000 C CNN
	1    5300 3950
	-1   0    0    1   
$EndComp
Text GLabel 5300 4100 0    39   Input ~ 0
MOISTURE
$Comp
L R R5
U 1 1 59273B85
P 4850 4150
F 0 "R5" V 4930 4150 50  0000 C CNN
F 1 "100k" V 4850 4150 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4780 4150 50  0001 C CNN
F 3 "" H 4850 4150 50  0000 C CNN
	1    4850 4150
	1    0    0    -1  
$EndComp
$Comp
L MIC94090 U2
U 1 1 59275684
P 2350 1550
F 0 "U2" H 2800 2150 47  0000 C CNN
F 1 "MIC94090" H 2800 1650 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6_Handsoldering" H 2250 1550 47  0001 C CNN
F 3 "" H 2250 1550 47  0001 C CNN
	1    2350 1550
	-1   0    0    1   
$EndComp
NoConn ~ 2350 1800
Text GLabel 1250 2000 0    47   Input ~ 0
PUMP
$Comp
L BARREL_JACK CON1
U 1 1 59277B44
P 4900 1000
F 0 "CON1" H 4900 1250 50  0000 C CNN
F 1 "POWER" H 4900 800 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 4900 1000 50  0001 C CNN
F 3 "" H 4900 1000 50  0000 C CNN
	1    4900 1000
	1    0    0    -1  
$EndComp
$Comp
L LM7805CT U1
U 1 1 59277F88
P 6750 950
F 0 "U1" H 6550 1150 50  0000 C CNN
F 1 "LM7805CT" H 6750 1150 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 6750 1050 50  0001 C CIN
F 3 "" H 6750 950 50  0000 C CNN
	1    6750 950 
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 592799BC
P 7250 1100
F 0 "C4" H 7275 1200 50  0000 L CNN
F 1 "100nF" V 7050 1000 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 7288 950 50  0001 C CNN
F 3 "" H 7250 1100 50  0000 C CNN
	1    7250 1100
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-waterino D8
U 1 1 5927A727
P 5650 6350
F 0 "D8" H 5650 6500 50  0000 C CNN
F 1 "PWR_LED" H 5650 6250 50  0000 C CNN
F 2 "LEDs:LED_1206" H 5650 6350 50  0001 C CNN
F 3 "" H 5650 6350 50  0000 C CNN
	1    5650 6350
	-1   0    0    1   
$EndComp
$Comp
L R R1
U 1 1 5927C419
P 1500 2150
F 0 "R1" V 1580 2150 50  0000 C CNN
F 1 "1.5k" V 1500 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1430 2150 50  0001 C CNN
F 3 "" H 1500 2150 50  0000 C CNN
	1    1500 2150
	-1   0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D4
U 1 1 5927C47E
P 1700 2300
F 0 "D4" H 1700 2400 50  0000 C CNN
F 1 "PUMP_LED" H 2000 2400 50  0000 C CNN
F 2 "LEDs:LED_1206" H 1700 2300 50  0001 C CNN
F 3 "" H 1700 2300 50  0000 C CNN
	1    1700 2300
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 59281429
P 7850 4100
F 0 "SW1" H 8000 4210 50  0000 C CNN
F 1 "RESET" H 7850 4020 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 7850 4100 50  0001 C CNN
F 3 "" H 7850 4100 50  0000 C CNN
	1    7850 4100
	1    0    0    -1  
$EndComp
Text GLabel 4050 5700 2    39   Input ~ 0
PUMP
$Comp
L GND #PWR01
U 1 1 592B0B84
P 6400 5550
F 0 "#PWR01" H 6400 5300 50  0001 C CNN
F 1 "GND" H 6400 5400 50  0000 C CNN
F 2 "" H 6400 5550 50  0000 C CNN
F 3 "" H 6400 5550 50  0000 C CNN
	1    6400 5550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59277F1D
P 1050 1900
F 0 "#PWR02" H 1050 1650 50  0001 C CNN
F 1 "GND" H 1050 1750 50  0000 C CNN
F 2 "" H 1050 1900 50  0000 C CNN
F 3 "" H 1050 1900 50  0000 C CNN
	1    1050 1900
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 59278014
P 1900 2300
F 0 "#PWR03" H 1900 2050 50  0001 C CNN
F 1 "GND" H 1900 2150 50  0000 C CNN
F 2 "" H 1900 2300 50  0000 C CNN
F 3 "" H 1900 2300 50  0000 C CNN
	1    1900 2300
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 P3
U 1 1 5928A55A
P 6600 5400
F 0 "P3" H 6600 5650 50  0000 C CNN
F 1 "UART" V 6700 5400 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 6600 5400 50  0001 C CNN
F 3 "" H 6600 5400 50  0000 C CNN
	1    6600 5400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 5928C3F6
P 8500 5900
F 0 "#PWR04" H 8500 5650 50  0001 C CNN
F 1 "GND" H 8500 5750 50  0000 C CNN
F 2 "" H 8500 5900 50  0000 C CNN
F 3 "" H 8500 5900 50  0000 C CNN
	1    8500 5900
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG05
U 1 1 5928C455
P 8500 5900
F 0 "#FLG05" H 8500 5995 50  0001 C CNN
F 1 "PWR_FLAG" H 8500 6080 50  0000 C CNN
F 2 "" H 8500 5900 50  0000 C CNN
F 3 "" H 8500 5900 50  0000 C CNN
	1    8500 5900
	1    0    0    -1  
$EndComp
Connection ~ 7250 900 
Connection ~ 5200 1100
Text GLabel 5250 850  1    47   Input ~ 0
+12V
Text GLabel 4050 1500 2    47   Input ~ 0
+12V
$Comp
L R R8
U 1 1 5928C863
P 5650 5550
F 0 "R8" V 5730 5550 50  0000 C CNN
F 1 "150R" V 5650 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5580 5550 50  0001 C CNN
F 3 "" H 5650 5550 50  0000 C CNN
	1    5650 5550
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-waterino D7
U 1 1 5928C9A7
P 5300 5550
F 0 "D7" H 5300 5650 50  0000 C CNN
F 1 "TX_LED" H 5300 5450 50  0000 C CNN
F 2 "LEDs:LED_1206" H 5300 5550 50  0001 C CNN
F 3 "" H 5300 5550 50  0000 C CNN
	1    5300 5550
	1    0    0    1   
$EndComp
$Comp
L LED-RESCUE-waterino D6
U 1 1 5928CC0E
P 5300 5250
F 0 "D6" H 5300 5350 50  0000 C CNN
F 1 "RX_LED" H 5300 5150 50  0000 C CNN
F 2 "LEDs:LED_1206" H 5300 5250 50  0001 C CNN
F 3 "" H 5300 5250 50  0000 C CNN
	1    5300 5250
	1    0    0    1   
$EndComp
$Comp
L R R7
U 1 1 5928CCC0
P 5650 5250
F 0 "R7" V 5730 5250 50  0000 C CNN
F 1 "150R" V 5650 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5580 5250 50  0001 C CNN
F 3 "" H 5650 5250 50  0000 C CNN
	1    5650 5250
	0    1    1    0   
$EndComp
$Comp
L CONN_02X02 P1
U 1 1 5929A575
P 2300 1200
F 0 "P1" H 2300 1350 50  0000 C CNN
F 1 "PUMP" H 2300 1050 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 2300 0   50  0001 C CNN
F 3 "" H 2300 0   50  0000 C CNN
	1    2300 1200
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR06
U 1 1 592A0DF0
P 2850 1900
F 0 "#PWR06" H 2850 1650 50  0001 C CNN
F 1 "GND" H 2850 1750 50  0000 C CNN
F 2 "" H 2850 1900 50  0000 C CNN
F 3 "" H 2850 1900 50  0000 C CNN
	1    2850 1900
	1    0    0    1   
$EndComp
Text Notes 1850 800  0    39   ~ 0
Reservoir Molex\n(Pump Power and Water Level Alert)
$Comp
L GND #PWR07
U 1 1 592B3AA1
P 5700 4000
F 0 "#PWR07" H 5700 3750 50  0001 C CNN
F 1 "GND" V 5700 3800 50  0000 C CNN
F 2 "" H 5700 4000 50  0000 C CNN
F 3 "" H 5700 4000 50  0000 C CNN
	1    5700 4000
	0    1    1    0   
$EndComp
Text GLabel 4050 5500 2    39   Input ~ 0
~OVRFLW
Text GLabel 7250 900  1    47   Input ~ 0
Vcc
Text GLabel 6400 5250 0    47   Input ~ 0
Vcc
Text GLabel 4850 4000 1    47   Input ~ 0
Vcc
Text GLabel 1100 1550 1    47   Input ~ 0
Vcc
Wire Wire Line
	1250 2000 1500 2000
Text GLabel 8050 5900 0    47   Input ~ 0
AVss
Text GLabel 2150 5800 0    47   Input ~ 0
AVss
Text GLabel 5700 3900 0    47   Input ~ 0
Vcc
Text GLabel 4050 5800 2    39   Input ~ 0
RX_LED
Text GLabel 4050 5900 2    39   Input ~ 0
TX_LED
Text GLabel 5100 5550 0    47   Input ~ 0
TX_LED
Text GLabel 5100 5250 0    47   Input ~ 0
RX_LED
Wire Wire Line
	5800 5250 5800 5550
Wire Wire Line
	5900 5400 5800 5400
Connection ~ 5800 5400
Text GLabel 5900 5400 2    47   Input ~ 0
Vcc
Text Notes 4800 5100 0    39   ~ 0
Yellow LED (2.1V, 20mA, 8mcd): \n(5V - 2.1V) / 20mA = 145 Ohm.\nPick 150 Ohm (E12)
Text Notes 4800 6150 0    39   ~ 0
Green LED (2.2V, 20mA, 15mcd): We want 8mcd brightness: \n(12V -0.7V - 2.2V) / (20mA * 8mcd/15mcd) = 853 Ohm.  \nPick 1.5K Ohm (E12, BOM reuse).
Text Notes 5500 3100 0    39   ~ 0
R3 forms a voltage voltage divider with the electrodes in the water. \nMy measurements put resistance of tap water at around 80-100k for\nsmall electrodes and around 2k for large electrodes (3cm galvanized screws).\nWe'll use large electrodes. The voltage at the divider when the electrodes \nare in water should be (internal pull-up disabled): \n\n    Vcc * 2k / 102k = Vcc*0.02 which will trigger a level interrupt on INT0\n\nATMega has 2.6V input threshold on pins and .5V hysteresis. \nEven 30K is safely within the trigger range.
Text Notes 1100 2750 0    39   ~ 0
Red LED (1.85V , 20mA, 80mcd): We want 8mcd brightness:\n(5V - 1.85V) / (20mA * 8mcd/80mcd) = 1575 Ohm.\nPick 1.5K Ohm (E12).
Text GLabel 6400 5350 0    47   Input ~ 0
RX
Text GLabel 6400 5450 0    47   Input ~ 0
TX
Text GLabel 4050 5300 2    39   Input ~ 0
RX
Text GLabel 4050 5400 2    39   Input ~ 0
TX
$Comp
L D D1
U 1 1 59321D7A
P 5750 900
F 0 "D1" H 5750 1000 50  0000 C CNN
F 1 "D" H 5750 800 50  0000 C CNN
F 2 "Diodes_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 5750 900 50  0001 C CNN
F 3 "" H 5750 900 50  0000 C CNN
	1    5750 900 
	-1   0    0    1   
$EndComp
Wire Wire Line
	5200 900  5600 900 
Wire Wire Line
	5250 900  5250 850 
Connection ~ 5250 900 
$Comp
L CP C2
U 1 1 59323AB3
P 5950 1100
F 0 "C2" H 5975 1200 50  0000 L CNN
F 1 "100µF" H 5700 1000 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 5988 950 50  0001 C CNN
F 3 "" H 5950 1100 50  0000 C CNN
	1    5950 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 950  7250 900 
Wire Wire Line
	6750 1200 6750 1350
Connection ~ 5950 900 
Wire Wire Line
	5200 1000 5200 1300
Wire Wire Line
	5950 950  5950 900 
Wire Wire Line
	5950 1250 5950 1350
$Comp
L CP C1
U 1 1 5932A26F
P 5550 1100
F 0 "C1" H 5575 1200 50  0000 L CNN
F 1 "100µF" H 5300 1000 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x7.7" H 5588 950 50  0001 C CNN
F 3 "" H 5550 1100 50  0000 C CNN
	1    5550 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 900  5550 950 
Connection ~ 5550 900 
Wire Wire Line
	5550 1250 5550 1300
Connection ~ 5550 1300
Text Label 3150 1000 0    47   ~ 0
PUMP-
Text Label 3150 1400 0    47   ~ 0
PUMP+
Wire Wire Line
	2400 1400 3450 1400
Wire Wire Line
	2400 1000 3450 1000
$Comp
L GND #PWR08
U 1 1 592EE26C
P 2250 1450
F 0 "#PWR08" H 2250 1200 50  0001 C CNN
F 1 "GND" H 2250 1300 50  0000 C CNN
F 2 "" H 2250 1450 50  0000 C CNN
F 3 "" H 2250 1450 50  0000 C CNN
	1    2250 1450
	0    1    1    0   
$EndComp
$Comp
L CONN_01X07 P2
U 1 1 592F857C
P 5900 4200
F 0 "P2" H 5900 4600 50  0000 C CNN
F 1 "PLANT" V 6000 4200 50  0000 C CNN
F 2 "Connectors_JST:JST_PH_S7B-PH-K_07x2.00mm_Angled" H 5900 4200 50  0001 C CNN
F 3 "" H 5900 4200 50  0000 C CNN
	1    5900 4200
	1    0    0    -1  
$EndComp
Text GLabel 4850 4400 0    39   Input ~ 0
~OVRFLW
$Comp
L R R10
U 1 1 592FE86B
P 8050 6050
F 0 "R10" V 8130 6050 50  0000 C CNN
F 1 "0" V 8050 6050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7980 6050 50  0001 C CNN
F 3 "" H 8050 6050 50  0000 C CNN
	1    8050 6050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG09
U 1 1 592FFE98
P 8050 5900
F 0 "#FLG09" H 8050 5995 50  0001 C CNN
F 1 "PWR_FLAG" H 8050 6080 50  0000 C CNN
F 2 "" H 8050 5900 50  0000 C CNN
F 3 "" H 8050 5900 50  0000 C CNN
	1    8050 5900
	1    0    0    -1  
$EndComp
Text GLabel 8950 5900 0    47   Input ~ 0
AVcc
$Comp
L PWR_FLAG #FLG010
U 1 1 59302DDD
P 8950 5900
F 0 "#FLG010" H 8950 5995 50  0001 C CNN
F 1 "PWR_FLAG" H 8950 6080 50  0000 C CNN
F 2 "" H 8950 5900 50  0000 C CNN
F 3 "" H 8950 5900 50  0000 C CNN
	1    8950 5900
	1    0    0    -1  
$EndComp
Text GLabel 7600 5900 0    47   Input ~ 0
PGND
$Comp
L PWR_FLAG #FLG011
U 1 1 5930AC6A
P 7600 5900
F 0 "#FLG011" H 7600 5995 50  0001 C CNN
F 1 "PWR_FLAG" H 7600 6080 50  0000 C CNN
F 2 "" H 7600 5900 50  0000 C CNN
F 3 "" H 7600 5900 50  0000 C CNN
	1    7600 5900
	1    0    0    -1  
$EndComp
Text GLabel 3450 1000 2    47   Input ~ 0
PGND
Text GLabel 5550 1300 3    47   Input ~ 0
PGND
$Comp
L GND #PWR012
U 1 1 5930E005
P 7600 6200
F 0 "#PWR012" H 7600 5950 50  0001 C CNN
F 1 "GND" H 7600 6050 50  0000 C CNN
F 2 "" H 7600 6200 50  0000 C CNN
F 3 "" H 7600 6200 50  0000 C CNN
	1    7600 6200
	1    0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 5930E0B4
P 7600 6050
F 0 "R9" V 7680 6050 50  0000 C CNN
F 1 "0" V 7600 6050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7530 6050 50  0001 C CNN
F 3 "" H 7600 6050 50  0000 C CNN
	1    7600 6050
	1    0    0    -1  
$EndComp
Text Label 2950 2200 2    60   ~ 0
COIL_PWR
Wire Wire Line
	2400 1400 2400 1450
Wire Wire Line
	2400 1450 2350 1450
Wire Wire Line
	2350 950  2400 950 
Wire Wire Line
	2400 950  2400 1000
Connection ~ 2850 1900
Text Notes 7350 4900 0    39   ~ 0
AVcc LC circuit taken from AVR datasheet.
$Comp
L R R11
U 1 1 593391B6
P 5300 6350
F 0 "R11" V 5400 6350 50  0000 C CNN
F 1 "1.5K" V 5300 6350 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5230 6350 50  0001 C CNN
F 3 "" H 5300 6350 50  0000 C CNN
	1    5300 6350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2350 2000 2350 2200
Wire Wire Line
	2350 2200 4050 2200
Wire Wire Line
	4050 2200 4050 1900
Connection ~ 3250 2200
Wire Wire Line
	2350 1900 3450 1900
Connection ~ 3250 1900
Connection ~ 6250 900 
$Comp
L C C3
U 1 1 59347036
P 6250 1100
F 0 "C3" H 6275 1200 50  0000 L CNN
F 1 "100nF" H 6275 1000 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 6288 950 50  0001 C CNN
F 3 "" H 6250 1100 50  0000 C CNN
	1    6250 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 900  6250 950 
Wire Wire Line
	6250 1250 6250 1350
$Comp
L FINDER-32.21-x300 RL1
U 1 1 5934B795
P 3750 1700
F 0 "RL1" H 4200 1850 50  0000 L CNN
F 1 "FINDER-32.21-x300" V 3800 1350 50  0000 L CNN
F 2 "Relays_THT:Relay_SPST_Finder_32.21-x300" H 3750 1700 50  0001 C CNN
F 3 "" H 3750 1700 50  0000 C CNN
	1    3750 1700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3000 1050 3000 1000
Connection ~ 3000 1000
Connection ~ 3000 1400
Text Notes 2650 2300 0    60   ~ 0
40mA @ 5V
Text Notes 1850 1350 2    39   ~ 0
IC Max 20 µA \nNominal 40mA from relay
Text Notes 7600 1950 0    39   ~ 0
5V Load Summary:\nMCU: 2MHz@5V  < 2mA active \nMoisture probe: 5V/10KR = 500µA\nOverflow sensor: 5V/100KR = 50µA when shorted   \nLevel alert:  50µA when active (pullup from ground)\nThermal probe 10mA max when measuring.\nPump relay 40mA (nominal)\nPump LED max 2mA.\nMIC94090 20µA\nRX/TX should be low but max 40mA total\nRX/TX LED max 40mA total. \n\nTotal MAX: < 140 mA \nTypical Sleepl: <  100µA\nTypical Active: < 70 mA\n\nThermal dissipation LM7805:\nMax: (12- 0.6 - 5) *0.140 = 896mW\nTypical Sleep: (12- 0.6 - 5) *0.0001 = 0.64mW\nTypical Active: (12- 0.6 - 5) *0.070 = 448mW \nTO220 package safe dissipation without heat sink 1W.\n
Wire Wire Line
	5550 1300 5200 1300
$Comp
L CONN_02X03 J1
U 1 1 5934CF0B
P 6800 3900
F 0 "J1" H 6800 4100 50  0000 C CNN
F 1 "ICSP" H 6800 3700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 6800 2700 50  0001 C CNN
F 3 "" H 6800 2700 50  0001 C CNN
	1    6800 3900
	1    0    0    -1  
$EndComp
Text GLabel 6550 3800 0    39   Input ~ 0
MISO
Text GLabel 6550 3900 0    39   Input ~ 0
SCK
Text GLabel 6550 4000 0    39   Input ~ 0
~RESET
Text GLabel 7050 3800 2    39   Input ~ 0
Vcc
Text GLabel 7050 3900 2    39   Input ~ 0
MOSI
$Comp
L GND #PWR013
U 1 1 5934D270
P 7050 4000
F 0 "#PWR013" H 7050 3750 50  0001 C CNN
F 1 "GND" H 7050 3850 50  0000 C CNN
F 2 "" H 7050 4000 50  0000 C CNN
F 3 "" H 7050 4000 50  0000 C CNN
	1    7050 4000
	1    0    0    -1  
$EndComp
Text GLabel 4050 4100 2    39   Input ~ 0
MISO
Text GLabel 4050 4200 2    39   Input ~ 0
SCK
Text GLabel 4050 5050 2    39   Input ~ 0
THERM
Text GLabel 4050 4000 2    39   Input ~ 0
MOSI
Wire Wire Line
	7250 1250 7250 1350
Text GLabel 6250 900  1    39   Input ~ 0
REG_PWR
Text GLabel 5150 6350 0    39   Input ~ 0
REG_PWR
$Comp
L GND #PWR014
U 1 1 593593C4
P 5850 6350
F 0 "#PWR014" H 5850 6100 50  0001 C CNN
F 1 "GND" H 5850 6200 50  0000 C CNN
F 2 "" H 5850 6350 50  0000 C CNN
F 3 "" H 5850 6350 50  0000 C CNN
	1    5850 6350
	1    0    0    -1  
$EndComp
Text GLabel 7650 5150 0    47   Input ~ 0
Vcc
$Comp
L INDUCTOR_SMALL L1
U 1 1 5935DA81
P 7900 5150
F 0 "L1" H 7900 5250 50  0000 C CNN
F 1 "10µH" H 7900 5100 50  0000 C CNN
F 2 "Inductors_THT:L_Axial_L7.0mm_D3.3mm_P10.16mm_Horizontal_Fastron_MICC" H 7900 5150 50  0001 C CNN
F 3 "" H 7900 5150 50  0000 C CNN
	1    7900 5150
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 5935DB3D
P 8300 5150
F 0 "C11" H 8325 5250 50  0000 L CNN
F 1 "100nF" V 8450 4900 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 8338 5000 50  0001 C CNN
F 3 "" H 8300 5150 50  0000 C CNN
	1    8300 5150
	0    -1   -1   0   
$EndComp
Text GLabel 8450 5150 2    47   Input ~ 0
AVss
Text GLabel 8150 5150 3    47   Input ~ 0
AVcc
$Comp
L GND #PWR015
U 1 1 5935EACE
P 6750 1350
F 0 "#PWR015" H 6750 1100 50  0001 C CNN
F 1 "GND" H 6750 1200 50  0000 C CNN
F 2 "" H 6750 1350 50  0000 C CNN
F 3 "" H 6750 1350 50  0000 C CNN
	1    6750 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 900  6350 900 
Connection ~ 6750 1350
Connection ~ 6250 1350
$Comp
L R R2
U 1 1 59369493
P 8900 3850
F 0 "R2" V 8980 3850 50  0000 C CNN
F 1 "4k7" V 8900 3850 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8830 3850 50  0001 C CNN
F 3 "" H 8900 3850 50  0000 C CNN
	1    8900 3850
	-1   0    0    1   
$EndComp
$Comp
L C C6
U 1 1 59369607
P 8900 4350
F 0 "C6" H 8925 4450 50  0000 L CNN
F 1 "100nF" H 8925 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 8938 4200 50  0001 C CNN
F 3 "" H 8900 4350 50  0000 C CNN
	1    8900 4350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 593696CD
P 8900 4500
F 0 "#PWR016" H 8900 4250 50  0001 C CNN
F 1 "GND" H 8900 4350 50  0000 C CNN
F 2 "" H 8900 4500 50  0000 C CNN
F 3 "" H 8900 4500 50  0000 C CNN
	1    8900 4500
	1    0    0    -1  
$EndComp
Text GLabel 9150 4100 2    39   Input ~ 0
~RESET
Text GLabel 4050 5600 2    39   Input ~ 0
~LEVEL_ALERT
$Comp
L D_Schottky D5
U 1 1 5936D8F4
P 9150 3850
F 0 "D5" H 9150 3950 50  0000 C CNN
F 1 "D_Schottky" H 9150 3750 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 9150 3850 50  0001 C CNN
F 3 "" H 9150 3850 50  0001 C CNN
	1    9150 3850
	0    1    1    0   
$EndComp
Text GLabel 8900 3600 1    47   Input ~ 0
Vcc
Wire Wire Line
	9150 3600 9150 3700
Connection ~ 8900 3600
Wire Wire Line
	9150 4100 9150 4000
Wire Wire Line
	8900 4000 8900 4200
$Comp
L R R4
U 1 1 5936EA26
P 8650 4100
F 0 "R4" V 8730 4100 50  0000 C CNN
F 1 "150" V 8650 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8580 4100 50  0001 C CNN
F 3 "" H 8650 4100 50  0000 C CNN
	1    8650 4100
	0    -1   -1   0   
$EndComp
Connection ~ 8900 4100
$Comp
L GND #PWR017
U 1 1 5936ECA8
P 7550 4100
F 0 "#PWR017" H 7550 3850 50  0001 C CNN
F 1 "GND" H 7550 3950 50  0000 C CNN
F 2 "" H 7550 4100 50  0000 C CNN
F 3 "" H 7550 4100 50  0000 C CNN
	1    7550 4100
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D3
U 1 1 5936FBB6
P 3250 2050
F 0 "D3" H 3250 2150 50  0000 C CNN
F 1 "D_Schottky" H 3250 1950 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 3250 2050 50  0001 C CNN
F 3 "" H 3250 2050 50  0001 C CNN
	1    3250 2050
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 593710E5
P 8300 4100
F 0 "R3" V 8380 4100 50  0000 C CNN
F 1 "150" V 8300 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8230 4100 50  0001 C CNN
F 3 "" H 8300 4100 50  0000 C CNN
	1    8300 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8450 4100 8500 4100
Text GLabel 2250 950  0    39   Input ~ 0
~LEVEL_ALERT
Text Notes 1750 1000 2    39   ~ 0
Level alert is debounced\nin software.
Text Notes 7800 3700 0    39   ~ 0
Recommended reset circuit\nfrom AVR HW considerations.
$Comp
L C C5
U 1 1 59377CB1
P 1100 1700
F 0 "C5" H 1125 1800 50  0000 L CNN
F 1 "100nF" V 950 1600 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1138 1550 50  0001 C CNN
F 3 "" H 1100 1700 50  0000 C CNN
	1    1100 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 1800 1500 1800
Wire Wire Line
	1100 1550 1400 1550
Wire Wire Line
	1400 1550 1400 1800
Wire Wire Line
	1050 1900 1500 1900
Wire Wire Line
	1100 1850 1100 1900
Connection ~ 1100 1900
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
Text GLabel 2150 4000 0    47   Input ~ 0
AVcc
$Comp
L C C9
U 1 1 5937AF02
P 1550 4950
F 0 "C9" H 1575 5050 50  0000 L CNN
F 1 "100nF" V 1400 4850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1588 4800 50  0001 C CNN
F 3 "" H 1550 4950 50  0000 C CNN
	1    1550 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 3800 2150 3800
Wire Wire Line
	1550 3800 1550 4800
Connection ~ 1850 3800
Wire Wire Line
	1550 5900 2150 5900
Wire Wire Line
	1550 5900 1550 5100
Connection ~ 1850 5900
$Comp
L C C7
U 1 1 5937B7FA
P 850 4950
F 0 "C7" H 875 5050 50  0000 L CNN
F 1 "100nF" V 700 4850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 888 4800 50  0001 C CNN
F 3 "" H 850 4950 50  0000 C CNN
	1    850  4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  3700 2150 3700
Wire Wire Line
	850  3700 850  4800
Connection ~ 1150 3700
Wire Wire Line
	850  6000 2150 6000
Wire Wire Line
	850  5100 850  6000
Connection ~ 1150 6000
Text GLabel 850  3700 0    47   Input ~ 0
Vcc
Text GLabel 1550 3800 0    47   Input ~ 0
Vcc
Text GLabel 4050 5150 2    39   Input ~ 0
~RESET
$Comp
L GND #PWR018
U 1 1 5937E3F4
P 1150 6000
F 0 "#PWR018" H 1150 5750 50  0001 C CNN
F 1 "GND" H 1150 5850 50  0000 C CNN
F 2 "" H 1150 6000 50  0000 C CNN
F 3 "" H 1150 6000 50  0000 C CNN
	1    1150 6000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR019
U 1 1 5937E492
P 1550 5900
F 0 "#PWR019" H 1550 5650 50  0001 C CNN
F 1 "GND" H 1550 5750 50  0000 C CNN
F 2 "" H 1550 5900 50  0000 C CNN
F 3 "" H 1550 5900 50  0000 C CNN
	1    1550 5900
	0    1    1    0   
$EndComp
Text GLabel 4050 4750 2    39   Input ~ 0
MOIST+
Text GLabel 4050 4950 2    39   Input ~ 0
MOIST-
Text GLabel 4050 4850 2    39   Input ~ 0
MOISTURE
Text GLabel 5300 3800 1    39   Input ~ 0
MOIST+
Text GLabel 5700 4200 0    39   Input ~ 0
MOIST-
Wire Wire Line
	5300 4100 5700 4100
Text GLabel 5700 4300 0    39   Input ~ 0
THERM
Text Notes 4650 3400 0    39   ~ 0
Pot Connector\n(Moisture, Thermal and Overflow)
Wire Wire Line
	8900 3600 8900 3700
Wire Wire Line
	9150 3600 8900 3600
Wire Wire Line
	8800 4100 9150 4100
Wire Wire Line
	4850 4300 4850 4400
Wire Wire Line
	4850 4400 5700 4400
Wire Wire Line
	7250 900  7150 900 
Wire Wire Line
	7250 1350 5950 1350
Text GLabel 4050 4550 2    39   Input ~ 0
EXT_A0
Text GLabel 4050 4650 2    39   Input ~ 0
EXT_A1
Text GLabel 4050 3700 2    39   Input ~ 0
EXT_D0
Text GLabel 4050 3800 2    39   Input ~ 0
EXT_D1
Text GLabel 4050 3900 2    39   Input ~ 0
EXT_D2
Text GLabel 4050 4300 2    39   Input ~ 0
EXT_D6
Text GLabel 4050 4400 2    39   Input ~ 0
EXT_D7
Text GLabel 4050 6000 2    39   Input ~ 0
EXT_D8
Text GLabel 2150 5050 0    39   Input ~ 0
EXT_A2
Text GLabel 2150 5150 0    39   Input ~ 0
EXT_A3
$Comp
L C C12
U 1 1 5939665B
P 2150 4450
F 0 "C12" H 2175 4550 50  0000 L CNN
F 1 "10nF" V 2000 4350 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2188 4300 50  0001 C CNN
F 3 "" H 2150 4450 50  0000 C CNN
	1    2150 4450
	1    0    0    -1  
$EndComp
Text GLabel 2150 4600 0    47   Input ~ 0
AVss
$Comp
L GND #PWR020
U 1 1 5939B8CA
P 5700 4500
F 0 "#PWR020" H 5700 4250 50  0001 C CNN
F 1 "GND" V 5700 4300 50  0000 C CNN
F 2 "" H 5700 4500 50  0000 C CNN
F 3 "" H 5700 4500 50  0000 C CNN
	1    5700 4500
	0    1    1    0   
$EndComp
Text GLabel 4350 6450 0    39   Input ~ 0
EXT_D0
Text GLabel 4350 6550 0    39   Input ~ 0
EXT_D1
Text GLabel 4350 6650 0    39   Input ~ 0
EXT_D2
Text GLabel 4350 6750 0    39   Input ~ 0
MOSI
Text GLabel 4350 6850 0    39   Input ~ 0
MISO
Text GLabel 4350 6950 0    39   Input ~ 0
SCK
Text GLabel 4350 7050 0    39   Input ~ 0
EXT_D6
Text GLabel 4350 7150 0    39   Input ~ 0
EXT_D7
Text GLabel 4350 7250 0    39   Input ~ 0
EXT_D8
$Comp
L CONN_01X12 J3
U 1 1 593B8A5F
P 4550 7000
F 0 "J3" H 4550 7650 50  0000 C CNN
F 1 "EXT_A" V 4650 7000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x12_Pitch2.54mm" H 4550 7000 50  0001 C CNN
F 3 "" H 4550 7000 50  0001 C CNN
	1    4550 7000
	1    0    0    -1  
$EndComp
Text GLabel 4350 7350 0    47   Input ~ 0
Vcc
$Comp
L GND #PWR021
U 1 1 593B8CAF
P 4350 7550
F 0 "#PWR021" H 4350 7300 50  0001 C CNN
F 1 "GND" V 4350 7350 50  0000 C CNN
F 2 "" H 4350 7550 50  0000 C CNN
F 3 "" H 4350 7550 50  0000 C CNN
	1    4350 7550
	0    1    1    0   
$EndComp
Text GLabel 4350 7450 0    39   Input ~ 0
~RESET
Text GLabel 3250 6800 0    47   Input ~ 0
Vcc
$Comp
L GND #PWR022
U 1 1 593BB108
P 3250 6900
F 0 "#PWR022" H 3250 6650 50  0001 C CNN
F 1 "GND" V 3250 6700 50  0000 C CNN
F 2 "" H 3250 6900 50  0000 C CNN
F 3 "" H 3250 6900 50  0000 C CNN
	1    3250 6900
	0    1    1    0   
$EndComp
Text GLabel 3250 6400 0    39   Input ~ 0
EXT_A0
$Comp
L CONN_01X06 J2
U 1 1 593BB371
P 3450 6650
F 0 "J2" H 3450 7000 50  0000 C CNN
F 1 "EXT_B" V 3550 6650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x06_Pitch2.54mm" H 3450 6650 50  0001 C CNN
F 3 "" H 3450 6650 50  0001 C CNN
	1    3450 6650
	1    0    0    -1  
$EndComp
Text GLabel 3250 6500 0    39   Input ~ 0
EXT_A1
Text GLabel 3250 6600 0    39   Input ~ 0
EXT_A2
Text GLabel 3250 6700 0    39   Input ~ 0
EXT_A3
Text GLabel 8050 6200 0    47   Input ~ 0
PGND
$Comp
L D_Schottky_AKA D2
U 1 1 593C27E0
P 3000 1250
F 0 "D2" H 3000 1350 50  0000 C CNN
F 1 "D_Schottky_AKA" H 3000 1150 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2_Rectifier" H 3000 1250 50  0001 C CNN
F 3 "" H 3000 1250 50  0001 C CNN
	1    3000 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2900 1050 2900 1000
Connection ~ 2900 1000
$EndSCHEMATC
