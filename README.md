# Waterino
Arduino project for controlled watering

# Soil measurement info
Waterino is using a resistive probe into the soil with a voltage divider where the top is a fixed 10K resistor and the bottom is the soil. The top and bottom of the divider are connected to GPIO pins on the arduino. The pins are driven high (5V) and low (0V) respectively to cause current in the forward direction, then a short wait for capacitive effects to settle in the pot, then read the middle of the divider with an ADC pin. This gives a "forward read" the polarity of the GPIO pins is then reversed, the pot given time to settle and the ADC read again, this produces a "reverse read". This alternating of the polarity counteracts electron migration on the probes. Driving the probe from the GPIO pins also allows us to power down the probe when not used, this prevents electrolysis on the electrodes. 

I set the probe into the pot of my lemon tree (it's a large ish pot, around 8L volume) and only water when the soil feels dry to my finger.

Here are the results after about 50 days of data logging:
![soil moisture data](https://i.imgur.com/b55JZJn.png)

We see from the data that there is a periodic component to the signal with the period of exactly one day. I assume this is the temprature dependence of the soil's resistance showing. Which is why I opted to add a temperature sensor to the soil in the design. I will do more measurements when I have the temperature sensor and see if I can find a way to correct for the temperature change. 

Further from the graph we can see that around 230 (or 230/1024*5 = 1.12V or 22.5% of Vcc) is a good value to water for a 10K divider and this pot. It might also be sensible to wait until dy/dx < 0 after the threshold has been crossed to water (i.e. in the evening or night) to avoid excessive evaporation. The dy/dx of course has to be measured on the uncompensated signal.

We also see that for the most part that the reverse read is only a scale value on the forward read as expected when we drive the divider in reverse. Apart from a few situations where they disagree and read very differently (mostly directly after watering) and some times the scale factor is also inconsistent. Maybe this compensating for temperature will affect this in some way. 


