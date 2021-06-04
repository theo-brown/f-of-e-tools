MODIFIED_DESIGN=sail_modified
UNMODIFIED_DESIGN=sail_default

sail-modified:
	cp programs/data.hex verilog/
	cp programs/program.hex verilog/
	yosys ../../../yscripts/$(MODIFIED_DESIGN).ys -l $(MODIFIED_DESIGN)_yosyslog.txt
	nextpnr-ice40 --up5k --package uwg30 --json $(MODIFIED_DESIGN).json --pcf pcf/$(MODIFIED_DESIGN).pcf --asc $(MODIFIED_DESIGN).asc -l $(MODIFIED_DESIGN)_pnrlog.txt
	icetime -p pcf/$(MODIFIED_DESIGN).pcf -P uwg30 -d up5k -t $(MODIFIED_DESIGN).asc
	icepack $(MODIFIED_DESIGN).asc $(MODIFIED_DESIGN).bin
	rm -f *.json *.blif
	#sudo iceprog -S $(MODIFIED_DESIGN).bin

sail-default:
	cp programs/data.hex .sail-core/verilog/
	cp programs/program.hex .sail-core/verilog/
	yosys ../../../yscripts/$(UNMODIFIED_DESIGN).ys -l $(UNMODIFIED_DESIGN)_yosyslog.txt
	nextpnr-ice40 --up5k --package uwg30 --json $(UNMODIFIED_DESIGN).json --pcf pcf/$(UNMODIFIED_DESIGN).pcf --asc $(UNMODIFIED_DESIGN).asc -l $(UNMODIFIED_DESIGN)_pnrlog.txt
	icetime -p pcf/$(UNMODIFIED_DESIGN).pcf -P uwg30 -d up5k -t $(UNMODIFIED_DESIGN).asc
	icepack $(UNMODIFIED_DESIGN).asc $(UNMODIFIED_DESIGN).bin
	rm -f *.json *.blif

clean:
	rm -f *.json *.blif *.asc *.bin *.txt
