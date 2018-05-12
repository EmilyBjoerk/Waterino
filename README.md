# Waterino
Waterino is combined hardware and software project to achieve finely controlled irrigation of household plants. It differs from most other irrigation solutions in that it will automatically adjust the amount of water given in order to achieve a user specified watering cycle. 
# Design
## Measurement
The Waterino uses resistive soil moisture measurement through electrodes in the soil. The resistance of the soil is a function of the soil quality, moisture and temperature. We assume quality is somewhat constant; and also support a linear, analog temperature probe to correct for temperature variations. This should allow a fairly accurate measurement of the soil moisture content.
There are effects on the electrodes that affect the measurement. For example running a constant DC current through them would cause electrolysis of any moisture around the probes giving a false reading. It could also result in corrosion of the probes or electron migration, further causing drift to the measurements over time. To combat these effects we will use electrodes that are resistant to corrosion and we will do two short measurements with opposite polarity, essentially producing one period of AC current. This should reduce or eliminate electrolysis and electron migration problems. 
## Control
The user specifies the desired watering period in hours, the maximum time the pump may be active and the threshold moisture level when the pump will activate.
Each time the measured moisture drops below the threshold the pump activates. When the pump activates the onboard PID will measure the time from the last pump activation and use that in relation to the desired watering period to compute if it should give more or less water than it did last time.
Note that if a too long period is specified in relation to the water retaining capacity of the soil. It may be impossible to achieve the desired period. This would cause the PID give more and more water, causing the pot to eventually overflow. The maximum pump activation time is aimed at preventing this failure mode. 
## Logging
The device will keep a short form log of the'n' last measurements and pumping events in the onboard EEPROM (as a cyclic buffer). The EEPROM is 1 KiB and presume we would like to keep 32 days of log data which is logged every 4 hours, this means the average log entry must be no larger than 8 bytes.
This allows us to log:
* 2 bytes hours after startup (wrap around after 7.5 years uptime)
* 2 bytes corrected moisture level
* 2 bytes temprature
* 2 bytes reserved

OR
* 2 bytes hours after startup
* 2 bytes minutes since last pump activation (max 45 days)
* 2 bytes milli seconds of pump active (1h max)
* 1 bytes status bitmap (overflow, underflow, short circuit, first run)
* 1 bytes reserved

Write endurance of the EEPROM is of course a concern. The used MCU is rated for at least 100k write/erase cycles of the 1KiB EEPROM. If it per the above takes 32 days to fill the entire EEPROM once, it will take 32 * 100000 days = 8767 years before the we reach the minimum rated endurance. This is acceptable.
## Communication
The device will provide a minimal command interface over UART. The user may adjust the PID parameters, watering period and max pump time. They may also dump the EEPROM log contents, view current PID internal status variables for debugging and enter one of two calibration modes.
The first calibration mode allows the user to feed a square wave with a specific frequency on one of the Waterino's input pins. The waterino will then perform an automatic calibration of its internal RC oscillator and store the result in the EEPROM and use that value on future resets. 
The second calibration mode will print back the corrected soil measurement value, the temprature probe reading and the raw forward and backward polarity readings of the moisture electrodes. It will also record the minimum moisture value encountered and use this as the watering thredhold (storing it in EEPROM). Typically when first setting up the device the user sets in the electrodes in the soil and enters this calibration mode. They then manually water the plant when it is time and the waterino learns the watering threshold from this and writes it to the EEPROM. The user then after having watered at the right time a few times then simply resets the device.
## Safety
There are a few things that can go wrong... First, it's an electronic device near water that can possibly output 12V@5A 60W of power. A number of safety measures are implemented to hopefully prevent the device from harming itself, you or the plants.
In no particular order:
It will detect if too much water was given to the plant by two electrodes which you put in the plate below your plant. If these electrodes conduct electricity the pump is automatically killed and the Waterino will limit the next pump activation to the time it took for it to overflow this time but make it 5% shorter. To prevent a fluke from limiting the pump activation to way too short times, it will carefully try to recover the maximum pump duration to the user set duration over time, backing off if it detects overflow again.
A microswitch and floating device in the reservoir will trigger if the water level in the reservoir is too low. This will prevent the pump from activating and raise an audible and visible alarm. Reminding you to refill the reservoir.
A PTC resettable fuse in the PCB will trip if a short circuit ocurrs either with the pump or otherwise. The Waterino will detect upon restart if it was killed by the fuse tripping and amit an audio visual alert, prompting you to investigate the cause of the short. The Waterino will resume normal operation after it has been manually reset once more.
A software detecion of low-current shorts in the reservoir may also trip and kill the MCU in the same way as the furse tripping. 

# Soil measurement notes
Waterino is using a resistive probe into the soil with a voltage divider where the top is a fixed 10K resistor and the bottom is the soil. The top and bottom of the divider are connected to GPIO pins on the arduino. The pins are driven high (5V) and low (0V) respectively to cause current in the forward direction, then a short wait for capacitive effects to settle in the pot, then read the middle of the divider with an ADC pin. This gives a "forward read" the polarity of the GPIO pins is then reversed, the pot given time to settle and the ADC read again, this produces a "reverse read". This alternating of the polarity counteracts electron migration on the probes. Driving the probe from the GPIO pins also allows us to power down the probe when not used, this prevents electrolysis on the electrodes. 

I set the probe into the pot of my lemon tree (it's a large ish pot, around 8L volume) and only water when the soil feels dry to my finger.

Here are the results after about 50 days of data logging:
![soil moisture data](https://i.imgur.com/b55JZJn.png)

We see from the data that there is a periodic component to the signal with the period of exactly one day. I assume this is the temprature dependence of the soil's resistance showing. Which is why I opted to add a temperature sensor to the soil in the design. I will do more measurements when I have the temperature sensor and see if I can find a way to correct for the temperature change. 

Further from the graph we can see that around 230 (or 230/1024*5 = 1.12V or 22.5% of Vcc) is a good value to water for a 10K divider and this pot. It might also be sensible to wait until dy/dx < 0 after the threshold has been crossed to water (i.e. in the evening or night) to avoid excessive evaporation. The dy/dx of course has to be measured on the uncompensated signal.

We also see that for the most part that the reverse read is only a scale value on the forward read as expected when we drive the divider in reverse. Apart from a few situations where they disagree and read very differently (mostly directly after watering) and some times the scale factor is also inconsistent. Maybe this compensating for temperature will affect this in some way. 


