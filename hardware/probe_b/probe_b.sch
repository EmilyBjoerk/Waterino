EESchema Schematic File Version 4
LIBS:probe_b-cache
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
$Comp
L probe_b-rescue:C C10
U 1 1 5B09AF35
P 8250 1800
F 0 "C10" H 8275 1900 50  0000 L CNN
F 1 "10nF" H 8300 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8288 1650 50  0001 C CNN
F 3 "" H 8250 1800 50  0001 C CNN
	1    8250 1800
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:C C11
U 1 1 5B09AF36
P 8550 1800
F 0 "C11" H 8575 1900 50  0000 L CNN
F 1 "100nF" H 8600 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8588 1650 50  0001 C CNN
F 3 "" H 8550 1800 50  0001 C CNN
	1    8550 1800
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:C C12
U 1 1 5B09AF37
P 8850 1800
F 0 "C12" H 8875 1900 50  0000 L CNN
F 1 "1µF" H 8900 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8888 1650 50  0001 C CNN
F 3 "" H 8850 1800 50  0001 C CNN
	1    8850 1800
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:R NTC1
U 1 1 5B09AF3C
P 5400 4200
F 0 "NTC1" V 5480 4200 50  0000 C CNN
F 1 "R" V 5400 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5330 4200 50  0001 C CNN
F 3 "" H 5400 4200 50  0001 C CNN
	1    5400 4200
	-1   0    0    -1  
$EndComp
$Comp
L probe_b-rescue:R R23
U 1 1 5B09AF3D
P 5400 3800
F 0 "R23" V 5480 3800 50  0000 C CNN
F 1 "15K" V 5400 3800 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5330 3800 50  0001 C CNN
F 3 "" H 5400 3800 50  0001 C CNN
	1    5400 3800
	-1   0    0    -1  
$EndComp
$Comp
L probe_b-rescue:BSS84 Q1
U 1 1 5B09AF3E
P 9150 1650
F 0 "Q1" H 9000 1550 50  0000 L CNN
F 1 "SI2323DS" V 9400 1450 50  0000 L CNN
F 2 "emilibeda:SOT-23-Power" H 9350 1575 50  0001 L CIN
F 3 "" H 9150 1650 50  0001 L CNN
	1    9150 1650
	0    1    -1   0   
$EndComp
$Comp
L probe_b-rescue:D_Zener D5
U 1 1 5B09AF3F
P 9450 1800
F 0 "D5" H 9450 1900 50  0000 C CNN
F 1 "BZT52C5V6" H 9450 1700 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 9450 1800 50  0001 C CNN
F 3 "" H 9450 1800 50  0001 C CNN
	1    9450 1800
	0    1    1    0   
$EndComp
Text GLabel 10350 1550 2    39   Input ~ 0
Vin
$Comp
L probe_b-rescue:GND #PWR011
U 1 1 5B09AF44
P 9450 2050
F 0 "#PWR011" H 9450 1800 50  0001 C CNN
F 1 "GND" H 9450 1900 50  0000 C CNN
F 2 "" H 9450 2050 50  0001 C CNN
F 3 "" H 9450 2050 50  0001 C CNN
	1    9450 2050
	1    0    0    -1  
$EndComp
Text GLabel 3150 1800 0    39   Input ~ 0
SCL
Text GLabel 3150 1700 0    39   Input ~ 0
SDA
Text GLabel 8850 1550 1    39   Input ~ 0
Vcc
Text GLabel 2800 3000 0    39   Input ~ 0
RST
Text GLabel 2800 2900 0    39   Input ~ 0
SCK
Text GLabel 3300 2900 2    39   Input ~ 0
MOSI
Text GLabel 5000 4000 0    39   Input ~ 0
TEMP+
$Comp
L probe_b-rescue:R R4
U 1 1 5B09AF4A
P 3400 1700
F 0 "R4" V 3300 1700 50  0000 C CNN
F 1 "150R" V 3400 1700 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3330 1700 50  0001 C CNN
F 3 "" H 3400 1700 50  0001 C CNN
	1    3400 1700
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:TEST_1P J7
U 1 1 5B09AF52
P 5400 4000
F 0 "J7" H 5400 4270 50  0000 C CNN
F 1 "TEMP_A" H 5400 4200 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5600 4000 50  0001 C CNN
F 3 "" H 5600 4000 50  0001 C CNN
	1    5400 4000
	0    1    -1   0   
$EndComp
$Comp
L probe_b-rescue:PWR_FLAG #FLG02
U 1 1 5B09D388
P 8250 1550
F 0 "#FLG02" H 8250 1625 50  0001 C CNN
F 1 "PWR_FLAG" H 8250 1700 50  0000 C CNN
F 2 "" H 8250 1550 50  0001 C CNN
F 3 "" H 8250 1550 50  0001 C CNN
	1    8250 1550
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:PWR_FLAG #FLG03
U 1 1 5B09DF20
P 8550 2050
F 0 "#FLG03" H 8550 2125 50  0001 C CNN
F 1 "PWR_FLAG" H 8550 2200 50  0000 C CNN
F 2 "" H 8550 2050 50  0001 C CNN
F 3 "" H 8550 2050 50  0001 C CNN
	1    8550 2050
	-1   0    0    1   
$EndComp
Text GLabel 2800 2800 0    39   Input ~ 0
MISO
Text GLabel 3200 4950 2    39   Input ~ 0
SCL
Text GLabel 3200 4850 2    39   Input ~ 0
SDA
Text Notes 9650 2150 0    39   ~ 0
This protects the MCU from reverse voltage \nin the case that the connector is reversed. If your \nconnector is keyed (or you're certain you're not \ngoing to mess it up) you can omit this.
$Comp
L probe_b-rescue:PWR_FLAG #FLG04
U 1 1 5B46B68D
P 9450 1550
F 0 "#FLG04" H 9450 1625 50  0001 C CNN
F 1 "PWR_FLAG" H 9450 1700 50  0000 C CNN
F 2 "" H 9450 1550 50  0001 C CNN
F 3 "" H 9450 1550 50  0001 C CNN
	1    9450 1550
	1    0    0    -1  
