EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
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
LIBS:maxim
LIBS:el_maxim
LIBS:probe-cache
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
L Ferrite_Bead L1
U 1 1 5B034A43
P 9000 5100
F 0 "L1" V 8950 5000 50  0000 C CNN
F 1 "Ferrite_Bead" V 8850 5050 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 8930 5100 50  0001 C CNN
F 3 "http://www.bourns.com/docs/Product-Datasheets/mgmumz.pdf" H 9000 5100 50  0001 C CNN
	1    9000 5100
	0    -1   -1   0   
$EndComp
$Comp
L C C3
U 1 1 5B034EC8
P 9250 5350
F 0 "C3" H 9275 5450 50  0000 L CNN
F 1 "10µF" H 9000 5450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9288 5200 50  0001 C CNN
F 3 "" H 9250 5350 50  0001 C CNN
	1    9250 5350
	-1   0    0    1   
$EndComp
$Comp
L R R7
U 1 1 5B035B97
P 5750 2450
F 0 "R7" V 5830 2450 50  0000 C CNN
F 1 "10K" V 5750 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5680 2450 50  0001 C CNN
F 3 "" H 5750 2450 50  0001 C CNN
	1    5750 2450
	1    0    0    -1  
$EndComp
Text GLabel 3950 5100 0    39   Input ~ 0
MOIST_+
$Comp
L C C1
U 1 1 5B03EFBE
P 8750 5350
F 0 "C1" H 8775 5450 50  0000 L CNN
F 1 "100nF" H 8750 5550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8788 5200 50  0001 C CNN
F 3 "" H 8750 5350 50  0001 C CNN
	1    8750 5350
	-1   0    0    1   
$EndComp
$Comp
L MCP3423 U1
U 1 1 5B05050D
P 4700 4700
F 0 "U1" H 4600 5150 50  0000 R CNN
F 1 "MCP3423" H 4600 5050 50  0000 R CNN
F 2 "Housings_SSOP:MSOP-10_3x3mm_Pitch0.5mm" H 4750 4250 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/22088c.pdf" H 5600 4400 50  0001 C CNN
	1    4700 4700
	1    0    0    -1  
$EndComp
Text GLabel 5750 2300 0    39   Input ~ 0
AVcc
$Comp
L R R3
U 1 1 5B0365CF
P 3600 3200
F 0 "R3" V 3680 3200 50  0000 C CNN
F 1 "100K" V 3600 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3530 3200 50  0001 C CNN
F 3 "" H 3600 3200 50  0001 C CNN
	1    3600 3200
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 5B0364CB
P 3900 2400
F 0 "R4" V 3850 2250 50  0000 C CNN
F 1 "100K" V 3900 2400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3830 2400 50  0001 C CNN
F 3 "" H 3900 2400 50  0001 C CNN
	1    3900 2400
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 5B03653F
P 6100 2900
F 0 "R2" V 6180 2900 50  0000 C CNN
F 1 "100K" V 6100 2900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6030 2900 50  0001 C CNN
F 3 "" H 6100 2900 50  0001 C CNN
	1    6100 2900
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 5B036426
P 6100 2700
F 0 "R1" V 6180 2700 50  0000 C CNN
F 1 "100K" V 6100 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6030 2700 50  0001 C CNN
F 3 "" H 6100 2700 50  0001 C CNN
	1    6100 2700
	0    1    1    0   
$EndComp
Text GLabel 3850 3200 3    39   Input ~ 0
AVcc
$Comp
L GNDA #PWR01
U 1 1 5B037700
P 3900 2550
F 0 "#PWR01" H 3900 2300 50  0001 C CNN
F 1 "GNDA" H 3900 2400 50  0000 C CNN
F 2 "" H 3900 2550 50  0001 C CNN
F 3 "" H 3900 2550 50  0001 C CNN
	1    3900 2550
	0    -1   -1   0   
$EndComp
$Comp
L GNDA #PWR02
U 1 1 5B057D3A
P 9250 5600
F 0 "#PWR02" H 9250 5350 50  0001 C CNN
F 1 "GNDA" H 9250 5450 50  0000 C CNN
F 2 "" H 9250 5600 50  0001 C CNN
F 3 "" H 9250 5600 50  0001 C CNN
	1    9250 5600
	1    0    0    -1  
