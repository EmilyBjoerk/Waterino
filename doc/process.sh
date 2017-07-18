#!/bin/sh
cat experiment_data.txt | sed -E 's/Probe value: ([0-9]+) \(([0-9]+), ([0-9]+)\)/\1\t\2\t\3/g'
