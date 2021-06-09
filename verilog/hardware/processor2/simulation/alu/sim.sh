#!/bin/bash

iverilog alu_sim.v -f required_modules.txt -o alu_sim
./alu_sim
