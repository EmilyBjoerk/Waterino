EESchema Schematic File Version 4
LIBS:node-cache
EELAYER 26 0
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
Text GLabel 950  2800 0    39   Input ~ 0
Vin
Text GLabel 2050 2800 2    39   Input ~ 0
Vcc
Text GLabel 3650 6400 0    39   Input ~ 0
RST
Text GLabel 3650 6300 0    39   Input ~ 0
SCK
Text GLabel 4150 6300 2    39   Input ~ 0
MOSI
Text GLabel 10200 1850 2    39   Output ~ 0
TEMP_SENSE
Text GLabel 3650 6200 0    39   Input ~ 0
MISO
Text GLabel 4150 6200 2    39   Input ~ 0
Vin
Text GLabel 3200 5250 2    39   Input ~ 0
MISO
Text GLabel 3200 5350 2    39   Input ~ 0
SCK
Text GLabel 3200 6350 2    39   Input ~ 0
RST
Text GLabel 3200 5150 2    39   Input ~ 0
MOSI
Text GLabel 3200 6550 2    39   Input ~ 0
RX
Text GLabel 3200 6650 2    39   Input ~ 0
TX
Text GLabel 4150 6100 2    39   Input ~ 0
RX
Text GLabel 3650 6100 0    39   Input ~ 0
TX
Text GLabel 2500 4450 0    39   Input ~ 0
Vcc
Text Notes 650  2000 0    47   ~ 0
Power stage 
Text Notes 2700 2600 0    39   ~ 0
Design goals for power input:\n* External regulation\n* Low power loss at nominal 5V Vin\n* Reverse polarity protection\n* Transient suppression/Overvoltage protection (short events)\n* Nominally 5 V in at max 20 mA (100 mW) sustained\n* Max 6 V to device\n* Min Vin - 0.4 V to device for 5 V Vin 
Text Notes 700  3450 0    39   ~ 0
BZT52C5V6 Zener\nVz nom = 5.6\nVz min = 5.2\nVz max = 6.0
Text Notes 1900 2550 0    39   ~ 0
SI2323DS PMOS\nVds = -20 V\nVgs = +-8 V\nIs = -600 mA\nId = -2.9 A\nVt = -1 V (max)\nVbr,dss = -20 V\n\nBody diode oriented to\nblock reverse polarity.
Text Notes 650  2550 0    39   ~ 0
PRG18BB330MB1RB Fuse\nIhold,trip = 18 mA, 90 mA\nVmax = 24 V\nImax = 900 mA\nTtT@8 A = 100 ms\nR = 33 R (Vcc min 4.57 V)\n
Text GLabel 3850 1100 2    39   Output ~ 0
OVF_SENSE
Text GLabel 9600 2350 0    39   Input ~ 0
~TEMP_EXC
$Comp
L Connector:Screw_Terminal_01x02 J30
U 1 1 5B9F2DD9
P 11000 5650
F 0 "J30" H 11000 5750 50  0000 C CNN
F 1 "PUMP" H 11050 5450 50  0000 C CNN
F 2 "TerminalBlock_RND:TerminalBlock_RND_205-00045_1x02_P5.00mm_Horizontal" H 11000 5650 50  0001 C CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Phoenix%20Contact%20PDFs/1935161.pdf" H 11000 5650 50  0001 C CNN
	1    11000 5650
	1    0    0    1   
$EndComp
Text GLabel 3900 4700 0    39   Input ~ 0
LED_EN
$Comp
L Interface_Expansion:P82B96 U4
U 1 1 5CD8AECD
P 6600 3100
F 0 "U4" H 6600 3717 50  0000 C CNN
F 1 "P82B96" H 6600 3626 50  0000 C CNN
F 2 "Package_SO:TSSOP-8_3x3mm_P0.65mm" H 6600 3100 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/P82B96.pdf" H 6600 3100 50  0001 C CNN
	1    6600 3100
	1    0    0    -1  
$EndComp
$Comp
L MCU_Microchip_ATmega:ATmega328P-AU U1
U 1 1 5CD9EB9C
P 2600 6050
F 0 "U1" H 2300 4600 50  0000 C CNN
F 1 "ATmega328P-AU" H 3000 4600 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 2600 6050 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 2600 6050 50  0001 C CNN
	1    2600 6050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5CD9F04D
P 2600 7550
F 0 "#PWR0101" H 2600 7300 50  0001 C CNN
F 1 "GND" H 2605 7377 50  0000 C CNN
F 2 "" H 2600 7550 50  0001 C CNN
F 3 "" H 2600 7550 50  0001 C CNN
	1    2600 7550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5CDA52CE
P 4250 6500
F 0 "#PWR0102" H 4250 6250 50  0001 C CNN
F 1 "GND" H 4255 6327 50  0000 C CNN
F 2 "" H 4250 6500 50  0001 C CNN
F 3 "" H 4250 6500 50  0001 C CNN
	1    4250 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C10
U 1 1 5CDD7B12
P 1300 5100
F 0 "C10" H 1392 5146 50  0000 L CNN
F 1 "100nF" H 1392 5055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1300 5100 50  0001 C CNN
F 3 "~" H 1300 5100 50  0001 C CNN
	1    1300 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5CDE6871
P 1300 5300
F 0 "#PWR0103" H 1300 5050 50  0001 C CNN
F 1 "GND" H 1305 5127 50  0000 C CNN
F 2 "" H 1300 5300 50  0001 C CNN
F 3 "" H 1300 5300 50  0001 C CNN
	1    1300 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 5000 1300 4850
$Comp
L Device:LED D10
U 1 1 5CE1B6E1
P 3900 4950
F 0 "D10" V 3950 5050 50  0000 L CNN
F 1 "LED" V 3850 5050 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3900 4950 50  0001 C CNN
F 3 "~" H 3900 4950 50  0001 C CNN
	1    3900 4950
	0    -1   -1   0   