$EndComp
Text GLabel 6250 7600 2    39   Input ~ 0
RC_REF
Text GLabel 3200 5800 2    39   Input ~ 0
RC_REF
$Comp
L probe_b-rescue:ATMEGA328P-AU U1
U 1 1 5B91B983
P 2200 4700
F 0 "U1" H 1450 5950 50  0000 L BNN
F 1 "ATMEGA328P-AU" H 2600 3300 50  0000 L BNN
F 2 "Housings_QFP:TQFP-32_7x7mm_Pitch0.8mm" H 2200 4700 50  0001 C CIN
F 3 "" H 2200 4700 50  0001 C CNN
	1    2200 4700
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:R R11
U 1 1 5B91E068
P 4300 5900
F 0 "R11" V 4380 5900 50  0000 C CNN
F 1 "1M" V 4300 5900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4230 5900 50  0001 C CNN
F 3 "" H 4300 5900 50  0001 C CNN
	1    4300 5900
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:GND #PWR03
U 1 1 5B922FFB
P 3500 3000
F 0 "#PWR03" H 3500 2750 50  0001 C CNN
F 1 "GND" H 3500 2850 50  0000 C CNN
F 2 "" H 3500 3000 50  0001 C CNN
F 3 "" H 3500 3000 50  0001 C CNN
	1    3500 3000
	1    0    0    -1  
$EndComp
Text GLabel 3300 2800 2    39   Input ~ 0
Vin
Text GLabel 3200 4000 2    39   Input ~ 0
MISO
Text GLabel 3200 4100 2    39   Input ~ 0
SCK
Text GLabel 3200 5050 2    39   Input ~ 0
RST
Text GLabel 3200 3900 2    39   Input ~ 0
MOSI
Text GLabel 1300 3900 0    39   Input ~ 0
AVcc
$Comp
L probe_b-rescue:LED D2
U 1 1 5B9365AD
P 8100 3900
F 0 "D2" H 8100 4000 50  0000 C CNN
F 1 "PUMP_ LED" V 8100 3600 50  0000 C CNN
F 2 "Diodes_SMD:D_0603" H 8100 3900 50  0001 C CNN
F 3 "" H 8100 3900 50  0001 C CNN
	1    8100 3900
	0    -1   -1   0   
$EndComp
$Comp
L probe_b-rescue:R R16
U 1 1 5B936B42
P 8100 4200
F 0 "R16" V 8000 4200 50  0000 C CNN
F 1 "1K" V 8100 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 8030 4200 50  0001 C CNN
F 3 "" H 8100 4200 50  0001 C CNN
	1    8100 4200
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:GND #PWR06
U 1 1 5B938DE2
P 4150 5000
F 0 "#PWR06" H 4150 4750 50  0001 C CNN
F 1 "GND" H 4150 4850 50  0000 C CNN
F 2 "" H 4150 5000 50  0001 C CNN
F 3 "" H 4150 5000 50  0001 C CNN
	1    4150 5000
	1    0    0    -1  
$EndComp
Text GLabel 3200 5200 2    39   Input ~ 0
RX
Text GLabel 3200 5300 2    39   Input ~ 0
TX
Text GLabel 2800 2700 0    39   Input ~ 0
RX
Text GLabel 2800 2600 0    39   Input ~ 0
TX
Text Label 4050 6400 0    39   ~ 0
Csense
Text GLabel 1300 3600 0    39   Input ~ 0
Vcc
$Comp
L probe_b-rescue:C C9
U 1 1 5B9413B0
P 7950 1800
F 0 "C9" H 7975 1900 50  0000 L CNN
F 1 "10nF" H 8000 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 7988 1650 50  0001 C CNN
F 3 "" H 7950 1800 50  0001 C CNN
	1    7950 1800
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:C C8
U 1 1 5B941424
P 7650 1800
F 0 "C8" H 7675 1900 50  0000 L CNN
F 1 "100nF" H 7700 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 7688 1650 50  0001 C CNN
F 3 "" H 7650 1800 50  0001 C CNN
	1    7650 1800
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:C C2
U 1 1 5B9438BD
P 1100 4400
F 0 "C2" H 1125 4500 50  0000 L CNN
F 1 "100nF" H 1125 4300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 1138 4250 50  0001 C CNN
F 3 "" H 1100 4400 50  0001 C CNN
	1    1100 4400
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:C C1
U 1 1 5B943AA1
P 800 4400
F 0 "C1" H 825 4500 50  0000 L CNN
F 1 "10nF" H 825 4300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 838 4250 50  0001 C CNN
F 3 "" H 800 4400 50  0001 C CNN
	1    800  4400
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:GND #PWR01
U 1 1 5B943D5F
P 1100 4650
F 0 "#PWR01" H 1100 4400 50  0001 C CNN
F 1 "GND" H 1100 4500 50  0000 C CNN
F 2 "" H 1100 4650 50  0001 C CNN
F 3 "" H 1100 4650 50  0001 C CNN
	1    1100 4650
	1    0    0    -1  
$EndComp
Text GLabel 6750 1550 0    39   Input ~ 0
AVcc
$Comp
L probe_b-rescue:C C7
U 1 1 5B945B67
P 7150 1800
F 0 "C7" H 7175 1900 50  0000 L CNN
F 1 "100nF" H 7175 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 7188 1650 50  0001 C CNN
F 3 "" H 7150 1800 50  0001 C CNN
	1    7150 1800
	1    0    0    -1  
