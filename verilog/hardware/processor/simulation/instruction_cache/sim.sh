#!/bin/bash

iverilog instruction_cache_sim.v instruction_cache.v main_memory.v -f required_modules.txt -o instruction_cache_sim
./instruction_cache_sim
