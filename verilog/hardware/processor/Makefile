DESIGN	= sail_dsp

sail-nextpnr:
	cp programs/data.hex verilog/
	cp programs/program.hex verilog/
	yosys ../../../yscripts/$(DESIGN).ys -l $(DESIGN)_synth.txt
	nextpnr-ice40 --up5k --package uwg30 --json $(DESIGN).json --pcf pcf/$(DESIGN).pcf --asc $(DESIGN).asc -l $(DESIGN)_pnr.txt
	icetime -p pcf/$(DESIGN).pcf -P uwg30 -d up5k -t $(DESIGN).asc
	icepack $(DESIGN).asc $(DESIGN).bin
	#sudo iceprog -S $(DESIGN).bin

clean:
	rm -f *.json *.blif *.asc *.bin
