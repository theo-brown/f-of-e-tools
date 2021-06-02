//#include <stdio.h>

unsigned long int integer_sqrt(unsigned long int n)
{
	unsigned long int i;
	for (i=1; i*i < n; i++);
	return i;
}

void primefactors(unsigned long int n)
{
	unsigned long int m = n;
	unsigned long int sqrt = integer_sqrt(n);
	for (unsigned long int i = 2; i < sqrt; i++)
	{
		while (m % i == 0)
		{
			m = m/i;
			//printf("%llu\n", i);
		}
	}
}

int main(void)
{
	volatile unsigned int *output_register = (unsigned int *) 0x2000;
	unsigned char output = 0xFF;
	*output_register = output;

	//unsigned long int n = 683*(3*5*7)**3;
	unsigned long int n = 790657875;

	while(1)
	{
		primefactors(n);

		// Toggle output
		output = ~output;
		//printf("%i", output);
		*output_register = output;
	}

	return 0;
}