$EndComp
Text GLabel 7900 5100 0    39   Input ~ 0
AVcc
$Comp
L GNDA #PWR03
U 1 1 5B058960
P 6450 5200
F 0 "#PWR03" H 6450 4950 50  0001 C CNN
F 1 "GNDA" H 6450 5050 50  0000 C CNN
F 2 "" H 6450 5200 50  0001 C CNN
F 3 "" H 6450 5200 50  0001 C CNN
	1    6450 5200
	1    0    0    -1  
$EndComp
$Comp
L GNDA #PWR04
U 1 1 5B05899F
P 4700 5200
F 0 "#PWR04" H 4700 4950 50  0001 C CNN
F 1 "GNDA" H 4700 5050 50  0000 C CNN
F 2 "" H 4700 5200 50  0001 C CNN
F 3 "" H 4700 5200 50  0001 C CNN
	1    4700 5200
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 5B060EB8
P 3950 4950
F 0 "R5" V 4030 4950 50  0000 C CNN
F 1 "10K" V 3950 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3880 4950 50  0001 C CNN
F 3 "" H 3950 4950 50  0001 C CNN
	1    3950 4950
	-1   0    0    1   
$EndComp
Text GLabel 9400 2750 0    39   Input ~ 0
MOIST_+
Text GLabel 9400 2550 0    39   Input ~ 0
MOIST_-
Text Notes 2650 1900 0    39   ~ 0
Rev1A
Text Notes 2650 3800 0    39   ~ 0
Rev1B
Text Notes 3200 1750 0    39   ~ 0
The PCB will have footprints for both Rev 1A and Rev 1B.\nHowever, the population of the footprints is mutually \nexclusive between A and B variants. \nThis is done to facilitate planned upgrades to the main\nunit to handle multiple probes without having to fab \nanother PCB.\n\nAdded benefit of avoiding to send analog signals \nover possibly long wire.
Wire Wire Line
	5750 2600 5750 2800
Connection ~ 5750 2700
Wire Wire Line
	5750 3200 5900 3200
Wire Wire Line
	5750 2700 5950 2700
Wire Wire Line
	5900 3200 5900 2900
Wire Wire Line
	5900 2900 5950 2900
Wire Wire Line
	6250 2700 6700 2700
Wire Wire Line
	6250 2900 6300 2900
Wire Wire Line
	3600 2400 3750 2400
Wire Wire Line
	4350 2400 4350 2900
Wire Wire Line
	4250 2900 4450 2900
Wire Wire Line
	9250 5100 9250 5200
Wire Wire Line
	9250 5600 9250 5500
Connection ~ 9250 5100
Wire Wire Line
	3850 2600 3850 2550
Wire Wire Line
	6300 3400 6700 3400
Wire Wire Line
	4100 4900 4100 5200
Wire Wire Line
	4100 5200 4700 5200
Wire Wire Line
	6450 5100 6450 5200
Wire Wire Line
	5650 5100 6450 5100
Wire Wire Line
	5650 5100 5650 5200
Wire Wire Line
	5450 5200 5450 5000
Wire Wire Line
	5300 5000 6450 5000
Text Notes 5400 5550 0    39   ~ 0
ADDR_SEL0
Text Notes 5950 5550 0    39   ~ 0
ADDR_SEL1
Wire Wire Line
	3950 4800 4100 4800
Text Notes 5450 1900 0    39   ~ 0
NTC Temp Sensor
$Comp
L C C7
U 1 1 5B075D1A
P 6300 3100
F 0 "C7" H 6325 3200 50  0000 L CNN
F 1 "100nF" H 6350 3300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6338 2950 50  0001 C CNN
F 3 "" H 6300 3100 50  0001 C CNN
	1    6300 3100
	-1   0    0    1   
$EndComp
$Comp
L C C6
U 1 1 5B075DA4
P 6700 3100
F 0 "C6" H 6725 3200 50  0000 L CNN
F 1 "100nF" V 6550 3000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6738 2950 50  0001 C CNN
F 3 "" H 6700 3100 50  0001 C CNN
	1    6700 3100
	-1   0    0    1   