$EndComp
Text Notes 6750 650  0    60   ~ 0
Power stage 
$Comp
L probe_b-rescue:Fuse F1
U 1 1 5B947577
P 10100 1550
F 0 "F1" V 10180 1550 50  0000 C CNN
F 1 "0ZCJ0050FF2G" V 10000 1650 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_SMD1206_HandSoldering" V 10030 1550 50  0001 C CNN
F 3 "https://www.belfuse.com/resources/CircuitProtection/datasheets/0ZCJ%20Nov2016.pdf" H 10100 1550 50  0001 C CNN
	1    10100 1550
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:L L2
U 1 1 5B94DD2D
P 9700 1550
F 0 "L2" V 9650 1550 50  0000 C CNN
F 1 "10uH" V 9775 1550 50  0000 C CNN
F 2 "digikey-footprints:1210" H 9700 1550 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=LBC3225T100KR&fileName=LBC3225T100KR_SS&mode=specSheetDownload" H 9700 1550 50  0001 C CNN
	1    9700 1550
	0    1    -1   0   
$EndComp
$Comp
L probe_b-rescue:C C6
U 1 1 5B94E0D7
P 6850 1800
F 0 "C6" H 6875 1900 50  0000 L CNN
F 1 "10nF" H 6875 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6888 1650 50  0001 C CNN
F 3 "" H 6850 1800 50  0001 C CNN
	1    6850 1800
	1    0    0    -1  
$EndComp
Text Notes 6750 1300 0    39   ~ 0
Design goals for power input:\n* External regulation\n* Low power loss at nominal 5V Vin\n* Reverse polarity protection\n* Transient suppression/Overvoltage protection (short events)\n* Nominally 5 V in at max 20 mA (100 mW) sustained\n* Max 6 V to device\n* Min Vin - 0.4 V to device for 5 V Vin 
Text Notes 9400 800  0    39   ~ 0
BZT52C5V6 Zener\nVz nom = 5.6\nVz min = 5.2\nVz max = 6.0
Text Notes 8700 1200 0    39   ~ 0
SI2323DS PMOS\nVds = -20 V\nVgs = +-8 V\nIs = -600 mA\nId = -2.9 A\nVt = -1 V (max)\nVbr,dss = -20 V\n\nBody diode oriented to\nblock reverse polarity.
Text Notes 10050 950  0    39   ~ 0
0ZCJ0050FF2G Fuse\nIhold,trip = 500 mA, 1 A\nVmax = 8 V\nImax = 100 A\nTtT@8 A = 100 ms\nRmin,max = 150 mR, 700 mR\n
Text Notes 10050 1200 0    39   ~ 0
Inductors\nRdc < 150 mR
Text Notes 550  2050 0    39   ~ 0
Total of 300R series resistance at the input at nominal  5V is 25 mA < 40 mA\nmax of ATmega GPIO pins. Prevents repeated peak currents from damaging\nIC when discharging bus capacitance.
$Comp
L probe_b-rescue:R R5
U 1 1 5B99E3C7
P 3400 1800
F 0 "R5" V 3500 1800 50  0000 C CNN
F 1 "150R" V 3400 1800 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3330 1800 50  0001 C CNN
F 3 "" H 3400 1800 50  0001 C CNN
	1    3400 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	8250 2050 8250 1950
Connection ~ 8250 2050
Wire Wire Line
	8550 2050 8550 1950
Connection ~ 8550 2050
Wire Wire Line
	8850 2050 8850 1950
Connection ~ 8850 2050
Wire Wire Line
	8850 1550 8850 1650
Connection ~ 8850 1550
Wire Wire Line
	8550 1550 8550 1650
Connection ~ 8550 1550
Wire Wire Line
	8250 1550 8250 1650
Connection ~ 8250 1550
Wire Wire Line
	9350 1550 9450 1550
Wire Wire Line
	9450 1550 9550 1550
Wire Wire Line
	5400 4350 5400 4500
Wire Wire Line
	5400 3950 5400 4000
Wire Wire Line
	5400 4000 5400 4050
Connection ~ 5400 4000
Wire Wire Line
	5000 4000 5100 4000
Wire Wire Line
	5100 4000 5400 4000
Wire Wire Line
	9150 2050 9150 1850
Connection ~ 9150 2050
Wire Wire Line
	4550 5700 4550 5900
Wire Wire Line
	4550 5900 4450 5900
Wire Wire Line
	3300 3000 3500 3000
Wire Wire Line
	6850 2050 7150 2050
Wire Wire Line
	7150 2050 7650 2050
Wire Wire Line
	7650 2050 7950 2050
Wire Wire Line
	7950 2050 8250 2050
Wire Wire Line
	8250 2050 8550 2050
Wire Wire Line
	8550 2050 8850 2050
Wire Wire Line
	8850 2050 9150 2050
Wire Wire Line
	9150 2050 9450 2050
Wire Wire Line
	1300 3600 1300 3700
Wire Wire Line
	7650 1950 7650 2050
Wire Wire Line
	7950 1950 7950 2050
Connection ~ 7950 2050
Wire Wire Line
	7650 1650 7650 1550
Wire Wire Line
	7950 1550 7950 1650
Connection ~ 7950 1550
Wire Wire Line
	800  4250 800  4200
Wire Wire Line
	800  4200 1100 4200
Wire Wire Line
	1100 4200 1300 4200
Wire Wire Line
	1100 4250 1100 4200
Connection ~ 1100 4200
Wire Wire Line
	1100 4550 1100 4650
Wire Wire Line
	1100 4650 800  4650
Wire Wire Line
	800  4650 800  4550
Wire Wire Line
	6750 1550 6850 1550
Wire Wire Line
	6850 1550 7150 1550
Wire Wire Line
	7150 1550 7250 1550
Wire Wire Line
	7150 1650 7150 1550
Connection ~ 7150 1550
Connection ~ 7650 1550
Wire Wire Line
	7150 1950 7150 2050
Connection ~ 7650 2050
Wire Wire Line
	7550 1550 7650 1550
Wire Wire Line
	7650 1550 7950 1550
Wire Wire Line
	7950 1550 8250 1550
Wire Wire Line
	8250 1550 8550 1550
Wire Wire Line
	8550 1550 8850 1550
