EESchema Schematic File Version 4
LIBS:root_node-cache
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
Text Notes 7000 6750 0    50   ~ 0
Design for root node with power\ndelivery and communication
$Comp
L Connector:Barrel_Jack_Switch J1
U 1 1 5CCD4D73
P 3250 1300
F 0 "J1" H 3305 1617 50  0000 C CNN
F 1 "Barrel_Jack_Switch" H 3305 1526 50  0000 C CNN
F 2 "" H 3300 1260 50  0001 C CNN
F 3 "~" H 3300 1260 50  0001 C CNN
	1    3250 1300
	1    0    0    -1  
$EndComp
$Comp
L Interface_Expansion:P82B96 U1
U 1 1 5CCD51B5
P 2650 3750
F 0 "U1" H 2650 4367 50  0000 C CNN
F 1 "P82B96" H 2650 4276 50  0000 C CNN
F 2 "" H 2650 3750 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/P82B96.pdf" H 2650 3750 50  0001 C CNN
	1    2650 3750
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J2
U 1 1 5CCD5344
P 6650 3800
F 0 "J2" H 6700 4917 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 6700 4826 50  0000 C CNN
F 2 "" H 6650 3800 50  0001 C CNN
F 3 "~" H 6650 3800 50  0001 C CNN
	1    6650 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5CCD6106
P 3700 3150
F 0 "R7" V 3800 3100 50  0000 L CNN
F 1 "330R" V 3700 3050 50  0000 L CNN
F 2 "" V 3630 3150 50  0001 C CNN
F 3 "~" H 3700 3150 50  0001 C CNN
	1    3700 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5CCD6144
P 3450 3150
F 0 "R6" V 3550 3100 50  0000 L CNN
F 1 "330R" V 3450 3050 50  0000 L CNN
F 2 "" V 3380 3150 50  0001 C CNN
F 3 "~" H 3450 3150 50  0001 C CNN
	1    3450 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5CCD6210
P 1750 4150
F 0 "C2" H 1600 4000 50  0000 L CNN
F 1 "220 pF" V 1600 4050 50  0000 L CNN
F 2 "" H 1788 4000 50  0001 C CNN
F 3 "~" H 1750 4150 50  0001 C CNN
	1    1750 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5CCD6242
P 1400 4150
F 0 "C1" H 1250 4000 50  0000 L CNN
F 1 "220 pF" V 1250 4050 50  0000 L CNN
F 2 "" H 1438 4000 50  0001 C CNN
F 3 "~" H 1400 4150 50  0001 C CNN
	1    1400 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5CCD6288
P 1750 3350
F 0 "R5" V 1850 3300 50  0000 L CNN
F 1 "1K" V 1750 3300 50  0000 L CNN
F 2 "" V 1680 3350 50  0001 C CNN
F 3 "~" H 1750 3350 50  0001 C CNN
	1    1750 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5CCD62F8
P 1400 3350
F 0 "R3" V 1500 3300 50  0000 L CNN
F 1 "1K" V 1400 3300 50  0000 L CNN
F 2 "" V 1330 3350 50  0001 C CNN
F 3 "~" H 1400 3350 50  0001 C CNN
	1    1400 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 3450 3350 3450
Wire Wire Line
	3350 3450 3350 3650
Wire Wire Line
	3350 3650 3250 3650
Wire Wire Line
	3250 3850 3350 3850
Wire Wire Line
	3350 3850 3350 4050
Wire Wire Line
	3350 4050 3250 4050
$Comp
L Diode:BAT54S D2
U 1 1 5CCD6EBB
P 4200 4250
F 0 "D2" H 4200 4382 50  0000 C CNN
F 1 "BAT54S" H 4200 4473 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4275 4375 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4080 4250 50  0001 C CNN
	1    4200 4250
	1    0    0    1   
$EndComp
$Comp
L Diode:BAT54S D1
U 1 1 5CCD7493
P 4200 3450
F 0 "D1" H 4200 3675 50  0000 C CNN
F 1 "BAT54S" H 4200 3584 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4275 3575 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 4080 3450 50  0001 C CNN
	1    4200 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3650 3700 3650