$EndComp
NoConn ~ 2000 5150
Wire Wire Line
	1300 4850 2000 4850
Text Label 8000 6050 0    39   ~ 0
PROBE_A
$Comp
L power:+12V #PWR0104
U 1 1 5CECD324
P 9100 5450
F 0 "#PWR0104" H 9100 5300 50  0001 C CNN
F 1 "+12V" H 9115 5623 50  0000 C CNN
F 2 "" H 9100 5450 50  0001 C CNN
F 3 "" H 9100 5450 50  0001 C CNN
	1    9100 5450
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D30
U 1 1 5CEF7485
P 10500 5850
F 0 "D30" H 10500 6066 50  0000 C CNN
F 1 "D_FLYBACK" H 10500 5950 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-123" H 10500 5850 50  0001 C CNN
F 3 "~" H 10500 5850 50  0001 C CNN
	1    10500 5850
	0    1    1    0   
$EndComp
$Comp
L Device:Thermistor_NTC TH50
U 1 1 5CFC3A2A
P 9700 2100
F 0 "TH50" H 9550 2150 50  0000 R CNN
F 1 "10K (4067K)" H 9550 2050 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9700 2150 50  0001 C CNN
F 3 "~" H 9700 2150 50  0001 C CNN
	1    9700 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R50
U 1 1 5CFC3CA5
P 9700 1650
F 0 "R50" H 9550 1700 50  0000 R CNN
F 1 "10K" H 9550 1600 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9700 1650 50  0001 C CNN
F 3 "~" H 9700 1650 50  0001 C CNN
	1    9700 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C50
U 1 1 5CFC3F46
P 9900 2100
F 0 "C50" H 9992 2146 50  0000 L CNN
F 1 "100nF" H 9992 2055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9900 2100 50  0001 C CNN
F 3 "~" H 9900 2100 50  0001 C CNN
	1    9900 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 1450 9700 1450
Wire Wire Line
	9700 1450 9700 1550
Wire Wire Line
	9700 1750 9700 1850
Wire Wire Line
	9600 2350 9700 2350
Wire Wire Line
	9700 2350 9700 2250
Wire Wire Line
	9700 1850 9900 1850
Wire Wire Line
	9900 1850 9900 2000
Connection ~ 9700 1850
Wire Wire Line
	9700 1850 9700 1950
Wire Wire Line
	9900 1850 10000 1850
Connection ~ 9900 1850
$Comp
L power:GND #PWR0105
U 1 1 5CFF271E
P 9900 2350
F 0 "#PWR0105" H 9900 2100 50  0001 C CNN
F 1 "GND" H 9905 2177 50  0000 C CNN
F 2 "" H 9900 2350 50  0001 C CNN
F 3 "" H 9900 2350 50  0001 C CNN
	1    9900 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 2350 9900 2200
Wire Wire Line
	4150 6400 4250 6400
Wire Wire Line
	4250 6400 4250 6500
$Comp
L Device:D_Zener D0
U 1 1 5D056F99
P 1350 3050
F 0 "D0" V 1300 2950 50  0000 R CNN
F 1 "BZT52C5V6" V 1400 2950 50  0000 R CNN
F 2 "Diode_SMD:D_SOD-123" H 1350 3050 50  0001 C CNN
F 3 "~" H 1350 3050 50  0001 C CNN
	1    1350 3050
	0    1    1    0   
$EndComp
$Comp
L Device:Fuse_Small F0
U 1 1 5D0573D4
P 1150 2800
F 0 "F0" H 1150 2985 50  0000 C CNN
F 1 "Fuse_Small" H 1150 2894 50  0000 C CNN
F 2 "Fuse:Fuse_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1150 2800 50  0001 C CNN
F 3 "https://www.murata.com/en-us/api/pdfdownloadapi?cate=luPTCforCircuProte&partno=PRG18BB330MB1RB" H 1150 2800 50  0001 C CNN
	1    1150 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_PMOS_GSD Q0
U 1 1 5D06F661
P 1650 2900
F 0 "Q0" V 1993 2900 50  0000 C CNN
F 1 "SI2323DS" V 1902 2900 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23W_Handsoldering" H 1850 3000 50  0001 C CNN
F 3 "~" H 1650 2900 50  0001 C CNN
	1    1650 2900
	0    -1   -1   0   
$EndComp
$Comp
L emilibeda:TPS22810 U3
U 1 1 5CEA66E3
P 9600 5650
F 0 "U3" H 9600 6015 50  0000 C CNN
F 1 "TPS22810" H 9600 5924 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6_Handsoldering" H 9350 5650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tps22810.pdf" H 9350 5650 50  0001 C CNN
	1    9600 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C30
U 1 1 5CEAEF32
P 10100 5950
F 0 "C30" H 10050 5900 50  0000 R CNN
F 1 "100nF" H 10050 6000 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10100 5950 50  0001 C CNN
F 3 "~" H 10100 5950 50  0001 C CNN
	1    10100 5950
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5CEBDE1C
P 10100 6250
F 0 "#PWR0106" H 10100 6000 50  0001 C CNN
F 1 "GND" H 10105 6077 50  0000 C CNN
F 2 "" H 10100 6250 50  0001 C CNN
F 3 "" H 10100 6250 50  0001 C CNN
	1    10100 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 6250 10100 6150
Wire Wire Line
	10100 5850 10100 5750
Wire Wire Line
	10100 5750 10000 5750
Wire Wire Line
	10100 6150 10500 6150
Wire Wire Line
	10800 6150 10800 5650
Connection ~ 10100 6150
Wire Wire Line
	10100 6150 10100 6050
Wire Wire Line
	10800 5550 10500 5550
Wire Wire Line
	10000 5650 10100 5650
