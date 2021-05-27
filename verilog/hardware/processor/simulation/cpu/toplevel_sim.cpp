#include <stdio.h>
#include <verilated.h>
#include "Vtoplevel_sim.h"

vluint64_t vtime = 0;
bool clk = false;
int led = 255;

int main(int argc, char** argv, char** env)
{
	Verilated::commandArgs(argc, argv);
	Vtoplevel_sim* top = new Vtoplevel_sim;

	while (!Verilated::gotFinish())
	{
		clk = not clk;
		top->clk = int(clk);
		top->eval();
		if (led != int(top->led))
		{
			led = int(top->led);
			printf("%i\n", led);
		}
		vtime++;
	}

        delete top;
        exit(0);
}