Connection ~ 3350 3650
Wire Wire Line
	3350 4050 3450 4050
Connection ~ 3350 4050
Wire Wire Line
	3900 3450 3800 3450
Wire Wire Line
	3800 3450 3800 4250
Wire Wire Line
	3800 4250 3900 4250
Wire Wire Line
	3800 4250 3800 4400
Connection ~ 3800 4250
Wire Wire Line
	4500 4250 4600 4250
Wire Wire Line
	4600 4250 4600 3450
Wire Wire Line
	4600 3450 4500 3450
Wire Wire Line
	3450 3300 3450 4050
Connection ~ 3450 4050
Wire Wire Line
	3450 4050 4200 4050
Wire Wire Line
	3700 3300 3700 3650
Connection ~ 3700 3650
Wire Wire Line
	3700 3650 4200 3650
Wire Wire Line
	3450 3000 3450 2850
Wire Wire Line
	3450 2850 3700 2850
Wire Wire Line
	4600 2850 4600 3450
Connection ~ 4600 3450
Wire Wire Line
	3700 3000 3700 2850
Connection ~ 3700 2850
Wire Wire Line
	3700 2850 4600 2850
Wire Wire Line
	3150 2850 3450 2850
Connection ~ 3450 2850
Text GLabel 3150 2850 0    50   UnSpc ~ 0
i2c_high
Text GLabel 4700 3650 2    50   BiDi ~ 0
i2c_sda_out
Text GLabel 4700 4050 2    50   BiDi ~ 0
i2c_scl_out
$Comp
L power:GND #PWR03
U 1 1 5CCD9688
P 3800 4400
F 0 "#PWR03" H 3800 4150 50  0001 C CNN
F 1 "GND" H 3805 4227 50  0000 C CNN
F 2 "" H 3800 4400 50  0001 C CNN
F 3 "" H 3800 4400 50  0001 C CNN
	1    3800 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 3850 1400 3850
Wire Wire Line
	1400 3500 1400 3850
Connection ~ 1400 3850
Wire Wire Line
	1400 3850 1250 3850
Wire Wire Line
	1400 3850 1400 4000
Wire Wire Line
	2050 3650 1750 3650
Wire Wire Line
	1750 4000 1750 3650
Connection ~ 1750 3650
Wire Wire Line
	1750 3650 1250 3650
Wire Wire Line
	1750 3650 1750 3500
Wire Wire Line
	2050 4050 2000 4050
Wire Wire Line
	2000 4050 2000 4450
Wire Wire Line
	2000 4450 1750 4450
Wire Wire Line
	1400 4450 1400 4300
Wire Wire Line
	1750 4300 1750 4450
Connection ~ 1750 4450
Wire Wire Line
	1750 4450 1400 4450
$Comp
L power:GND #PWR02
U 1 1 5CCE1156
P 1750 4450
F 0 "#PWR02" H 1750 4200 50  0001 C CNN
F 1 "GND" H 1755 4277 50  0000 C CNN
F 2 "" H 1750 4450 50  0001 C CNN
F 3 "" H 1750 4450 50  0001 C CNN
	1    1750 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 3100 1750 3100
Wire Wire Line
	1400 3100 1400 3200
Connection ~ 1400 3100
Wire Wire Line
	1400 3100 1250 3100
Wire Wire Line
	1750 3200 1750 3100
Connection ~ 1750 3100
Wire Wire Line
	1750 3100 1400 3100
Wire Wire Line
	2050 3450 2000 3450
Wire Wire Line
	2000 3450 2000 3100
Text GLabel 1250 3650 0    50   BiDi ~ 0
i2c_sda_in
Text GLabel 1250 3850 0    50   BiDi ~ 0
i2c_scl_in
Text GLabel 7400 1400 2    50   UnSpc ~ 0
5V
$Comp
L Device:L_Small L1
U 1 1 5CCF2FD2
P 6250 1400
F 0 "L1" V 6200 1400 50  0000 C CNN
F 1 "150 uH" V 6344 1400 50  0000 C CNN
F 2 "" H 6250 1400 50  0001 C CNN
F 3 "~" H 6250 1400 50  0001 C CNN
	1    6250 1400
	0    -1   -1   0   
