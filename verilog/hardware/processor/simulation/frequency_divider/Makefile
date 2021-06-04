verilator: ../../verilog/frequency_divider.v sim.cpp
	verilator -Wno-fatal --cc ../../verilog/frequency_divider.v --exe sim.cpp
	cp obj_dir/* .
	make -f Vfrequency_divider.mk
	rm Vfrequency_divider_* Vfrequency_divider.* verilated.* sim.d sim.o
	rm -r obj_dir
	#
	# To run the verilated simulation, type ./Vfrequency_divider
	#

clean:
	rm -f Vfrequency_divider