Wire Wire Line
	8850 1550 8950 1550
Wire Wire Line
	9450 1550 9450 1650
Wire Wire Line
	9450 2050 9450 1950
Connection ~ 9450 2050
Connection ~ 9450 1550
Wire Wire Line
	6850 1650 6850 1550
Connection ~ 6850 1550
Wire Wire Line
	6850 1950 6850 2050
Connection ~ 7150 2050
Wire Notes Line
	11200 2350 6300 2350
Wire Notes Line
	6300 500  6300 3300
Wire Wire Line
	9950 1550 9850 1550
Wire Wire Line
	10250 1550 10350 1550
Wire Wire Line
	3550 1700 4050 1700
Wire Wire Line
	4050 1700 4250 1700
Wire Wire Line
	4050 1700 4050 1600
Wire Wire Line
	3650 1600 3650 1800
Wire Wire Line
	3550 1800 3650 1800
Wire Wire Line
	3650 1800 4250 1800
Connection ~ 4050 1700
Connection ~ 3650 1800
Wire Wire Line
	3150 1700 3250 1700
Wire Wire Line
	3150 1800 3250 1800
Wire Wire Line
	3750 1100 3750 1000
Wire Wire Line
	3750 1000 4150 1000
Wire Wire Line
	4150 1000 4300 1000
Wire Wire Line
	4150 1000 4150 1100
Wire Wire Line
	3950 1100 3950 900 
Wire Wire Line
	3550 900  3950 900 
Wire Wire Line
	3950 900  4300 900 
Wire Wire Line
	3550 900  3550 1100
$Comp
L probe_b-rescue:GND #PWR05
U 1 1 5B9A25E8
P 4300 1100
F 0 "#PWR05" H 4300 850 50  0001 C CNN
F 1 "GND" H 4300 950 50  0000 C CNN
F 2 "" H 4300 1100 50  0001 C CNN
F 3 "" H 4300 1100 50  0001 C CNN
	1    4300 1100
	1    0    0    -1  
$EndComp
Connection ~ 4150 1000
Wire Wire Line
	4300 1000 4300 1100
Connection ~ 3950 900 
Text GLabel 4300 900  2    39   Input ~ 0
Vin
$Comp
L probe_b-rescue:Conn_01x06 J5
U 1 1 5B9A6DB1
P 5400 1050
F 0 "J5" H 5480 1042 50  0000 L CNN
F 1 "Daisy_OUT" H 5480 951 50  0000 L CNN
F 2 "Connectors_JST:JST_PH_S6B-PH-K_06x2.00mm_Angled" H 5400 1050 50  0001 C CNN
F 3 "" H 5400 1050 50  0001 C CNN
	1    5400 1050
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:Conn_02x02_Odd_Even J6
U 1 1 5B9A6F0F
P 5400 1700
F 0 "J6" H 5450 1800 50  0000 C CNN
F 1 "Daisy_IN" H 5450 1500 50  0000 C CNN
F 2 "Connectors_Molex:Molex_Microfit3_Header_02x02_Angled_43045-040x" H 5400 1700 50  0001 C CNN
F 3 "" H 5400 1700 50  0001 C CNN
	1    5400 1700
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:GND #PWR09
U 1 1 5B9AE958
P 5900 1800
F 0 "#PWR09" H 5900 1550 50  0001 C CNN
F 1 "GND" H 5900 1650 50  0000 C CNN
F 2 "" H 5900 1800 50  0001 C CNN
F 3 "" H 5900 1800 50  0001 C CNN
	1    5900 1800
	1    0    0    -1  
$EndComp
Text GLabel 5200 1450 2    39   Input ~ 0
Vin
$Comp
L probe_b-rescue:GND #PWR08
U 1 1 5B9AEA6D
P 5050 1350
F 0 "#PWR08" H 5050 1100 50  0001 C CNN
F 1 "GND" H 5050 1200 50  0000 C CNN
F 2 "" H 5050 1350 50  0001 C CNN
F 3 "" H 5050 1350 50  0001 C CNN
	1    5050 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 1700 4850 1700
Wire Wire Line
	4550 1800 4750 1800
Wire Wire Line
	4750 1800 5200 1800
Connection ~ 4850 1700
Connection ~ 4750 1800
Wire Wire Line
	4950 2150 4950 2250
$Comp
L probe_b-rescue:R R21
U 1 1 5B9B1CCF
P 4950 2400
F 0 "R21" V 4850 2400 50  0000 C CNN
F 1 "10K" V 4950 2400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4880 2400 50  0001 C CNN
F 3 "" H 4950 2400 50  0001 C CNN
	1    4950 2400
	-1   0    0    1   
$EndComp
Text GLabel 4850 2650 0    39   Input ~ 0
Vcc
Wire Wire Line
	4850 2650 4950 2650
Wire Wire Line
	4950 2650 4950 2550
Text Notes 550  1750 0    39   ~ 0
Expecting overflow electrodes to have a resistance of \n30 K ish according to my experiments. Together with the \n10 K pull up results in around 7.5 K output impedence to \nthe max 10 K recommended for the ATmega ADC inputs.
Text GLabel 3950 2150 0    39   Input ~ 0
OVRFLW_SENSE
Wire Wire Line
	4850 2150 4950 2150
Connection ~ 4950 2150
Text Notes 550  600  0    60   ~ 0
Input stage 
$Comp
L probe_b-rescue:C C3
U 1 1 5B9BAFD5
P 4050 2400
F 0 "C3" H 4075 2500 50  0000 L CNN
F 1 "10nF" H 4075 2300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4088 2250 50  0001 C CNN
F 3 "" H 4050 2400 50  0001 C CNN
	1    4050 2400
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:GND #PWR04
U 1 1 5B9BB262
P 4050 2650
F 0 "#PWR04" H 4050 2400 50  0001 C CNN
F 1 "GND" H 4050 2500 50  0000 C CNN
F 2 "" H 4050 2650 50  0001 C CNN
F 3 "" H 4050 2650 50  0001 C CNN
	1    4050 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 2650 4050 2550