$EndComp
$Comp
L Device:L_Small L2
U 1 1 5CCF307F
P 6750 1400
F 0 "L2" V 6700 1400 50  0000 C CNN
F 1 "20 uH" V 6844 1400 50  0000 C CNN
F 2 "" H 6750 1400 50  0001 C CNN
F 3 "~" H 6750 1400 50  0001 C CNN
	1    6750 1400
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N5822 D3
U 1 1 5CCF4B1E
P 6050 1650
F 0 "D3" H 6100 1700 50  0000 L CNN
F 1 "1N5822" H 5900 1800 50  0000 L CNN
F 2 "Diode_THT:D_DO-201AD_P15.24mm_Horizontal" H 6050 1475 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88526/1n5820.pdf" H 6050 1650 50  0001 C CNN
	1    6050 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	5950 1400 6050 1400
Wire Wire Line
	6050 1500 6050 1400
Connection ~ 6050 1400
Wire Wire Line
	6050 1400 6150 1400
Wire Wire Line
	6350 1400 6500 1400
Wire Wire Line
	6500 1500 6500 1400
Connection ~ 6500 1400
Wire Wire Line
	6500 1400 6650 1400
Wire Wire Line
	6500 1400 6500 1200
Wire Wire Line
	6500 1200 5950 1200
Wire Wire Line
	6850 1400 7000 1400
Wire Wire Line
	7000 1400 7000 1500
Wire Wire Line
	7000 1400 7250 1400
Connection ~ 7000 1400
Wire Wire Line
	6050 1800 6050 1900
Wire Wire Line
	6050 1900 5450 1900
Wire Wire Line
	5450 1900 5450 1600
Wire Wire Line
	6050 1900 6500 1900
Wire Wire Line
	6500 1900 6500 1800
Connection ~ 6050 1900
Wire Wire Line
	7000 1900 6500 1900
Connection ~ 6500 1900
$Comp
L Regulator_Switching:LM2576T-5 U2
U 1 1 5CCEF32A
P 5450 1300
F 0 "U2" H 5450 1667 50  0000 C CNN
F 1 "LM2576T-5" H 5450 1576 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-5_Vertical" H 5450 1050 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2576.pdf" H 5450 1300 50  0001 C CNN
	1    5450 1300
	1    0    0    -1  
$EndComp
Text GLabel 1600 1250 2    50   Output ~ 0
V_REG_EN_N
$Comp
L Transistor_BJT:2N3904 Q1
U 1 1 5CD490E3
P 1350 1500
F 0 "Q1" H 1541 1546 50  0000 L CNN
F 1 "2N3904" H 1541 1455 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 1550 1425 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 1350 1500 50  0001 L CNN
	1    1350 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5CD503F3
P 1450 1050
F 0 "R4" V 1550 1000 50  0000 L CNN
F 1 "47K" V 1450 950 50  0000 L CNN
F 2 "" V 1380 1050 50  0001 C CNN
F 3 "~" H 1450 1050 50  0001 C CNN
	1    1450 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5CD50457
P 1050 1050
F 0 "R1" V 1150 1000 50  0000 L CNN
F 1 "10K" V 1050 950 50  0000 L CNN
F 2 "" V 980 1050 50  0001 C CNN
F 3 "~" H 1050 1050 50  0001 C CNN
	1    1050 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5CD504A3
P 1050 1750
F 0 "R2" V 1150 1700 50  0000 L CNN
F 1 "10K" V 1050 1650 50  0000 L CNN
F 2 "" V 980 1750 50  0001 C CNN
F 3 "~" H 1050 1750 50  0001 C CNN
	1    1050 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1050 900  1050 850 
Wire Wire Line
	1050 850  1450 850 
Wire Wire Line
	1450 900  1450 850 
Wire Wire Line
	1450 1200 1450 1250
Wire Wire Line
	1450 1250 1600 1250
