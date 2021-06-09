verilator: toplevel_sim.v required_modules.txt toplevel_sim.cpp
	verilator -Wno-fatal --cc toplevel_sim.v -f required_modules.txt --exe toplevel_sim.cpp
	cp obj_dir/* .
	make -f Vtoplevel_sim.mk
	rm Vtoplevel_sim_* Vtoplevel_sim.* verilated.* toplevel_sim.d toplevel_sim.o
	rm -r obj_dir
	#
	# To run the verilated simulation, type ./Vtoplevel_sim
	#

iverilog: toplevel_sim.v required_modules.txt verilog/
	iverilog toplevel_sim.v -f required_modules.txt -o toplevel_sim
	#
	# To run the simulation using vvp, type ./toplevel_sim
	#

yosys: verilog/ toplevel_sim.v
	# Synthesise
	yosys -p 'read_verilog verilog/*.v toplevel_sim.v; synth_ice40 -top top -blif toplevel_sim.blif'
	# Convert to verilog
	yosys toplevel_sim.blif -o toplevel_sim_synth.v
	# Simulate
	iverilog toplevel_sim_synth.v -o toplevel_sim_synth
	# Tidy up
	rm *.blif toplevel_sim_synth.v
	#
	# To run the synthesized simulation using vvp, type ./toplevel_sim_synth
	#

clean:
	rm -f toplevel_sim
	rm -f Vtoplevel_sim
	rm -f *.blif toplevel_sim_synth.v toplevel_sim_synth
	rm -f *.vcd