Wire Wire Line
	10500 5700 10500 5550
Connection ~ 10500 5550
Wire Wire Line
	10500 6000 10500 6150
Connection ~ 10500 6150
Wire Wire Line
	10500 6150 10800 6150
Wire Wire Line
	9200 5650 9000 5650
Wire Wire Line
	9000 5650 9000 6150
Wire Wire Line
	9000 6150 9100 6150
Wire Wire Line
	9100 5450 9100 5550
Wire Wire Line
	9100 5550 9200 5550
Text GLabel 8850 5750 0    39   Input ~ 0
PUMP_EN
Wire Wire Line
	8850 5750 9100 5750
$Comp
L Device:R_Small R30
U 1 1 5CF22F7D
P 9100 5950
F 0 "R30" H 9159 5996 50  0000 L CNN
F 1 "100K" H 9159 5905 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9100 5950 50  0001 C CNN
F 3 "~" H 9100 5950 50  0001 C CNN
	1    9100 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 5850 9100 5750
Connection ~ 9100 5750
Wire Wire Line
	9100 5750 9200 5750
Wire Wire Line
	9100 6050 9100 6150
Connection ~ 9100 6150
Wire Wire Line
	9100 6150 10100 6150
$Comp
L Device:R_Small R12
U 1 1 5CF54292
P 3900 5300
F 0 "R12" H 3800 5350 50  0000 R CNN
F 1 "1K" H 3800 5250 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3900 5300 50  0001 C CNN
F 3 "~" H 3900 5300 50  0001 C CNN
	1    3900 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 5200 3900 5100
$Comp
L power:GND #PWR0107
U 1 1 5CF56DA0
P 3900 5500
F 0 "#PWR0107" H 3900 5250 50  0001 C CNN
F 1 "GND" H 3905 5327 50  0000 C CNN
F 2 "" H 3900 5500 50  0001 C CNN
F 3 "" H 3900 5500 50  0001 C CNN
	1    3900 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 5500 3900 5400
$Comp
L Timer:LMC555xM U2
U 1 1 5CF5FABA
P 6600 5850
F 0 "U2" H 6650 5500 50  0000 L CNN
F 1 "LMC555xM" H 6650 5400 50  0000 L CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 6600 5850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lmc555.pdf" H 6600 5850 50  0001 C CNN
	1    6600 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R21
U 1 1 5CF65EBF
P 5800 5350
F 0 "R21" V 5700 5450 50  0000 R CNN
F 1 "1M" V 5600 5450 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5800 5350 50  0001 C CNN
F 3 "~" H 5800 5350 50  0001 C CNN
	1    5800 5350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5CF65FF5
P 6600 6450
F 0 "#PWR0108" H 6600 6200 50  0001 C CNN
F 1 "GND" H 6605 6277 50  0000 C CNN
F 2 "" H 6600 6450 50  0001 C CNN
F 3 "" H 6600 6450 50  0001 C CNN
	1    6600 6450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C21
U 1 1 5CF66930
P 6000 6250
F 0 "C21" H 5900 6200 50  0000 R CNN
F 1 "10nF" H 5900 6300 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6000 6250 50  0001 C CNN
F 3 "~" H 6000 6250 50  0001 C CNN
	1    6000 6250
	-1   0    0    1   
$EndComp
Wire Wire Line
	6100 6050 5600 6050
Wire Wire Line
	6600 5250 6600 5450
Wire Wire Line
	7100 6050 7200 6050
$Comp
L Device:R_Small R22
U 1 1 5CF8A5FA
P 7200 5850
F 0 "R22" H 7250 5900 50  0000 L CNN
F 1 "100K" H 7250 5800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7200 5850 50  0001 C CNN
F 3 "~" H 7200 5850 50  0001 C CNN
	1    7200 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 5650 7200 5650
NoConn ~ 7100 5850
Wire Wire Line
	6000 6150 6000 5850
Wire Wire Line
	6000 5850 6100 5850
Wire Wire Line
	6000 6350 6000 6450
Wire Wire Line
	6000 6450 6600 6450
Wire Wire Line
	6600 6450 6600 6250
Connection ~ 6600 6450
Wire Wire Line
	7200 5650 7200 5750
Wire Wire Line
	7200 5650 7700 5650
Connection ~ 7200 5650
Text GLabel 7700 5650 2    39   Output ~ 0
F_PROBE
Wire Wire Line
	7200 5950 7200 6050
Connection ~ 7200 6050
Wire Wire Line
	7200 6050 7600 6050
$Comp
L Device:C_Small C20
U 1 1 5CFFBCF2
P 5600 6250
F 0 "C20" H 5500 6300 50  0000 R CNN
F 1 "100nF" H 5500 6200 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5600 6250 50  0001 C CNN
F 3 "~" H 5600 6250 50  0001 C CNN
	1    5600 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 6050 5600 6150
Wire Wire Line
	5600 6350 5600 6450
Wire Wire Line
	5600 6450 6000 6450
Connection ~ 6000 6450
Connection ~ 7600 6050
Text Label 8000 6450 0    39   ~ 0
PROBE_K
$Comp
L Device:R_Small R24
U 1 1 5D023E18
P 7250 6450
F 0 "R24" V 7050 6350 50  0000 L CNN
F 1 "0R" V 7150 6350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7250 6450 50  0001 C CNN
F 3 "~" H 7250 6450 50  0001 C CNN
	1    7250 6450
	0    1    1    0   
$EndComp
Wire Wire Line
	3900 4700 3900 4800
$Comp
L Device:R_Small R20
U 1 1 5D06203A
P 5250 6050
F 0 "R20" V 5450 6150 50  0000 R CNN
F 1 "125R" V 5350 6150 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5250 6050 50  0001 C CNN
F 3 "~" H 5250 6050 50  0001 C CNN
	1    5250 6050
	0    -1   -1   0   