Connection ~ 1450 1250
Wire Wire Line
	1450 1250 1450 1300
Wire Wire Line
	1050 1200 1050 1500
Wire Wire Line
	1050 1500 1150 1500
Wire Wire Line
	1050 1500 1050 1600
Connection ~ 1050 1500
Wire Wire Line
	1050 1900 1050 2000
Wire Wire Line
	1050 2000 1450 2000
Wire Wire Line
	1450 2000 1450 1700
Connection ~ 1050 850 
Connection ~ 1050 2000
Text GLabel 950  850  0    50   UnSpc ~ 0
12V
$Comp
L power:GND #PWR01
U 1 1 5CD806B2
P 1050 2000
F 0 "#PWR01" H 1050 1750 50  0001 C CNN
F 1 "GND" H 1055 1827 50  0000 C CNN
F 2 "" H 1050 2000 50  0001 C CNN
F 3 "" H 1050 2000 50  0001 C CNN
	1    1050 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  850  1050 850 
Wire Notes Line
	2850 500  2850 2300
Text Notes 550  700  0    50   ~ 0
Undervoltage lockout \n(optional, do not populate, short pins 1 and 3 to avoid)
Text GLabel 4900 1450 3    50   Input ~ 0
V_REG_EN_N
$Comp
L Device:CP C3
U 1 1 5CD50595
P 4600 1500
F 0 "C3" V 4650 1350 50  0000 L CNN
F 1 "100uF" V 4750 1350 50  0000 L CNN
F 2 "" H 4638 1350 50  0001 C CNN
F 3 "~" H 4600 1500 50  0001 C CNN
	1    4600 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1700 4600 1650
Wire Wire Line
	4600 1350 4600 1200
Wire Wire Line
	4600 1200 4950 1200
$Comp
L Device:Polyfuse F1
U 1 1 5CDC4576
P 3800 1200
F 0 "F1" V 3575 1200 50  0000 C CNN
F 1 "Polyfuse" V 3666 1200 50  0000 C CNN
F 2 "" H 3850 1000 50  0001 L CNN
F 3 "~" H 3800 1200 50  0001 C CNN
	1    3800 1200
	0    1    1    0   
$EndComp
$Comp
L Device:Q_PMOS_GDSD Q2
U 1 1 5CDC48A7
P 4250 1300
F 0 "Q2" V 4675 1300 50  0000 C CNN
F 1 "Q_PMOS_GDSD" V 4584 1300 50  0000 C CNN
F 2 "" H 4450 1400 50  0001 C CNN
F 3 "~" H 4250 1300 50  0001 C CNN
	1    4250 1300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3550 1200 3650 1200
Wire Wire Line
	3950 1200 4050 1200
Wire Wire Line
	4050 1200 4050 1100
Connection ~ 4050 1200
Wire Wire Line
	4450 1200 4600 1200
Connection ~ 4600 1200
Wire Wire Line
	4250 1500 4250 1700
Wire Wire Line
	4250 1700 4600 1700
Wire Wire Line
	3550 1300 3550 1400
Wire Wire Line
	3550 1400 3550 1700
Wire Wire Line
	3550 1700 4250 1700
Connection ~ 3550 1400
Connection ~ 4250 1700
Text GLabel 4750 950  2    50   UnSpc ~ 0
12V
Wire Wire Line
	4750 950  4600 950 
Wire Wire Line
	4600 950  4600 1200
$Comp
L Connector_Generic:Conn_01x06 J5
U 1 1 5CDE9BFD
P 10200 1250
F 0 "J5" H 10280 1242 50  0000 L CNN
F 1 "Conn_01x06" H 10280 1151 50  0000 L CNN
F 2 "" H 10200 1250 50  0001 C CNN
F 3 "~" H 10200 1250 50  0001 C CNN
	1    10200 1250
	1    0    0    -1  