$Comp
L probe_b-rescue:R R20
U 1 1 5B9BCB5F
P 4700 2150
F 0 "R20" V 4600 2150 50  0000 C CNN
F 1 "150R" V 4700 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4630 2150 50  0001 C CNN
F 3 "" H 4700 2150 50  0001 C CNN
	1    4700 2150
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 2150 4050 2150
Wire Wire Line
	4050 2150 4150 2150
Wire Wire Line
	4050 2150 4050 2250
Connection ~ 4050 2150
$Comp
L probe_b-rescue:R R17
U 1 1 5B9BD43E
P 4300 2150
F 0 "R17" V 4200 2150 50  0000 C CNN
F 1 "150R" V 4300 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4230 2150 50  0001 C CNN
F 3 "" H 4300 2150 50  0001 C CNN
	1    4300 2150
	0    1    1    0   
$EndComp
Wire Wire Line
	4450 2150 4500 2150
Wire Wire Line
	4500 2150 4550 2150
$Comp
L probe_b-rescue:R R18
U 1 1 5B9BE50C
P 4400 1700
F 0 "R18" V 4300 1700 50  0000 C CNN
F 1 "150R" V 4400 1700 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4330 1700 50  0001 C CNN
F 3 "" H 4400 1700 50  0001 C CNN
	1    4400 1700
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:R R19
U 1 1 5B9BE5FC
P 4400 1800
F 0 "R19" V 4500 1800 50  0000 C CNN
F 1 "150R" V 4400 1800 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4330 1800 50  0001 C CNN
F 3 "" H 4400 1800 50  0001 C CNN
	1    4400 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	4500 2150 4500 2250
Connection ~ 4500 2150
$Comp
L probe_b-rescue:GND #PWR07
U 1 1 5B9BFA36
P 4400 2850
F 0 "#PWR07" H 4400 2600 50  0001 C CNN
F 1 "GND" H 4350 2700 50  0000 C CNN
F 2 "" H 4400 2850 50  0001 C CNN
F 3 "" H 4400 2850 50  0001 C CNN
	1    4400 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 2850 4400 2750
Text GLabel 4700 2850 2    39   Input ~ 0
Vin
Wire Wire Line
	4700 2850 4600 2850
Wire Wire Line
	4600 2850 4600 2750
Text GLabel 3200 4750 2    39   Input ~ 0
OVRFLW_SENSE
Text Notes 550  1400 0    39   ~ 0
ATmega inputs must be within -+0.5 V of ground and Vcc. Pick series resistance\nso that BAT54S current is less than 50 mA (typ value for Vf = 0.5): 150 R.\nBAT54S adds 10 pF bus capacitance.\n
Text Notes 550  1100 0    39   ~ 0
I2C Design\n* Standard Speed (100 KHz, 10 us period)\n* Rise/Fall time = 1 us\n* Given 200R input series resistance pullup must be [2K7, 4K5]\n   assuming max allowed 400 pF bus capacitance\n* Pull up only on pump side, not on probes\n* Total bus capacitance < 400 pFu
$Comp
L probe_b-rescue:BAT54S-7-F-dk_Diodes-Rectifiers-Arrays D1
U 1 1 5B9DFD9E
P 3650 1300
F 0 "D1" H 3900 1350 60  0000 C BNN
F 1 "BAT54S-7-F" H 3550 1100 60  0000 C CNN
F 2 "digikey-footprints:SOT-23-3" H 3850 1500 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 3850 1600 60  0001 L CNN
F 4 "BAT54S-FDICT-ND" H 3850 1700 60  0001 L CNN "Digi-Key_PN"
F 5 "BAT54S-7-F" H 3850 1800 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 3850 1900 60  0001 L CNN "Category"
F 7 "Diodes - Rectifiers - Arrays" H 3850 2000 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 3850 2100 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/BAT54S-7-F/BAT54S-FDICT-ND/755493" H 3850 2200 60  0001 L CNN "DK_Detail_Page"
F 10 "DIODE ARRAY SCHOTTKY 30V SOT23-3" H 3850 2300 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 3850 2400 60  0001 L CNN "Manufacturer"
F 12 "Active" H 3850 2500 60  0001 L CNN "Status"
	1    3650 1300
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:BAT54S-7-F-dk_Diodes-Rectifiers-Arrays D3
U 1 1 5B9E0005
P 4050 1300
F 0 "D3" H 4300 1350 60  0000 C BNN
F 1 "BAT54S-7-F" H 4050 1100 60  0000 C CNN
F 2 "digikey-footprints:SOT-23-3" H 4250 1500 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4250 1600 60  0001 L CNN
F 4 "BAT54S-FDICT-ND" H 4250 1700 60  0001 L CNN "Digi-Key_PN"
F 5 "BAT54S-7-F" H 4250 1800 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 4250 1900 60  0001 L CNN "Category"
F 7 "Diodes - Rectifiers - Arrays" H 4250 2000 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4250 2100 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/BAT54S-7-F/BAT54S-FDICT-ND/755493" H 4250 2200 60  0001 L CNN "DK_Detail_Page"
F 10 "DIODE ARRAY SCHOTTKY 30V SOT23-3" H 4250 2300 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 4250 2400 60  0001 L CNN "Manufacturer"
F 12 "Active" H 4250 2500 60  0001 L CNN "Status"
	1    4050 1300
	0    1    1    0   