$EndComp
Text Notes 4750 5100 0    39   ~ 0
555 in astable, 50-50 duty cycle configuration with the soil sensor as the timing capacitor.\nOutput frequency: 1/(ln(2)*2*R*C) Hz; Output voltage swing: 1/3*Vcc Vpp.\nWe want F_PROBE(max) < F_CPU / 4 = 2 MHz. We expect C_PROBE(min) > 2 pF and we F_PROBE = 1/(ln(2)*2*C*R).\nWhich gives R < 180 K Ohm. With C_PROBE(max) < 300 pF and F_PROBE(min) > 100 KHz we have R > 24 K Ohm.\nWe pick R = 100K.\n\nPower usage: IC itself draws at most 400 uA. Timing cap draws at most Vcc/3 * Cmax * Fmax = 1 mA.\nR draws at most  2/3*Vcc / 100K = 33 uA.\n\nIn total worst case draw is: 2 mA. GPIO pin of ATmega328 can source 40 mA maximally. We can safely\npower the timer circuit from a GPIO pin.\n\nGPIO pin has around 25 R output impedence, to limit the inrush current to 40mA we need a 125 R series\nresistance minimum. At max power draw the 555 will see 5 - 0.002*150 = 4.7 V comfortably above the\n1.5 V minimum supply. The output frequency does not depend on the supply voltage.
Text GLabel 5050 6050 0    39   Input ~ 0
F_PROBE_EN
$Comp
L Device:R_Small R51
U 1 1 5D073814
P 10100 1850
F 0 "R51" V 9900 1750 50  0000 L CNN
F 1 "100K" V 10000 1750 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10100 1850 50  0001 C CNN
F 3 "~" H 10100 1850 50  0001 C CNN
	1    10100 1850
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R43
U 1 1 5CEDC473
P 5800 3200
F 0 "R43" V 5700 3050 50  0000 L CNN
F 1 "1K" V 5700 3250 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5800 3200 50  0001 C CNN
F 3 "~" H 5800 3200 50  0001 C CNN
	1    5800 3200
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R42
U 1 1 5CEDC553
P 5800 3000
F 0 "R42" V 5700 2850 50  0000 L CNN
F 1 "1K" V 5700 3050 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5800 3000 50  0001 C CNN
F 3 "~" H 5800 3000 50  0001 C CNN
	1    5800 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R41
U 1 1 5CEDC8FC
P 5600 2750
F 0 "R41" H 5550 2700 50  0000 R CNN
F 1 "10K" H 5550 2800 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5600 2750 50  0001 C CNN
F 3 "~" H 5600 2750 50  0001 C CNN
	1    5600 2750
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R40
U 1 1 5CEDC98A
P 5400 2750
F 0 "R40" H 5450 2700 50  0000 L CNN
F 1 "10K" H 5450 2800 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5400 2750 50  0001 C CNN
F 3 "~" H 5400 2750 50  0001 C CNN
	1    5400 2750
	-1   0    0    1   
$EndComp
Wire Wire Line
	6000 3200 5900 3200
Wire Wire Line
	6000 3000 5900 3000
Wire Wire Line
	5700 3000 5600 3000
Wire Wire Line
	5600 3000 5600 2850
Wire Wire Line
	5700 3200 5400 3200
Wire Wire Line
	5400 3200 5400 2850
Wire Wire Line
	5600 2650 5600 2550
Wire Wire Line
	5400 2650 5400 2550
Wire Wire Line
	5400 2550 5600 2550
Wire Wire Line
	5600 3000 5300 3000
Connection ~ 5600 3000
Wire Wire Line
	5400 3200 5300 3200
Connection ~ 5400 3200
Text GLabel 5300 3000 0    39   BiDi ~ 0
SDA
Text GLabel 5300 3200 0    39   BiDi ~ 0
SCL
Wire Wire Line
	6000 2800 5900 2800
Wire Wire Line
	5900 2800 5900 2550
Wire Wire Line
	5900 2550 5600 2550
Connection ~ 5600 2550
Wire Wire Line
	7200 2800 7300 2800
Wire Wire Line
	7300 2800 7300 3000
Wire Wire Line
	7300 3000 7200 3000
Connection ~ 7300 3000
Wire Wire Line
	7200 3400 7300 3400
Wire Wire Line
	7300 3400 7300 3200
Wire Wire Line
	7300 3200 7200 3200
Connection ~ 7300 3200
Wire Wire Line
	6000 3400 5900 3400
Wire Wire Line
	5900 3400 5900 3500
$Comp
L power:GND #PWR0109
U 1 1 5CF2DEB2
P 5900 3500
F 0 "#PWR0109" H 5900 3250 50  0001 C CNN
F 1 "GND" H 5905 3327 50  0000 C CNN
F 2 "" H 5900 3500 50  0001 C CNN
F 3 "" H 5900 3500 50  0001 C CNN
	1    5900 3500
	1    0    0    -1  
$EndComp
Text GLabel 5100 2550 0    39   Input ~ 0
Vcc
Text GLabel 7850 3000 2    39   BiDi ~ 0
SDA_WIRE
Text GLabel 7850 3200 2    39   BiDi ~ 0
SCL_WIRE
$Comp
L Device:R_Small R44
U 1 1 5CF385A8
P 7700 3000
F 0 "R44" V 7600 2800 50  0000 L CNN
F 1 "TBD" V 7600 3000 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7700 3000 50  0001 C CNN
F 3 "~" H 7700 3000 50  0001 C CNN
	1    7700 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R45
U 1 1 5CF38648
P 7700 3200
F 0 "R45" V 7600 3000 50  0000 L CNN
F 1 "TBD" V 7600 3200 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7700 3200 50  0001 C CNN
F 3 "~" H 7700 3200 50  0001 C CNN
	1    7700 3200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5CF55245
