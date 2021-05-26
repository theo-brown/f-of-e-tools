# Files

- `README.md`: This readme.

- `Makefile`: There are 3 options of how to `make` the simulation.

  1. `make verilator` to make an executable simulation using verilator.
  2. `make iverilog` to make an executable simulation using iverilog (I haven't managed to $display or $monitor my registers with iverilog)
  3. `make yosys` to synthesise using yosys and then simulate using iverilog (again, I haven't managed to $display or $monitor) 

- `required_modules.txt`: a list of all the additional verilog files used in compilation. This should work without modification if you have correctly linked `verilog` to the right location (see below).

- `toplevel_sim.cpp`: C++ program that wraps the Verilated module. If you want to interact with your module, put the code in here.

- `toplevel_sim.v`: The verilog file containing the toplevel module of the processor, modified for use with iverilog or verilator

- `toplevel_sim_iverilog.v`: The version of the toplevel module modified for compilation with iverilog.

- `toplevel_sim_verilator.v`: The version of the toplevel module modified for compilation with verilator.

- `verilog`: A symbolic link to the correct location of your verilog files containing the modules for the processor. **You need to make sure that this points to the right location.** Set the correct path for your file locations by doing `rm verilog; ln -s PATH verilog`, replacing PATH with the path to your verilog directory.