$EndComp
$Comp
L probe_b-rescue:BAT54S-7-F-dk_Diodes-Rectifiers-Arrays D4
U 1 1 5B9E0534
P 4500 2550
F 0 "D4" H 4750 2450 60  0000 C BNN
F 1 "BAT54S-7-F" H 4300 2550 60  0000 C CNN
F 2 "digikey-footprints:SOT-23-3" H 4700 2750 60  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4700 2850 60  0001 L CNN
F 4 "BAT54S-FDICT-ND" H 4700 2950 60  0001 L CNN "Digi-Key_PN"
F 5 "BAT54S-7-F" H 4700 3050 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 4700 3150 60  0001 L CNN "Category"
F 7 "Diodes - Rectifiers - Arrays" H 4700 3250 60  0001 L CNN "Family"
F 8 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4700 3350 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/diodes-incorporated/BAT54S-7-F/BAT54S-FDICT-ND/755493" H 4700 3450 60  0001 L CNN "DK_Detail_Page"
F 10 "DIODE ARRAY SCHOTTKY 30V SOT23-3" H 4700 3550 60  0001 L CNN "Description"
F 11 "Diodes Incorporated" H 4700 3650 60  0001 L CNN "Manufacturer"
F 12 "Active" H 4700 3750 60  0001 L CNN "Status"
	1    4500 2550
	0    -1   -1   0   
$EndComp
Wire Notes Line
	6300 3300 550  3300
Text GLabel 1300 4950 0    39   Input ~ 0
TEMP+
$Comp
L probe_b-rescue:GND #PWR02
U 1 1 5BA25B56
P 1200 6000
F 0 "#PWR02" H 1200 5750 50  0001 C CNN
F 1 "GND" H 1200 5850 50  0000 C CNN
F 2 "" H 1200 6000 50  0001 C CNN
F 3 "" H 1200 6000 50  0001 C CNN
	1    1200 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 5700 1200 5800
Wire Wire Line
	1200 5800 1200 5900
Wire Wire Line
	1200 5900 1200 6000
Wire Wire Line
	1200 5900 1300 5900
Wire Wire Line
	1200 5800 1300 5800
Connection ~ 1200 5900
Wire Wire Line
	1300 5700 1200 5700
Connection ~ 1200 5800
Text GLabel 3300 2700 2    39   Input ~ 0
DBG_A0
Text GLabel 3300 2600 2    39   Input ~ 0
DBG_A1
Text GLabel 3300 2500 2    39   Input ~ 0
DBG_A2
$Comp
L probe_b-rescue:PWR_FLAG #FLG01
U 1 1 5BA42E23
P 6850 1550
F 0 "#FLG01" H 6850 1625 50  0001 C CNN
F 1 "PWR_FLAG" H 6850 1700 50  0000 C CNN
F 2 "" H 6850 1550 50  0001 C CNN
F 3 "" H 6850 1550 50  0001 C CNN
	1    6850 1550
	1    0    0    -1  
$EndComp
Text Notes 4750 6100 0    39   ~ 0
AINn has input leakage of ±50 nA @ Vcc = 5 V and Vin = Vcc/2.\nTo make it negligible we want the current into the pin to be\nlimited to at most 10x at Vcc/2: \nVcc/(2*R) < 500 nA -> R < 1M\n\nLet RC_REF = K*Vcc, then the time until we charge the input to\nRC_REF and the comparator switches is RC seconds where we controll R\nand C is the senssed capacitance. Using a timer at F Hz the precision\nof measured C is dC = min(dT)/(-R*ln(1-K)) = 1 / (-F*R*ln(1-K)) and if the timer has n-bits the range\nof measurable C is 2^n/(F*R*ln(1-K)).\n\nAssume we pick K=0.75, R=1M and have F = 8 MHz (internal RC osc.) then dC = 90 fF.\nIf we pick 24 bits for the counter, we get a range of C from 0 to around 1.5 µF.
$Comp
L probe_b-rescue:R R28
U 1 1 5B9A88B7
P 6450 7250
F 0 "R28" V 6350 7250 50  0000 C CNN
F 1 "100K" V 6450 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6380 7250 50  0001 C CNN
F 3 "" H 6450 7250 50  0001 C CNN
	1    6450 7250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6200 7250 6250 7250
Wire Wire Line
	6250 7250 6300 7250
Wire Wire Line
	5900 7250 5850 7250
Wire Wire Line
	5550 7250 5500 7250
Text GLabel 5100 7500 0    39   Input ~ 0
~RC_EXC
Wire Wire Line
	5100 7500 5100 7250
Wire Wire Line
	5100 7250 5200 7250
Text Notes 5100 7100 0    39   ~ 0
Implements K = 0.75\n\nDriving the divider from the gpio pin is a\nbit noisy but it is also a fairly heavy RC filter.\nSo it should be OK.
Text GLabel 6700 7450 3    39   Input ~ 0
AVcc
Wire Wire Line
	6250 7250 6250 7500
Wire Wire Line
	6250 7500 6250 7600
Connection ~ 6250 7250
Text GLabel 3200 5700 2    39   Input ~ 0
~RC_EXC
$Comp
L probe_b-rescue:R R27
U 1 1 5B9BD76E
P 6050 7250
F 0 "R27" V 5950 7250 50  0000 C CNN
F 1 "100K" V 6050 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5980 7250 50  0001 C CNN
F 3 "" H 6050 7250 50  0001 C CNN
	1    6050 7250
	0    -1   -1   0   
$EndComp
$Comp
L probe_b-rescue:R R26
U 1 1 5B9BD86A
P 5700 7250
F 0 "R26" V 5600 7250 50  0000 C CNN
F 1 "100K" V 5700 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5630 7250 50  0001 C CNN
F 3 "" H 5700 7250 50  0001 C CNN
	1    5700 7250
	0    -1   -1   0   
$EndComp
$Comp
L probe_b-rescue:R R22
U 1 1 5B9BD9A0
P 5350 7250
F 0 "R22" V 5250 7250 50  0000 C CNN
F 1 "100K" V 5350 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5280 7250 50  0001 C CNN
F 3 "" H 5350 7250 50  0001 C CNN
	1    5350 7250
	0    -1   -1   0   
$EndComp
Text GLabel 5300 3550 0    39   Input ~ 0
AVcc
Wire Wire Line
	5300 3550 5400 3550