P 7700 3600
F 0 "#PWR0110" H 7700 3350 50  0001 C CNN
F 1 "GND" H 7705 3427 50  0000 C CNN
F 2 "" H 7700 3600 50  0001 C CNN
F 3 "" H 7700 3600 50  0001 C CNN
	1    7700 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C40
U 1 1 5CFBBDFD
P 5100 2750
F 0 "C40" H 5000 2800 50  0000 R CNN
F 1 "100nF" H 5000 2700 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5100 2750 50  0001 C CNN
F 3 "~" H 5100 2750 50  0001 C CNN
	1    5100 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 2650 5100 2550
Wire Wire Line
	5100 2550 5400 2550
Connection ~ 5400 2550
Wire Wire Line
	5100 2850 5100 3400
Wire Wire Line
	5100 3400 5900 3400
Connection ~ 5900 3400
$Comp
L Diode:BAT54A D40
U 1 1 5CFD080C
P 7700 3400
F 0 "D40" H 7600 3250 50  0000 R CNN
F 1 "BAT54A" H 7600 3150 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7775 3525 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 7580 3400 50  0001 C CNN
	1    7700 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 3200 7850 3200
Wire Wire Line
	7800 3000 7850 3000
Wire Wire Line
	8000 3400 8250 3400
Wire Wire Line
	7300 3400 7400 3400
$Comp
L Device:R_Small R60
U 1 1 5CEF6DC9
P 3350 900
F 0 "R60" H 3250 950 50  0000 R CNN
F 1 "51K" H 3250 850 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3350 900 50  0001 C CNN
F 3 "~" H 3350 900 50  0001 C CNN
	1    3350 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5CEF7350
P 3750 1500
F 0 "#PWR0111" H 3750 1250 50  0001 C CNN
F 1 "GND" H 3755 1327 50  0000 C CNN
F 2 "" H 3750 1500 50  0001 C CNN
F 3 "" H 3750 1500 50  0001 C CNN
	1    3750 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R61
U 1 1 5CEF7CB7
P 3550 1100
F 0 "R61" V 3350 1000 50  0000 L CNN
F 1 "51K" V 3450 1000 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3550 1100 50  0001 C CNN
F 3 "~" H 3550 1100 50  0001 C CNN
	1    3550 1100
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C60
U 1 1 5CEF7D47
P 3750 1300
F 0 "C60" H 3850 1350 50  0000 L CNN
F 1 "100nF" H 3850 1250 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3750 1300 50  0001 C CNN
F 3 "~" H 3750 1300 50  0001 C CNN
	1    3750 1300
	1    0    0    -1  
$EndComp
Text GLabel 3250 700  0    39   Input ~ 0
OVF_EN
Wire Wire Line
	3350 800  3350 700 
Wire Wire Line
	3350 700  3250 700 
Wire Wire Line
	3350 1000 3350 1100
Wire Wire Line
	3350 1350 3350 1500
$Comp
L Connector:6P6C J1
U 1 1 5D13DC1C
P 9450 3900
F 0 "J1" H 9450 4450 50  0000 C CNN
F 1 "IN" H 9450 4350 50  0000 C CNN
F 2 "Connector_RJ:RJ12_Amphenol_54601" V 9450 3925 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_7328_CO.pdf" V 9450 3925 50  0001 C CNN
	1    9450 3900
	-1   0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0114
U 1 1 5D13DC24
P 8950 3500
F 0 "#PWR0114" H 8950 3350 50  0001 C CNN
F 1 "+12V" H 8965 3673 50  0000 C CNN
F 2 "" H 8950 3500 50  0001 C CNN
F 3 "" H 8950 3500 50  0001 C CNN
	1    8950 3500
	-1   0    0    -1  
$EndComp
Text GLabel 8850 4000 0    39   Input ~ 0
Vin
$Comp
L power:GND #PWR0115
U 1 1 5D13DC2C
P 8950 4200
F 0 "#PWR0115" H 8950 3950 50  0001 C CNN
F 1 "GND" H 8955 4027 50  0000 C CNN
F 2 "" H 8950 4200 50  0001 C CNN
F 3 "" H 8950 4200 50  0001 C CNN
	1    8950 4200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8950 4200 8950 4100
Wire Wire Line
	8950 4100 9050 4100
Wire Wire Line
	9050 3900 8850 3900
Wire Wire Line
	8950 3800 9050 3800
Wire Wire Line
	9050 3700 8950 3700
Wire Wire Line
	8950 3500 8950 3600
Wire Wire Line
	8950 3600 9050 3600
Wire Wire Line
	8950 4100 8950 3800
Connection ~ 8950 4100
Wire Wire Line
	8850 4000 9050 4000
Wire Wire Line
	3450 1100 3350 1100
Wire Wire Line
	3750 1200 3750 1100
Wire Wire Line
	3750 1100 3650 1100
Wire Wire Line
	3750 1400 3750 1500
Wire Wire Line
	3750 1500 3350 1500
Wire Wire Line
	3850 1100 3750 1100
Connection ~ 3750 1100
Wire Wire Line
	3350 1350 3250 1350
Text Notes 8550 3150 0    39   ~ 0
We use 6P6C jacks to carry power and data due to availability and tested design.\nUse TP cable where SDA and 12V are paired, and SCL and GND are paired. 
Text Notes 8550 2950 0    47   ~ 0
System Connectivity\n
$Comp
L Connector:Screw_Terminal_01x02 J60
U 1 1 5D19682A
P 3050 1250
F 0 "J60" H 3050 1350 50  0000 C CNN
F 1 "OVF" H 3100 1050 50  0000 C CNN
F 2 "TerminalBlock_RND:TerminalBlock_RND_205-00045_1x02_P5.00mm_Horizontal" H 3050 1250 50  0001 C CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Phoenix%20Contact%20PDFs/1935161.pdf" H 3050 1250 50  0001 C CNN
	1    3050 1250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3350 1100 3350 1250