$EndComp
Text GLabel 4700 4300 1    39   Input ~ 0
AVcc
$Comp
L PWR_FLAG #FLG05
U 1 1 5B07D45F
P 9250 6400
F 0 "#FLG05" H 9250 6475 50  0001 C CNN
F 1 "PWR_FLAG" H 9250 6550 50  0000 C CNN
F 2 "" H 9250 6400 50  0001 C CNN
F 3 "" H 9250 6400 50  0001 C CNN
	1    9250 6400
	1    0    0    -1  
$EndComp
Text GLabel 9250 6400 0    39   Input ~ 0
MOIST_-
$Comp
L PWR_FLAG #FLG06
U 1 1 5B07DFF5
P 9650 5600
F 0 "#FLG06" H 9650 5675 50  0001 C CNN
F 1 "PWR_FLAG" H 9650 5750 50  0000 C CNN
F 2 "" H 9650 5600 50  0001 C CNN
F 3 "" H 9650 5600 50  0001 C CNN
	1    9650 5600
	-1   0    0    1   
$EndComp
$Comp
L R ICL1
U 1 1 5B0490E4
P 10000 5100
F 0 "ICL1" V 9850 5250 50  0000 C CNN
F 1 "100K" V 10000 5100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 9930 5100 50  0001 C CNN
F 3 "" H 10000 5100 50  0001 C CNN
	1    10000 5100
	0    1    1    0   
$EndComp
Wire Wire Line
	10150 5100 10350 5100
$Comp
L R ICL2
U 1 1 5B049C12
P 10000 5250
F 0 "ICL2" V 10100 5250 50  0000 C CNN
F 1 "100K" V 10000 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 9930 5250 50  0001 C CNN
F 3 "" H 10000 5250 50  0001 C CNN
	1    10000 5250
	0    1    1    0   
$EndComp
Wire Wire Line
	6300 2900 6300 2950
Wire Wire Line
	6700 2700 6700 2950
Wire Wire Line
	3600 3000 3600 3050
Wire Wire Line
	3600 3400 3600 3350
Wire Wire Line
	6700 3400 6700 3250
Wire Wire Line
	6300 3400 6300 3250
Wire Wire Line
	4050 2400 4350 2400
Text GLabel 9400 2350 0    39   Input ~ 0
SHLD
Text GLabel 9400 2450 0    39   Input ~ 0
GND
Text GLabel 9400 2250 0    39   Input ~ 0
VCC
Text GLabel 9400 2850 0    39   Input ~ 0
SDA/TEMP_AO
Text GLabel 9400 2650 0    39   Input ~ 0
SCL/MOIST_AO
Text Notes 8850 2050 0    39   ~ 0
The cable shield is connected to ground on the host.\nThe probe devices leave the shield as NC to prevent\nground loops from ocurring and coupling to the analog\nsignals. Until we move to I2C.
$Comp
L Ferrite_Bead L2
U 1 1 5B06BB99
P 9350 3450
F 0 "L2" V 9300 3350 50  0000 C CNN
F 1 "Ferrite_Bead" V 9200 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 9280 3450 50  0001 C CNN
F 3 "http://www.bourns.com/docs/Product-Datasheets/mgmumz.pdf" H 9350 3450 50  0001 C CNN
	1    9350 3450
	0    -1   -1   0   
$EndComp
Text GLabel 9200 3450 0    39   Input ~ 0
SHLD
Text GLabel 9500 3450 2    39   Input ~ 0
GND
Text Notes 8850 3300 0    39   ~ 0
Leave a footprint to allow experimentation with\npassives connecting shield ground to signal ground. \nAlthough we expect this to be unpopulated.
Wire Wire Line
	10150 5250 10250 5250
Wire Wire Line
	10250 5250 10250 5100
Connection ~ 10250 5100
Wire Wire Line
	9850 5250 9750 5250
