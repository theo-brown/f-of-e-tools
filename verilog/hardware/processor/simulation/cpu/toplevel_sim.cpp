#include <iostream>
#include <verilated.h>
#include "Vtoplevel_sim.h"

vluint64_t vtime = 0;
bool clk = false;

int main(int argc, char** argv, char** env)
{
	Verilated::commandArgs(argc, argv);
	Vtoplevel_sim* top = new Vtoplevel_sim;

	while (!Verilated::gotFinish())
	{
		if (vtime % 10 == 1) {
			clk = not clk;
			top->clk = int(clk);
		}
		top->eval();
		vtime++;
	}

        delete top;
        exit(0);
}