Wire Wire Line
	3350 1250 3250 1250
Connection ~ 3350 1100
Text Notes 650  650  0    47   ~ 0
Overflow Sensor
Text Notes 650  1500 0    39   ~ 0
Use a resistive water sensor of corossion resistive material.\nWhen the electrodes are submerged they form a voltage\ndivider with the top resistor and pull down the voltage from\nVcc. Analog comparator on MCU detects deviance from Vcc\nwith threshold and trips IRQ.\n\nTesting a few sensors in water yields somewhere in 50-80K Ohm\nresistance in tap water. Pick 51K for top divider to significantly\ndrop the mid voltage when submerged.\n\nRC circuit sized to attenuate 50 Hz mains noise by at least 3 dB.\nPick R = 51K, C = 100nF -> Fc = 16 Hz -> -5.5 dB @ 50Hz
Text Notes 8550 4650 0    47   ~ 0
Pump Driver
Text Notes 8550 5100 0    39   ~ 0
We use a combined power MOSFET + driver IC that can directly switch the 12V\nto the pump. This saves space compared to a relay and is simpler than building\nthe equivalent circuit with jellybeans, and more likely to work without issues.\n\nFlyback diode protects from back-EMF from the most likely inductive load.\nValues sized based on application notes for slow start and stop.
Wire Notes Line
	11200 4450 8400 4450
Wire Notes Line
	8400 2750 11200 2750
Text Notes 8550 700  0    47   ~ 0
Temperature Sensor
Text Notes 8550 1200 0    39   ~ 0
We use a NTC with 10K@25C and g=4067K nominally.\nWith a top divider of 10K it is approximately linear in the 25C\nrange. We can linearize in software if needed.\n\nThe output RC filter is chosen to reduce impact of 50 Hz mains noise.\nR=100K, C=100nF -> Fc = 16Hz -> -10.3 dB @ 50 Hz.
Wire Notes Line
	8400 500  8400 6500
Wire Wire Line
	7300 3200 7600 3200
Connection ~ 7300 3400
Wire Wire Line
	7300 3000 7600 3000
Wire Wire Line
	8250 3400 8250 2800
Wire Wire Line
	8250 2800 7300 2800
Connection ~ 7300 2800
Text Notes 4750 700  0    47   ~ 0
I2C Buffer/Driver
Text Notes 4750 1950 0    39   ~ 0
The P86B96 is a strong buffer/driver chip that allows us to use I2C for robust offboard communication and\nit will also perform level transtlation between the device and bus sides based on what the bus voltage is.\n\nSizing is done to allow for standard speed I2C (100 KHz). The ATmega has slew rate limiting and is the\nmajority contributor to the bus capacitance, the P82B96 datasheet makes no mention of slew rate limiting.\nFor this reason we're adding a series resistance close to the P82B96 pins to keep the dynamic current within\nspec when it pulls low and has to discharge the ATmega pin output capacitance.\n\nWe take the sum of the series and pull-up resistor as Rp for purposes of sizing.\n\nThe device side bus capacitance is estimated < 20 pF which gives Rp < 50K.\n\nATmega: Rp > Vcc - VOL / 3mA = 1534 Ohm\nP82B96: Rp > Vcc - VOL / 3mA = 1334 Ohm\n\nI(max, dynamic) = 6 mA -> Rs > 834 Ohm.\n\nPick Rs = 1K and Rp = 11K (10+Rs).\n
Wire Wire Line
	7150 6450 6600 6450
Connection ~ 5600 6050
Wire Wire Line
	5600 6050 5600 5350
Wire Wire Line
	6000 5650 6100 5650
Wire Wire Line
	7600 5350 7600 6050
Wire Wire Line
	6000 5350 6000 5650
Wire Wire Line
	7600 5350 6000 5350
Text Notes 4750 4050 0    47   ~ 0
Capacitive Sensor Driver
Wire Wire Line
	5050 6050 5150 6050
Wire Wire Line
	5350 6050 5600 6050
Wire Wire Line
	6000 5350 5900 5350
Connection ~ 6000 5350
Wire Wire Line
	5700 5350 5600 5350
Connection ~ 5600 5350
Wire Wire Line
	5600 5350 5600 5250
Wire Wire Line
	5600 5250 6600 5250
Wire Notes Line
	4600 500  4600 7800
Wire Notes Line
	4600 1800 500  1800
Text GLabel 3200 4850 2    39   Input ~ 0
OVF_EN
Text GLabel 3200 7250 2    39   Output ~ 0
OVF_SENSE
Text GLabel 3200 6150 2    39   BiDi ~ 0
SDA
Text GLabel 3200 6250 2    39   BiDi ~ 0
SCL
Text GLabel 3200 5550 2    39   Input ~ 0
F_PROBE_EN
Text GLabel 3200 7050 2    39   Input ~ 0
F_PROBE
Text GLabel 3200 5850 2    39   Input ~ 0
PUMP_EN
Text GLabel 3200 5050 2    39   Input ~ 0
~TEMP_EXC
Text GLabel 3200 4950 2    39   Input ~ 0
LED_EN
Text GLabel 2000 5050 0    39   Output ~ 0
TEMP_SENSE
$Comp
L Device:R_Small R10
U 1 1 5D77897E
P 3850 6950
F 0 "R10" H 3800 7000 50  0000 R CNN
F 1 "1K" H 3800 6900 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3850 6950 50  0001 C CNN
F 3 "~" H 3850 6950 50  0001 C CNN
	1    3850 6950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R11
U 1 1 5D782E0B
P 3850 7350
F 0 "R11" H 3800 7400 50  0000 R CNN
F 1 "51K" H 3800 7300 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3850 7350 50  0001 C CNN
F 3 "~" H 3850 7350 50  0001 C CNN
	1    3850 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 7150 3850 7050