Text Notes 8850 4800 0    39   ~ 0
Vcc should be quiet as it comes over a shielded cable\nfrom a linear regulator and the MCU will be sleeping \nduring the measurement. Never the less, we leave room \nfor adding a ferrite bead on the Vcc line. \n\nThe ICs and passives of the probe will be enclosed in some\nkind of protection against moisture and this will impact the\nability to dissipate heat. This must be accounted for.\n\nHost's regulator can supply 2.2 A peak and we expect \nat most 16 devices so we limit each one to 100 mA inrush\ncurrent using either resistors or NTC thermistors. Use \n0804 footprints to allow more choice of components w.r.t. \npower dissipation.
Text Notes 9650 5350 2    39   ~ 0
Bulk Cap
Text Notes 9950 5000 0    39   ~ 0
ICL
Text Notes 8750 5050 0    39   ~ 0
Opt. LP
Text GLabel 10350 5100 2    39   Input ~ 0
VCC
Wire Wire Line
	8000 5600 9650 5600
Text Notes 8850 6150 0    39   ~ 0
Shut up KiCad about unconnected net.
Text Notes 10000 5650 0    39   ~ 0
Peak max: 100mA\nLoad max: 10mA 
$Comp
L GNDA #PWR07
U 1 1 5B0781A8
P 6500 3450
F 0 "#PWR07" H 6500 3200 50  0001 C CNN
F 1 "GNDA" H 6500 3300 50  0000 C CNN
F 2 "" H 6500 3450 50  0001 C CNN
F 3 "" H 6500 3450 50  0001 C CNN
	1    6500 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3450 6500 3400
Connection ~ 6500 3400
Text GLabel 6300 2900 2    39   Input ~ 0
TEMP_A-
Text GLabel 6700 2700 2    39   Input ~ 0
TEMP_A+
Text Notes 3250 2250 0    39   ~ 0
Input bias current max -500 nA.\n5V /0.5µA = 10 M Ohm.\n\nFeedback resistance is at most 210K which is 50x lower than 10M\nwe should be fine for bias current.\n
Text GLabel 3000 3000 0    39   Input ~ 0
TEMP_A+
Text GLabel 3000 2800 0    39   Input ~ 0
TEMP_A-
Wire Wire Line
	3000 3000 3650 3000
Wire Wire Line
	3000 2800 3650 2800
Wire Wire Line
	3600 2800 3600 2400
$Comp
L C C8
U 1 1 5B07BB7A
P 8500 5350
F 0 "C8" H 8525 5450 50  0000 L CNN
F 1 "100nF" H 8500 5550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8538 5200 50  0001 C CNN
F 3 "" H 8500 5350 50  0001 C CNN
	1    8500 5350
	-1   0    0    1   
$EndComp
$Comp
L C C5
U 1 1 5B07BBE1
P 8250 5350
F 0 "C5" H 8275 5450 50  0000 L CNN
F 1 "10nF" H 8300 5550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8288 5200 50  0001 C CNN
F 3 "" H 8250 5350 50  0001 C CNN
	1    8250 5350
	-1   0    0    1   
$EndComp
$Comp
L C C4
U 1 1 5B07BC3F
P 8000 5350
F 0 "C4" H 8025 5450 50  0000 L CNN
F 1 "10nF" H 8050 5550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8038 5200 50  0001 C CNN
F 3 "" H 8000 5350 50  0001 C CNN
	1    8000 5350
	-1   0    0    1   
$EndComp
Wire Wire Line
	8000 5100 8000 5200
Wire Wire Line
	8250 5100 8250 5200
Connection ~ 8250 5100
Wire Wire Line
	8500 5100 8500 5200
Connection ~ 8500 5100
Wire Wire Line
	8750 5100 8750 5200
Connection ~ 8750 5100
Connection ~ 8000 5100
Wire Wire Line
	8000 5500 8000 5600
Connection ~ 9250 5600
Wire Wire Line
	8250 5500 8250 5600
Connection ~ 8250 5600
Wire Wire Line
	8500 5500 8500 5600
Connection ~ 8500 5600
Wire Wire Line
	8750 5500 8750 5600