$EndComp
Text GLabel 9900 1050 0    50   UnSpc ~ 0
12V
$Comp
L power:GND #PWR08
U 1 1 5CDE9DFD
P 9900 1650
F 0 "#PWR08" H 9900 1400 50  0001 C CNN
F 1 "GND" H 9905 1477 50  0000 C CNN
F 2 "" H 9900 1650 50  0001 C CNN
F 3 "" H 9900 1650 50  0001 C CNN
	1    9900 1650
	1    0    0    -1  
$EndComp
Text GLabel 9900 1250 0    50   BiDi ~ 0
i2c_sda_out
Text GLabel 9900 1350 0    50   BiDi ~ 0
i2c_scl_out
Wire Wire Line
	6950 3000 7050 3000
Wire Wire Line
	7050 3000 7050 2900
Wire Wire Line
	7050 2900 6950 2900
Wire Wire Line
	7050 2900 7150 2900
Connection ~ 7050 2900
Text GLabel 7150 2900 2    50   UnSpc ~ 0
5V
Wire Wire Line
	6450 3300 6350 3300
Wire Wire Line
	6350 3300 6350 4100
Wire Wire Line
	6350 4100 6450 4100
Wire Wire Line
	6350 4100 6350 4800
Wire Wire Line
	6350 4800 6450 4800
Connection ~ 6350 4100
Wire Wire Line
	6350 4800 6350 4950
Connection ~ 6350 4800
Wire Wire Line
	6950 4500 7050 4500
Wire Wire Line
	7050 4500 7050 4300
Wire Wire Line
	7050 4300 6950 4300
Wire Wire Line
	7050 4300 7050 3800
Wire Wire Line
	7050 3800 6950 3800
Connection ~ 7050 4300
Wire Wire Line
	7050 3800 7050 3500
Wire Wire Line
	7050 3500 6950 3500
Connection ~ 7050 3800
Wire Wire Line
	7050 3500 7050 3100
Wire Wire Line
	7050 3100 6950 3100
Connection ~ 7050 3500
Wire Wire Line
	7050 4500 7050 4950
Connection ~ 7050 4500
$Comp
L power:GND #PWR05
U 1 1 5CE32378
P 6350 4950
F 0 "#PWR05" H 6350 4700 50  0001 C CNN
F 1 "GND" H 6355 4777 50  0000 C CNN
F 2 "" H 6350 4950 50  0001 C CNN
F 3 "" H 6350 4950 50  0001 C CNN
	1    6350 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5CE323B5
P 7050 4950
F 0 "#PWR07" H 7050 4700 50  0001 C CNN
F 1 "GND" H 7055 4777 50  0000 C CNN
F 2 "" H 7050 4950 50  0001 C CNN
F 3 "" H 7050 4950 50  0001 C CNN
	1    7050 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1450 4900 1400
Wire Wire Line
	4900 1400 4950 1400
$Comp
L power:GND #PWR06
U 1 1 5CE7C36B
P 6500 1900
F 0 "#PWR06" H 6500 1650 50  0001 C CNN
F 1 "GND" H 6505 1727 50  0000 C CNN
F 2 "" H 6500 1900 50  0001 C CNN
F 3 "" H 6500 1900 50  0001 C CNN
	1    6500 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5CE7C3A8
P 4250 1700
F 0 "#PWR04" H 4250 1450 50  0001 C CNN
F 1 "GND" H 4255 1527 50  0000 C CNN
F 2 "" H 4250 1700 50  0001 C CNN
F 3 "" H 4250 1700 50  0001 C CNN
	1    4250 1700
	1    0    0    -1  
$EndComp
Text Notes 2900 600  0    50   ~ 0
Power delivery
Text GLabel 9900 1150 0    50   UnSpc ~ 0
V_node
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J3
U 1 1 5CE972E3
P 8300 1050
F 0 "J3" H 8350 1367 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 8350 1276 50  0000 C CNN
F 2 "" H 8300 1050 50  0001 C CNN
F 3 "~" H 8300 1050 50  0001 C CNN
	1    8300 1050
	1    0    0    -1  
$EndComp
Text GLabel 8000 950  0    50   UnSpc ~ 0
i2c_high
Wire Wire Line
	8000 950  8100 950 
Wire Wire Line
	8100 950  8100 1050
