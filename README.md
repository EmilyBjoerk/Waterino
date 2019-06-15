<img alt="Waterino Logo" src="https://github.com/EmilyBjoerk/Waterino/blob/master/doc/art/large.png?raw=true" align="left"/>

# Waterino

Waterino is a DIY multi-pot home watering system. Multiple pots are connected together by daisy chaining "nodes" together with a "root" node providing power, monitoring and water. The daisy chaining means that the chain can be re-ordered when moving pots around and that there is a minimal amount of wire-mess as opposed to a star-network.

Each "node" consists of an integrated moisture/temperature sensor and control logic, a pump/valve and an optional overflow sensor to safe guard from causing damage to the surrounding by watering too much.

The "root" node consists of a water reservoir, a Raspberry Pi and power delivery. The RPi monitors the nodes with heart-beat and listens for error reports over I2C, provides a web server with logging and monitoring and can be setup to send email alerts if an error is detected or if the water level in the reservoir is low.

# System Diagram
<img alt="Waterino Logo" src="https://github.com/EmilyBjoerk/Waterino/blob/master/doc/art/Waterino System Design.png?raw=true"/>

# Building on Debian
You'll need the following:

```sudo apt install build-essential git cmake clang clang-tools gcc-avr avr-libc libgmock-dev avrdude```

Building and running unit-tests:

```
cd firmware/test
mkdir build
cd build
cmake ..
make test
```

or ``` make && ./unit-tests ``` for a more detailed output.

Viewing code coverage of unit tests (first build as above):

```
cd firmware/test/build
../../codecov.sh [path_to_file.cpp]
```

Building binary:

```
cd firmware/src
mkdir build
cd build
cmake ..
make
```

Viewing binary stats (after building as above):

```
cd firmware/src/build
make size
make sizes
make disassemble && cat probe.lst
```


# Design
## Measurement
The Waterino uses capacitive soil moisture and temperature sensor integrated in the node PCB.

The PCB has a coplanar capacitor pattern where the soil is the dielectric. The capacitance of the coplanar capacitance depends on how much water is in the soil as the dielectric constant of water dominates that of other material in the soil. We measure the capacitance by charging it through a known resistance and measuring the time it takes to charge to a known value which gives the capacitance.

There is also a NTC thermistor inside the soil that we use to measure the soil temperature. The temperature is used for correcting the slight temperature dependency of the moisture-capacitance relation.

## Control
The user specifies the desired watering period in hours, the maximum time the pump may be active and the threshold moisture level when the pump will activate.
Each time the measured moisture drops below the threshold the pump activates. When the pump activates the onboard PID will measure the time from the last pump activation and use that in relation to the desired watering period to compute if it should give more or less water than it did last time.
Note that if a too long period is specified in relation to the water retaining capacity of the soil. It may be impossible to achieve the desired period. This would cause the PID give more and more water, causing the pot to eventually overflow. The maximum pump activation time is aimed at preventing this failure mode. 

## Logging
The node keeps a small in memory log of the last few measurements and other important information. The root will poll the nodes for their respective logs and keep a longer term history slice the data and serve it over HTTP.

## Communication
The node will print debug information over 5V UART at 38400 baud, 8 bits data, 0 parity, 1 stop bit.

The node is a i2c master and slave device. It can be addressed to read the log, set parameters and control the node in other ways. It can also send to the general call address and write a special magic sequence followed by it's own unique slave address, this acts as a mutex device for activating a pump so that only one pump is active at a time, thanks to the i2c bus arbitration and unique slave addresses. This is makes sure that the water preasure available is always the same for the pumps, one can imagine if all pumps were to activate at once, the feed line from the reservoir would probably not have enough flow rate and the later pumps in the daisy chain wouldn't get any water.

## Safety
There are a few things that can go wrong... First, it's an electronic device near water that can possibly output 12V@5A 60W of power. A number of safety measures are implemented to hopefully prevent the device from harming itself, you or the plants.
In no particular order:

* Nodes will detect if too much water was given to the plant by two electrodes which you put in the saucer below your plant. If these electrodes conduct electricity the pump is automatically killed and the node will limit the next pump activation to the time it took for it to overflow this time but make it 5% shorter. To prevent a fluke from limiting the pump activation to way too short times, it will carefully try to recover the maximum pump duration to the user set duration over time, backing off if it detects overflow again.
* It will detect if the water level in the reservoir is low and email you.
* It will prevent the time the pump is active from going below a minimum time.
* A PTC fuse on each node will trip if the power on that node shorts out, and a PTC fuse on the root will like wise protect the system.
* Nodes will detect upon restart if it was killed by the fuse tripping and emit a visual alert and push an error to the root. The node will resume normal operation after being power cycled once, allowing a human to inspect what went wrong before trying again.
