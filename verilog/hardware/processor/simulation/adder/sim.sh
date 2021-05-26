#!/bin/bash

iverilog adder_sim.v -f required_modules.txt -o adder_sim
./adder_sim
