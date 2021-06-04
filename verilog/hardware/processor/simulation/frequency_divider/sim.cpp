#include <stdio.h>
#include <verilated.h>
#include "Vfrequency_divider.h"

vluint64_t vtime = 0;
bool clk = false;

int main(int argc, char** argv, char** env)
{
	Verilated::commandArgs(argc, argv);
	Vfrequency_divider* frequency_divider = new Vfrequency_divider;

	while (!Verilated::gotFinish())
	{
		clk = not clk;
		frequency_divider->input_signal = int(clk);
		frequency_divider->eval();
		printf("%i | %i\n", int(frequency_divider->input_signal), int(frequency_divider->output_signal));
		vtime++;
	}

        delete frequency_divider;
        exit(0);
}