Wire Wire Line
	5400 3550 5400 3650
Wire Wire Line
	6600 7250 6700 7250
Wire Wire Line
	6700 7250 6700 7450
$Comp
L probe_b-rescue:C C5
U 1 1 5B9E158E
P 5900 7500
F 0 "C5" H 5925 7600 50  0000 L CNN
F 1 "100nF" H 5950 7400 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5938 7350 50  0001 C CNN
F 3 "" H 5900 7500 50  0001 C CNN
	1    5900 7500
	0    1    1    0   
$EndComp
Wire Wire Line
	6250 7500 6050 7500
Connection ~ 6250 7500
$Comp
L probe_b-rescue:C C4
U 1 1 5B9E27F7
P 5100 4250
F 0 "C4" H 5125 4350 50  0000 L CNN
F 1 "100nF" H 5150 4150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5138 4100 50  0001 C CNN
F 3 "" H 5100 4250 50  0001 C CNN
	1    5100 4250
	-1   0    0    1   
$EndComp
Wire Wire Line
	5100 4100 5100 4000
Connection ~ 5100 4000
Wire Wire Line
	5100 4400 5100 4500
Text GLabel 5400 4500 2    39   Input ~ 0
~TEMP_EXC
Text GLabel 3200 3700 2    39   Input ~ 0
~TEMP_EXC
$Comp
L probe_b-rescue:L L1
U 1 1 5B9C208A
P 7400 1550
F 0 "L1" V 7350 1550 50  0000 C CNN
F 1 "10uH" V 7475 1550 50  0000 C CNN
F 2 "digikey-footprints:1210" H 7400 1550 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=LBC3225T100KR&fileName=LBC3225T100KR_SS&mode=specSheetDownload" H 7400 1550 50  0001 C CNN
	1    7400 1550
	0    1    -1   0   
$EndComp
NoConn ~ 3200 5500
NoConn ~ 3200 5600
NoConn ~ 3200 4300
NoConn ~ 3200 3800
NoConn ~ 3200 5400
Text GLabel 3200 4550 2    39   Input ~ 0
DBG_A0
Text GLabel 3200 4450 2    39   Input ~ 0
DBG_A1
Text GLabel 1300 5050 0    39   Input ~ 0
DBG_A2
$Comp
L probe_b-rescue:GND #PWR0101
U 1 1 5BA656C9
P 2550 2550
F 0 "#PWR0101" H 2550 2300 50  0001 C CNN
F 1 "GND" H 2550 2400 50  0000 C CNN
F 2 "" H 2550 2550 50  0001 C CNN
F 3 "" H 2550 2550 50  0001 C CNN
	1    2550 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 2550 2550 2500
Wire Wire Line
	2550 2500 2800 2500
$Comp
L probe_b-rescue:MIC94090-mic94090 U2
U 1 1 5B9D4F60
P 5250 5250
F 0 "U2" H 5675 5959 47  0000 C CNN
F 1 "MIC94090" H 5675 5872 47  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6" H 5150 5250 47  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/mic9409x.pdf" H 5150 5250 47  0001 C CNN
	1    5250 5250
	-1   0    0    -1  
$EndComp
Text GLabel 4400 5000 0    39   Input ~ 0
Vcc
Wire Wire Line
	4150 5000 4150 4900
Wire Wire Line
	4150 4900 4400 4900
$Comp
L probe_b-rescue:GND #PWR0102
U 1 1 5B9E6B2B
P 5350 5000
F 0 "#PWR0102" H 5350 4750 50  0001 C CNN
F 1 "GND" H 5350 4850 50  0000 C CNN
F 2 "" H 5350 5000 50  0001 C CNN
F 3 "" H 5350 5000 50  0001 C CNN
	1    5350 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 5000 5350 4900
Wire Wire Line
	5350 4900 5250 4900
$Comp
L Connector:Screw_Terminal_01x02 J3
U 1 1 5B9F2DD9
P 6300 4900
F 0 "J3" H 6300 5000 50  0000 C CNN
F 1 "PUMP" H 6350 4700 50  0000 C CNN
F 2 "emilibeda:PhoenixContact_MSTBVA-G_02x5.00mm_Vertical" H 6300 4900 50  0001 C CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Phoenix%20Contact%20PDFs/1935161.pdf" H 6300 4900 50  0001 C CNN
	1    6300 4900
	1    0    0    1   
$EndComp
$Comp
L probe_b-rescue:GND #PWR0103
U 1 1 5B9F8528
P 6000 5000
F 0 "#PWR0103" H 6000 4750 50  0001 C CNN
F 1 "GND" H 6000 4850 50  0000 C CNN
F 2 "" H 6000 5000 50  0001 C CNN
F 3 "" H 6000 5000 50  0001 C CNN
	1    6000 5000
	1    0    0    -1  
$EndComp
Text GLabel 4400 4800 0    39   Input ~ 0
PUMP
Text Notes 6700 4850 0    50   ~ 0
Max 5V@400mA (2W)
Text GLabel 3200 4650 2    39   Input ~ 0
PUMP
Wire Wire Line
	5250 4800 5450 4800
Wire Wire Line
	5450 4900 5450 4800
Connection ~ 5450 4800
$Comp
L probe_b-rescue:GND #PWR0104
U 1 1 5B9E0C5A
P 8100 4350
F 0 "#PWR0104" H 8100 4100 50  0001 C CNN
F 1 "GND" H 8100 4200 50  0000 C CNN
F 2 "" H 8100 4350 50  0001 C CNN
F 3 "" H 8100 4350 50  0001 C CNN
	1    8100 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J1
U 1 1 5B9231A7
P 3000 2700
F 0 "J1" H 3050 3000 50  0000 C CNN
F 1 "ICSP" H 3050 2250 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x06_Pitch2.54mm" H 3000 2700 50  0001 C CNN
F 3 "" H 3000 2700 50  0001 C CNN
	1    3000 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 4900 5550 4900