Connection ~ 8100 950 
Wire Wire Line
	8100 1150 8100 1050
Connection ~ 8100 1050
Text GLabel 8700 950  2    50   UnSpc ~ 0
12V
Text GLabel 8700 1050 2    50   UnSpc ~ 0
5V
Wire Wire Line
	6450 2900 6250 2900
Wire Wire Line
	6250 2900 6250 3700
Wire Wire Line
	6250 3700 6450 3700
Connection ~ 6250 2900
Wire Wire Line
	6250 2900 6150 2900
Text GLabel 6150 2900 0    50   UnSpc ~ 0
3_3V
Text GLabel 8700 1150 2    50   UnSpc ~ 0
3_3V
Wire Wire Line
	8700 1150 8600 1150
Wire Wire Line
	8700 1050 8600 1050
Wire Wire Line
	8600 950  8700 950 
Text Notes 7600 600  0    50   ~ 0
I2C wire level selection jumper
Wire Notes Line
	9150 2300 9150 500 
Text GLabel 8050 1800 0    50   UnSpc ~ 0
V_node
Wire Wire Line
	8150 1800 8050 1800
Text GLabel 8050 1700 0    50   UnSpc ~ 0
5V
$Comp
L Connector_Generic:Conn_01x03 J4
U 1 1 5CED50B0
P 8350 1800
F 0 "J4" H 8430 1842 50  0000 L CNN
F 1 "Conn_01x03" H 8430 1751 50  0000 L CNN
F 2 "" H 8350 1800 50  0001 C CNN
F 3 "~" H 8350 1800 50  0001 C CNN
	1    8350 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 1700 8150 1700
Wire Wire Line
	8050 1900 8150 1900
Text GLabel 8050 1900 0    50   UnSpc ~ 0
3_3V
Text Notes 7600 1450 0    50   ~ 0
Voltage selector for nodes
Wire Notes Line
	9150 1350 7550 1350
Text GLabel 1250 3100 0    50   UnSpc ~ 0
3_3V
Wire Wire Line
	9900 1250 10000 1250
Wire Wire Line
	10000 1350 9900 1350
Wire Wire Line
	9900 1650 9900 1550
Wire Wire Line
	9900 1550 10000 1550
Wire Wire Line
	10000 1450 9900 1450
Wire Wire Line
	9900 1450 9900 1550
Connection ~ 9900 1550
Wire Wire Line
	9900 1050 10000 1050
Wire Wire Line
	9900 1150 10000 1150
Wire Notes Line
	11200 500  11200 2300
Wire Notes Line
	500  500  11200 500 
Wire Notes Line
	500  2300 11200 2300
Text Notes 9200 700  0    50   ~ 0
Connector to first node\nin daisy chain
Wire Notes Line
	5400 5200 5400 2300
Wire Notes Line
	500  500  500  5200
Wire Notes Line
	7550 500  7550 5200
Wire Notes Line
	500  5200 7550 5200
Text Notes 5450 2500 0    50   ~ 0
Stacking pinheader for future extension.\nPower and I2C pins are connected, rest NC.
Wire Wire Line
	6150 3000 6450 3000
Wire Wire Line
	6150 3100 6450 3100