Connection ~ 8750 5600
Text Notes 8550 5700 2    39   ~ 0
Decoupling Caps
$Comp
L MCP6001U U2
U 1 1 5B037004
P 3950 2900
F 0 "U2" H 3950 3100 50  0000 L CNN
F 1 "MCP6001U" H 3950 3350 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-5" H 3950 2900 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 3950 2900 50  0001 C CNN
	1    3950 2900
	1    0    0    1   
$EndComp
Wire Wire Line
	3850 2550 3900 2550
$Comp
L GNDA #PWR08
U 1 1 5B07C8EA
P 3600 3400
F 0 "#PWR08" H 3600 3150 50  0001 C CNN
F 1 "GNDA" H 3600 3250 50  0000 C CNN
F 2 "" H 3600 3400 50  0001 C CNN
F 3 "" H 3600 3400 50  0001 C CNN
	1    3600 3400
	1    0    0    -1  
$EndComp
Text GLabel 4900 2900 2    39   Input ~ 0
SDA/TEMP_AO
Text GLabel 5650 4700 2    39   Input ~ 0
SDA/TEMP_AO
Text GLabel 5650 4600 2    39   Input ~ 0
SCL/MOIST_AO
Text GLabel 6450 5000 2    39   Input ~ 0
AVcc
Text GLabel 4100 4600 0    39   Input ~ 0
TEMP_A-
Text GLabel 4100 4500 0    39   Input ~ 0
TEMP_A+
$Comp
L R R8
U 1 1 5B08187D
P 5350 4400
F 0 "R8" V 5430 4400 50  0000 C CNN
F 1 "4K7" V 5350 4400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5280 4400 50  0001 C CNN
F 3 "" H 5350 4400 50  0001 C CNN
	1    5350 4400
	-1   0    0    1   
$EndComp
$Comp
L R R9
U 1 1 5B081973
P 5550 4400
F 0 "R9" V 5630 4400 50  0000 C CNN
F 1 "4K7" V 5550 4400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5480 4400 50  0001 C CNN
F 3 "" H 5550 4400 50  0001 C CNN
	1    5550 4400
	-1   0    0    1   
$EndComp
Wire Wire Line
	5350 4550 5350 4600
Wire Wire Line
	5300 4600 5650 4600
Wire Wire Line
	5300 4700 5650 4700
Wire Wire Line
	5550 4700 5550 4550
Connection ~ 5550 4700
Connection ~ 5350 4600
Wire Wire Line
	5350 4250 5350 4150
Wire Wire Line
	5350 4150 5550 4150
Wire Wire Line
	5550 4150 5550 4250
Wire Wire Line
	7900 5100 8850 5100
Wire Wire Line
	9150 5100 9850 5100
Wire Wire Line
	9750 5250 9750 5100
Connection ~ 9750 5100
Text GLabel 9750 5100 1    39   Input ~ 0
DVcc
Text GLabel 5550 4150 1    39   Input ~ 0
DVcc
Text Notes 5700 4450 0    39   ~ 0
The host should have the pull-ups on SCL/SDA but\nwe leave footprints on the device side as well just \nin case we want to add them here anyway.
Wire Notes Line
	2600 1800 2600 5950
Wire Notes Line
	2600 5950 7400 5950
Wire Notes Line
	7400 5950 7400 1800
Wire Notes Line
	7400 1800 2600 1800
Wire Notes Line
	2600 3700 7400 3700
Text Notes 5700 2200 0    39   ~ 0
100K Ohm and 100nF forms first order LP filter with \ncut off frequency 16 Hz. Should be good enough for\nthis application. The 100K Ohm resistors also double \nas the biasing resistors for the Op Amp in Version A.
Wire Notes Line
	5400 1800 5400 3700
$Comp
L C C2
U 1 1 5B08FB8D
P 4850 3150
F 0 "C2" H 4875 3250 50  0000 L CNN
F 1 "10µF" H 4950 3350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4888 3000 50  0001 C CNN
F 3 "" H 4850 3150 50  0001 C CNN
	1    4850 3150
	-1   0    0    1   
$EndComp
$Comp
L R R6
U 1 1 5B08FD1D
P 4600 2900
F 0 "R6" V 4550 2750 50  0000 C CNN
F 1 "500R" V 4600 2900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4530 2900 50  0001 C CNN
F 3 "" H 4600 2900 50  0001 C CNN
	1    4600 2900
	0    1    1    0   