Wire Wire Line
	3850 7150 3850 7250
Connection ~ 3850 7150
Wire Wire Line
	3850 6850 3850 6750
Wire Wire Line
	3850 7450 3850 7550
$Comp
L power:GND #PWR0116
U 1 1 5D7AD830
P 3850 7550
F 0 "#PWR0116" H 3850 7300 50  0001 C CNN
F 1 "GND" H 3855 7377 50  0000 C CNN
F 2 "" H 3850 7550 50  0001 C CNN
F 3 "" H 3850 7550 50  0001 C CNN
	1    3850 7550
	1    0    0    -1  
$EndComp
Text GLabel 3850 6750 0    39   Input ~ 0
Vcc
Wire Wire Line
	3200 7150 3850 7150
Text Notes 3950 7150 0    39   ~ 0
Reference voltage\nfor the overflow\nsensor of 0.98*Vcc\nor 20 ADC counts.
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J10
U 1 1 5D00A547
P 3850 6200
F 0 "J10" H 3900 6517 50  0000 C CNN
F 1 "ICSP" H 3900 6426 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x04_P2.54mm_Vertical" H 3850 6200 50  0001 C CNN
F 3 "~" H 3850 6200 50  0001 C CNN
	1    3850 6200
	1    0    0    -1  
$EndComp
NoConn ~ 3200 5750
NoConn ~ 3250 6750
NoConn ~ 3200 5950
NoConn ~ 3200 6050
NoConn ~ 3200 5450
NoConn ~ 3200 6850
NoConn ~ 3200 6950
Text Notes 4750 7200 0    39   ~ 0
The probe is connected via a high-pass filter with cut off frequency \nof such that F_PROBE(min) is minimally attenuated. \n\nPick C = 10n and  R = 10 K, then we get Fc = 1591 Hz and \nattenuation at 100 KHz is -0.0011 dB or less than 0.02% and for \n50 Hz it is -30 dB or 3% of original amplitude.\n\n
Wire Wire Line
	2600 4450 2600 4550
Wire Wire Line
	2600 4450 2700 4450
Wire Wire Line
	2700 4450 2700 4550
Wire Wire Line
	950  2800 1050 2800
Wire Wire Line
	1350 2800 1250 2800
Wire Wire Line
	1650 3100 1650 3300
Wire Wire Line
	1650 3300 1950 3300
Wire Wire Line
	1950 2800 1850 2800
Wire Wire Line
	1350 2900 1350 2800
Wire Wire Line
	1350 2800 1450 2800
Connection ~ 1350 2800
Wire Wire Line
	1350 3200 1350 3300
Wire Wire Line
	1350 3300 1650 3300
Connection ~ 1650 3300
$Comp
L Device:C_Small C0
U 1 1 5D9A68E5
P 1950 3000
F 0 "C0" H 2042 3046 50  0000 L CNN
F 1 "1uF" H 2042 2955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1950 3000 50  0001 C CNN
F 3 "~" H 1950 3000 50  0001 C CNN
	1    1950 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 2800 1950 2900
Wire Wire Line
	1950 3100 1950 3300
$Comp
L Device:C_Small C11
U 1 1 5D9BF481
P 800 6050
F 0 "C11" H 892 6096 50  0000 L CNN
F 1 "100nF" H 900 6000 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 800 6050 50  0001 C CNN
F 3 "~" H 800 6050 50  0001 C CNN
	1    800  6050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 5D9BF4FF
P 1250 6050
F 0 "C12" H 1342 6096 50  0000 L CNN
F 1 "10nF" H 1342 6005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1250 6050 50  0001 C CNN
F 3 "~" H 1250 6050 50  0001 C CNN
	1    1250 6050
	1    0    0    -1  
$EndComp
Connection ~ 1950 2800
Wire Notes Line
	500  3850 8400 3850
Text Notes 650  4050 0    47   ~ 0
MCU, refrences and basic I/O 
Wire Wire Line
	7900 6050 7950 6050
Wire Wire Line
	7700 6050 7600 6050
Wire Wire Line
	7600 6450 8000 6450
Wire Wire Line
	7600 6450 7350 6450
Connection ~ 7600 6450
Wire Wire Line
	7600 6450 7600 6350
Wire Wire Line
	7600 6150 7600 6050
$Comp
L Device:R_Small R23
U 1 1 5CF9F34A
P 7600 6250
F 0 "R23" H 7550 6200 50  0000 R CNN
F 1 "10K" H 7550 6300 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7600 6250 50  0001 C CNN
F 3 "~" H 7600 6250 50  0001 C CNN
	1    7600 6250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C22
U 1 1 5CF736FF
P 7800 6050
F 0 "C22" V 8050 6100 50  0000 R CNN
F 1 "10nF" V 7950 6100 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7800 6050 50  0001 C CNN
F 3 "~" H 7800 6050 50  0001 C CNN
	1    7800 6050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1950 2800 2050 2800
Connection ~ 2600 4450
Text Notes 3500 3250 0    39   ~ 0
The total power draw 5V:\nMCU(active) < 6 mA\n555 circutry < 2 mA\nP82B96 < 4 mA\nTPS22810 < 200 uA\nOverflow sensor < 100 uA\nTemp sensor < 250 uA\nTOTAL(max) < 13 mA
Text GLabel 9600 1450 0    39   Input ~ 0
Vcc
Text GLabel 8850 3900 0    39   BiDi ~ 0
SDA_WIRE
Text GLabel 8950 3700 0    39   BiDi ~ 0
SCL_WIRE
Connection ~ 3750 1500
$Comp
L power:GND #PWR0118
U 1 1 5D055EF8
P 1650 3300
F 0 "#PWR0118" H 1650 3050 50  0001 C CNN
F 1 "GND" H 1655 3127 50  0000 C CNN
F 2 "" H 1650 3300 50  0001 C CNN
F 3 "" H 1650 3300 50  0001 C CNN
	1    1650 3300
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP20
U 1 1 5D05F730
P 7950 6150
F 0 "TP20" H 7892 6177 50  0000 R CNN
F 1 "A" H 7892 6268 50  0000 R CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8150 6150 50  0001 C CNN
F 3 "~" H 8150 6150 50  0001 C CNN
	1    7950 6150
	-1   0    0    1   