Text GLabel 6150 3000 0    50   BiDi ~ 0
i2c_sda_in
Text GLabel 6150 3100 0    50   BiDi ~ 0
i2c_scl_in
NoConn ~ 6450 3200
NoConn ~ 6450 3400
NoConn ~ 6450 3500
NoConn ~ 6450 3600
NoConn ~ 6450 3800
NoConn ~ 6450 3900
NoConn ~ 6450 4000
NoConn ~ 6450 4200
NoConn ~ 6450 4300
NoConn ~ 6450 4400
NoConn ~ 6450 4500
NoConn ~ 6450 4600
NoConn ~ 6450 4700
NoConn ~ 6950 4800
NoConn ~ 6950 4700
NoConn ~ 6950 4600
NoConn ~ 6950 4400
NoConn ~ 6950 4200
NoConn ~ 6950 4100
NoConn ~ 6950 4000
NoConn ~ 6950 3900
NoConn ~ 6950 3700
NoConn ~ 6950 3600
NoConn ~ 6950 3400
NoConn ~ 6950 3300
NoConn ~ 6950 3200
Text Notes 550  2600 0    50   ~ 0
I2C buffer/level shifter to drive the long wires. We could use two MOSFETs to level shift but that doesn't improve driving \nSelectable wire level, 5V should be enough for our purposes. \nSee fig. 14 in https://www.nxp.com/docs/en/data-sheet/P82B96.pdf
$Comp
L Device:CP C5
U 1 1 5D0087CF
P 7000 1650
F 0 "C5" V 7050 1500 50  0000 L CNN
F 1 "100uF" V 7150 1500 50  0000 L CNN
F 2 "" H 7038 1500 50  0001 C CNN
F 3 "~" H 7000 1650 50  0001 C CNN
	1    7000 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1800 7000 1900
$Comp
L Device:D_Zener_Small D4
U 1 1 5D0131F7
P 7250 1650
F 0 "D4" H 7300 1700 50  0000 L CNN
F 1 "Vz=5.6V" H 7100 1800 50  0000 L CNN
F 2 "" V 7250 1650 50  0001 C CNN
F 3 "~" V 7250 1650 50  0001 C CNN
	1    7250 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	7250 1750 7250 1900
Wire Wire Line
	7250 1900 7000 1900
Connection ~ 7000 1900
Wire Wire Line
	7250 1550 7250 1400
Connection ~ 7250 1400
Wire Wire Line
	7250 1400 7400 1400
Text Notes 5500 800  0    39   ~ 0
If 12V shorts to 5V the zener will conduct and the PTC will trip.\nIf 12V shorts to the i2c wires that's fine as the buffers are \ntolerant to 12V and the pull down will not succeed and eventually\nheartbeat will fail and user will be alerted.
Text Notes 1600 5400 0    50   ~ 0
TODO: Size i2c resistors and consider BCM2835 internal pull-ups
Text Notes 2150 5100 0    39   ~ 0
Max dynamic sink current: 100 mA \nMax static sink current: 30 mA\nAssuming 12 V:\n100 mA means minimum 120R to limit discharge current\n30 mA means minimum 400R to limit static current\n\nWire capacitance assumed  < 10 pF/m, P82B96 has 7 pF input cap, \nassume 10 devices and 10 meters BAT54 roughly 10pF per electrode. \nNode capacitance should easily be below 500 pF.\n\nAiming at 100 KHz or 10 us period, 5 us low/high time, 10% rise time \ngives 500 ns. 1*RC is enough to get the input to switch from low to high, \nmeaning that the largest pull up we can use is 1K ohm.
$Comp
L Device:R R?
U 1 1 5CD6E4F5
P 4400 3650
F 0 "R?" V 4500 3600 50  0000 L CNN
F 1 "330R" V 4400 3550 50  0000 L CNN
F 2 "" V 4330 3650 50  0001 C CNN
F 3 "~" H 4400 3650 50  0001 C CNN
	1    4400 3650
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5CD6E5AA
P 4400 4050
F 0 "R?" V 4500 4000 50  0000 L CNN
F 1 "330R" V 4400 3950 50  0000 L CNN
F 2 "" V 4330 4050 50  0001 C CNN
F 3 "~" H 4400 4050 50  0001 C CNN
	1    4400 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	4250 4050 4200 4050
Connection ~ 4200 4050
Wire Wire Line
	4250 3650 4200 3650
Connection ~ 4200 3650
Wire Wire Line
	4550 3650 4700 3650
Wire Wire Line
	4700 4050 4550 4050
$Comp
L Device:CP C?
U 1 1 5CD95773
P 6500 1650
F 0 "C?" V 6550 1500 50  0000 L CNN
F 1 "1 mF/16V" V 6650 1500 50  0000 L CNN
F 2 "" H 6538 1500 50  0001 C CNN
F 3 "~" H 6500 1650 50  0001 C CNN
	1    6500 1650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