$EndComp
Connection ~ 4350 2900
Wire Wire Line
	4750 2900 4900 2900
Wire Wire Line
	4850 3000 4850 2900
Connection ~ 4850 2900
$Comp
L GNDA #PWR09
U 1 1 5B0900DD
P 4850 3400
F 0 "#PWR09" H 4850 3150 50  0001 C CNN
F 1 "GNDA" H 4850 3250 50  0000 C CNN
F 2 "" H 4850 3400 50  0001 C CNN
F 3 "" H 4850 3400 50  0001 C CNN
	1    4850 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3400 4850 3300
Text Notes 4400 2700 0    39   ~ 0
Limit output to 10mA (Isc =23) \nand filter (32 Hz 3 dB cut-off)
Connection ~ 3600 3000
Connection ~ 3600 2800
$Comp
L D D2
U 1 1 5B05D5E2
P 3400 2600
F 0 "D2" H 3400 2700 50  0000 C CNN
F 1 "D" H 3400 2500 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 3400 2600 50  0001 C CNN
F 3 "" H 3400 2600 50  0001 C CNN
	1    3400 2600
	0    1    1    0   
$EndComp
$Comp
L D D1
U 1 1 5B05D677
P 3100 2600
F 0 "D1" H 3100 2700 50  0000 C CNN
F 1 "D" H 3100 2500 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123" H 3100 2600 50  0001 C CNN
F 3 "" H 3100 2600 50  0001 C CNN
	1    3100 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	3400 2450 3400 2350
Wire Wire Line
	3400 2350 3100 2350
Wire Wire Line
	3100 2350 3100 2450
Wire Wire Line
	3100 2750 3100 2800
Connection ~ 3100 2800
Wire Wire Line
	3400 2750 3400 3000
Connection ~ 3400 3000
Text GLabel 3100 2350 0    39   Input ~ 0
AVcc
$Comp
L Conn_01x08 J3
U 1 1 5B05D542
P 9600 2550
F 0 "J3" H 9600 2950 50  0000 C CNN
F 1 "Conn_01x08" H 9600 2050 50  0000 C CNN
F 2 "Connectors_JST:JST_PUD_S08B-PUDSS-1_2x04x2.00mm_Angled" H 9600 2550 50  0001 C CNN
F 3 "http://www.jst-mfg.com/product/pdf/eng/ePUD.pdf" H 9600 2550 50  0001 C CNN
	1    9600 2550
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 5B05E369
P 8250 5100
F 0 "#FLG010" H 8250 5175 50  0001 C CNN
F 1 "PWR_FLAG" H 8250 5250 50  0000 C CNN
F 2 "" H 8250 5100 50  0001 C CNN
F 3 "" H 8250 5100 50  0001 C CNN
	1    8250 5100
	1    0    0    -1  
$EndComp
$Comp
L R NTC1
U 1 1 5B05E5F0
P 5750 2950
F 0 "NTC1" V 5830 2950 50  0000 C CNN
F 1 "10k25c" V 5650 2950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5680 2950 50  0001 C CNN
F 3 "" H 5750 2950 50  0001 C CNN
	1    5750 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 3200 5750 3100
$Comp
L GNDA #PWR011
U 1 1 5B05E791
P 5750 3500
F 0 "#PWR011" H 5750 3250 50  0001 C CNN
F 1 "GNDA" H 5750 3350 50  0000 C CNN
F 2 "" H 5750 3500 50  0001 C CNN
F 3 "" H 5750 3500 50  0001 C CNN
	1    5750 3500
	1    0    0    -1  
$EndComp
Text GLabel 9650 5600 2    39   Input ~ 0
GND
$Comp
L Conn_02x03_Odd_Even J1
U 1 1 5B067616
P 5550 5400
F 0 "J1" H 5600 5600 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 5600 5200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_2x03_Pitch2.54mm" H 5550 5400 50  0001 C CNN
F 3 "" H 5550 5400 50  0001 C CNN
	1    5550 5400
	0    1    1    0   