$EndComp
Wire Wire Line
	7950 6150 7950 6050
Connection ~ 7950 6050
Wire Wire Line
	7950 6050 8000 6050
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5D06B742
P 2450 3600
F 0 "#FLG0101" H 2450 3675 50  0001 C CNN
F 1 "PWR_FLAG" H 2450 3774 50  0000 C CNN
F 2 "" H 2450 3600 50  0001 C CNN
F 3 "~" H 2450 3600 50  0001 C CNN
	1    2450 3600
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5D06B7B4
P 2050 3600
F 0 "#FLG0102" H 2050 3675 50  0001 C CNN
F 1 "PWR_FLAG" H 2050 3774 50  0000 C CNN
F 2 "" H 2050 3600 50  0001 C CNN
F 3 "~" H 2050 3600 50  0001 C CNN
	1    2050 3600
	1    0    0    -1  
$EndComp
Text GLabel 2450 3600 3    39   Input ~ 0
Vcc
$Comp
L power:GND #PWR0117
U 1 1 5D06B881
P 2050 3600
F 0 "#PWR0117" H 2050 3350 50  0001 C CNN
F 1 "GND" H 2055 3427 50  0000 C CNN
F 2 "" H 2050 3600 50  0001 C CNN
F 3 "" H 2050 3600 50  0001 C CNN
	1    2050 3600
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0119
U 1 1 5D06D6BE
P 2850 3600
F 0 "#PWR0119" H 2850 3450 50  0001 C CNN
F 1 "+12V" H 2865 3773 50  0000 C CNN
F 2 "" H 2850 3600 50  0001 C CNN
F 3 "" H 2850 3600 50  0001 C CNN
	1    2850 3600
	1    0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 5D06D729
P 2850 3600
F 0 "#FLG0103" H 2850 3675 50  0001 C CNN
F 1 "PWR_FLAG" H 2850 3774 50  0000 C CNN
F 2 "" H 2850 3600 50  0001 C CNN
F 3 "~" H 2850 3600 50  0001 C CNN
	1    2850 3600
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5D08AFD8
P 5350 5400
F 0 "#FLG0104" H 5350 5475 50  0001 C CNN
F 1 "PWR_FLAG" H 5350 5573 50  0000 C CNN
F 2 "" H 5350 5400 50  0001 C CNN
F 3 "~" H 5350 5400 50  0001 C CNN
	1    5350 5400
	-1   0    0    1   
$EndComp
Wire Wire Line
	5350 5400 5350 5250
Wire Wire Line
	5350 5250 5600 5250
Connection ~ 5600 5250
Wire Wire Line
	2500 4450 2600 4450
$Comp
L Device:C_Small C13
U 1 1 5D0A6E83
P 800 6900
F 0 "C13" H 892 6946 50  0000 L CNN
F 1 "100nF" H 900 6850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 800 6900 50  0001 C CNN
F 3 "~" H 800 6900 50  0001 C CNN
	1    800  6900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C14
U 1 1 5D0A6E8A
P 1250 6900
F 0 "C14" H 1342 6946 50  0000 L CNN
F 1 "10nF" H 1342 6855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1250 6900 50  0001 C CNN
F 3 "~" H 1250 6900 50  0001 C CNN
	1    1250 6900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0120
U 1 1 5D0B04C5
P 1250 7200
F 0 "#PWR0120" H 1250 6950 50  0001 C CNN
F 1 "GND" H 1255 7027 50  0000 C CNN
F 2 "" H 1250 7200 50  0001 C CNN
F 3 "" H 1250 7200 50  0001 C CNN
	1    1250 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 7200 1250 7100
Wire Wire Line
	800  7000 800  7100
Wire Wire Line
	800  7100 1250 7100
Connection ~ 1250 7100
Wire Wire Line
	1250 7100 1250 7000
Wire Wire Line
	800  6150 800  6250
Wire Wire Line
	800  6250 1250 6250
Wire Wire Line
	1250 6250 1250 6150
Wire Wire Line
	1250 6350 1250 6250
Connection ~ 1250 6250
$Comp
L power:GND #PWR0121
U 1 1 5D0E1810
P 1250 6350
F 0 "#PWR0121" H 1250 6100 50  0001 C CNN
F 1 "GND" H 1255 6177 50  0000 C CNN
F 2 "" H 1250 6350 50  0001 C CNN
F 3 "" H 1250 6350 50  0001 C CNN
	1    1250 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 6800 1250 6700
Wire Wire Line
	1250 6700 800  6700
Wire Wire Line
	800  6700 800  6800
Wire Wire Line
	1250 5950 1250 5850
Wire Wire Line
	1250 5850 800  5850
Wire Wire Line
	800  5850 800  5950
Text GLabel 800  5850 0    39   Input ~ 0
Vcc
Text GLabel 800  6700 0    39   Input ~ 0
Vcc
Wire Wire Line
	1300 5200 1300 5300
Text Label 10500 5550 0    39   ~ 0
Pump+
Text Label 1350 2800 0    39   ~ 0
F_in
Wire Wire Line
	10000 5550 10100 5550
Wire Wire Line
	10100 5650 10100 5550
Connection ~ 10100 5550
Wire Wire Line
	10100 5550 10500 5550
$EndSCHEMATC