Wire Wire Line
	6000 5000 6000 4900
$Comp
L probe_b-rescue:MBR0520LT1G-dk_Diodes-Rectifiers-Single D6
U 1 1 5BA31025
P 5750 4900
F 0 "D6" H 5750 4638 60  0000 C CNN
F 1 "MBR0520LT1G" H 5750 4744 60  0000 C CNN
F 2 "digikey-footprints:SOD-123" H 5950 5100 60  0001 L CNN
F 3 "http://www.onsemi.com/pub/Collateral/MBR0520LT1-D.PDF" H 5950 5200 60  0001 L CNN
F 4 "MBR0520LT1GOSCT-ND" H 5950 5300 60  0001 L CNN "Digi-Key_PN"
F 5 "MBR0520LT1G" H 5950 5400 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 5950 5500 60  0001 L CNN "Category"
F 7 "Diodes - Rectifiers - Single" H 5950 5600 60  0001 L CNN "Family"
F 8 "http://www.onsemi.com/pub/Collateral/MBR0520LT1-D.PDF" H 5950 5700 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/MBR0520LT1G/MBR0520LT1GOSCT-ND/917965" H 5950 5800 60  0001 L CNN "DK_Detail_Page"
F 10 "DIODE SCHOTTKY 20V 500MA SOD123" H 5950 5900 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 5950 6000 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5950 6100 60  0001 L CNN "Status"
	1    5750 4900
	-1   0    0    1   
$EndComp
Wire Wire Line
	6000 4900 5950 4900
Connection ~ 6000 4900
Wire Wire Line
	4950 950  4950 2150
Wire Wire Line
	4750 1150 4750 1800
Wire Wire Line
	4850 1050 4850 1700
Wire Wire Line
	4950 950  5200 950 
Wire Wire Line
	5200 1050 4850 1050
Wire Wire Line
	4750 1150 5200 1150
Wire Wire Line
	5050 1350 5050 1250
Wire Wire Line
	5050 1250 5200 1250
$Comp
L probe_b-rescue:GND #PWR0105
U 1 1 5BAE6019
P 4750 950
F 0 "#PWR0105" H 4750 700 50  0001 C CNN
F 1 "GND" H 4750 800 50  0000 C CNN
F 2 "" H 4750 950 50  0001 C CNN
F 3 "" H 4750 950 50  0001 C CNN
	1    4750 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 950  4750 850 
Wire Wire Line
	4750 850  5200 850 
Wire Wire Line
	5100 1700 5100 2000
Wire Wire Line
	5800 2000 5800 1800
Wire Wire Line
	5800 1800 5700 1800
Wire Wire Line
	4850 1700 5100 1700
Wire Wire Line
	5100 2000 5800 2000
Wire Wire Line
	5200 1350 5200 1700
Wire Wire Line
	5900 1800 5900 1700
Wire Wire Line
	5900 1700 5700 1700
Wire Wire Line
	6000 4900 6100 4900
Text GLabel 8100 3750 2    39   Input ~ 0
PWRLED
Text GLabel 3200 4200 2    39   Input ~ 0
PWRLED
Text GLabel 4550 5700 0    39   Input ~ 0
RC_EN
Text GLabel 3200 3600 2    39   Input ~ 0
RC_EN
Wire Wire Line
	5450 4800 6100 4800
$Comp
L probe_b-rescue:TEST_1P J2
U 1 1 5BA40C68
P 4400 4800
F 0 "J2" H 4400 5070 50  0000 C CNN
F 1 "PUMP" H 4400 5000 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 4600 4800 50  0001 C CNN
F 3 "" H 4600 4800 50  0001 C CNN
	1    4400 4800
	-1   0    0    -1  
$EndComp
$Comp
L probe_b-rescue:TEST_1P J4
U 1 1 5BA4C31B
P 4050 6500
F 0 "J4" H 4050 6770 50  0000 C CNN
F 1 "C_sense" H 4050 6700 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 4250 6500 50  0001 C CNN
F 3 "" H 4250 6500 50  0001 C CNN
	1    4050 6500
	1    0    0    1   
$EndComp
$Comp
L probe_b-rescue:R R?
U 1 1 5BB9A8B1
P 4050 6200
F 0 "R?" V 4130 6200 50  0000 C CNN
F 1 "0R" V 4050 6200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3980 6200 50  0001 C CNN
F 3 "" H 4050 6200 50  0001 C CNN
	1    4050 6200
	-1   0    0    1   
$EndComp
Wire Wire Line
	3200 5900 4050 5900
Wire Wire Line
	4050 6050 4050 5900
Connection ~ 4050 5900
Wire Wire Line
	4050 5900 4150 5900
Wire Wire Line
	4050 6350 4050 6500
Text Notes 3800 7100 1    39   ~ 0
Allow disconnecting the C pattern to \nmeasure overhead capacitance.
Wire Wire Line
	5550 7500 5750 7500
$Comp
L probe_b-rescue:GND #PWR?
U 1 1 5BBC2F4B
P 5550 7500
F 0 "#PWR?" H 5550 7250 50  0001 C CNN
F 1 "GND" H 5550 7350 50  0000 C CNN
F 2 "" H 5550 7500 50  0001 C CNN
F 3 "" H 5550 7500 50  0001 C CNN
	1    5550 7500
	1    0    0    -1  
$EndComp
$Comp
L probe_b-rescue:GND #PWR?
U 1 1 5BBCEFE7
P 5100 4500
F 0 "#PWR?" H 5100 4250 50  0001 C CNN
F 1 "GND" H 5100 4350 50  0000 C CNN
F 2 "" H 5100 4500 50  0001 C CNN
F 3 "" H 5100 4500 50  0001 C CNN
	1    5100 4500
	1    0    0    -1  
$EndComp
Text Notes 5000 2750 0    50   ~ 0
Not AVcc to the overflow sensor to avoid \nnoise coupling into AVcc from the long wire.
$EndSCHEMATC
