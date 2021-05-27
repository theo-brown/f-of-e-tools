#include <stdio.h>

int integer_sqrt(int n)
{
	int i;
	for (i=1; i*i < n; i++);
	return i;
}

void primefactors(int n)
{
	int m = n;
	int sqrt = integer_sqrt(n);
	for (int i = 2; i < sqrt; i++)
	{
		while (m % i == 0)
		{
			m = m/i;
			//printf("%i ", i);
		}
	}
}

int main(void)
{
	volatile unsigned int *output_register = (unsigned int *) 0x2000;
	unsigned char output = 0xFF;
	*output_register = output;

	unsigned int n = 3*7*269*103*577;

	//printf("%i\n", integer_sqrt(n));
	while(1)
	{
		primefactors(n);

		// Toggle output
		output = ~output;
		*output_register = output;
	}

	return 0;
}
