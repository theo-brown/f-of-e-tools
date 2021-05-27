#!/bin/bash

iverilog cache_sim.v cache.v -f required_modules.txt -o cache_sim
./cache_sim