$EndComp
Wire Wire Line
	5650 5700 5850 5700
Wire Wire Line
	5850 5700 5850 5100
Connection ~ 5850 5100
Wire Wire Line
	5450 5700 5300 5700
Wire Wire Line
	5300 5700 5300 5000
Connection ~ 5450 5000
Wire Wire Line
	6100 4800 6100 5800
Wire Wire Line
	6100 5800 5550 5800
Wire Wire Line
	5550 5800 5550 5700
Text GLabel 9400 2950 0    39   Input ~ 0
SHLD
Wire Wire Line
	5300 4800 6100 4800
Wire Wire Line
	5550 5200 5550 4900
Wire Wire Line
	5550 4900 5300 4900
$Comp
L R R10
U 1 1 5B08253A
P 5750 3350
F 0 "R10" V 5830 3350 50  0000 C CNN
F 1 "0" V 5750 3350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5680 3350 50  0001 C CNN
F 3 "" H 5750 3350 50  0001 C CNN
	1    5750 3350
	-1   0    0    1   
$EndComp
Text Label 5750 2700 0    60   ~ 0
NTC+
Text Label 5900 3200 0    60   ~ 0
NTC-
$Comp
L TEST TP4
U 1 1 5B085E75
P 6700 2700
F 0 "TP4" H 6700 3000 50  0000 C BNN
F 1 "TEST" H 6700 2950 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 6700 2700 50  0001 C CNN
F 3 "" H 6700 2700 50  0001 C CNN
	1    6700 2700
	1    0    0    -1  
$EndComp
$Comp
L TEST TP3
U 1 1 5B08801C
P 6300 2900
F 0 "TP3" H 6300 3200 50  0000 C BNN
F 1 "TEST" H 6300 3150 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 6300 2900 50  0001 C CNN
F 3 "" H 6300 2900 50  0001 C CNN
	1    6300 2900
	1    0    0    -1  
$EndComp
$Comp
L TEST TP2
U 1 1 5B08815C
P 4350 2900
F 0 "TP2" H 4350 3200 50  0000 C BNN
F 1 "TEST" H 4350 3150 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 4350 2900 50  0001 C CNN
F 3 "" H 4350 2900 50  0001 C CNN
	1    4350 2900
	-1   0    0    1   
$EndComp
$Comp
L TEST TP1
U 1 1 5B088A90
P 3950 4800
F 0 "TP1" H 3950 5100 50  0000 C BNN
F 1 "TEST" H 3950 5050 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 3950 4800 50  0001 C CNN
F 3 "" H 3950 4800 50  0001 C CNN
	1    3950 4800
	0    -1   -1   0   
$EndComp
$Comp
L TEST TP6
U 1 1 5B089970
P 9200 3450
F 0 "TP6" H 9200 3750 50  0000 C BNN
F 1 "TEST" H 9200 3700 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 9200 3450 50  0001 C CNN
F 3 "" H 9200 3450 50  0001 C CNN
	1    9200 3450
	-1   0    0    1   
$EndComp
$Comp
L TEST TP7
U 1 1 5B089CFA
P 9500 3450
F 0 "TP7" H 9500 3750 50  0000 C BNN
F 1 "TEST" H 9500 3700 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 9500 3450 50  0001 C CNN
F 3 "" H 9500 3450 50  0001 C CNN
	1    9500 3450
	-1   0    0    1   
$EndComp
$Comp
L TEST TP8
U 1 1 5B08A07D
P 9750 5250
F 0 "TP8" H 9750 5550 50  0000 C BNN
F 1 "TEST" H 9750 5500 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 9750 5250 50  0001 C CNN
F 3 "" H 9750 5250 50  0001 C CNN
	1    9750 5250
	-1   0    0    1   
$EndComp
$Comp
L TEST TP5
U 1 1 5B08A163
P 8750 5100
F 0 "TP5" H 8750 5400 50  0000 C BNN
F 1 "TEST" H 8750 5350 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-TH_Small" H 8750 5100 50  0001 C CNN
F 3 "" H 8750 5100 50  0001 C CNN
	1    8750 5100
	1    0    0    -1  
$EndComp
$EndSCHEMATC
