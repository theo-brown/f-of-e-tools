#include <stdio.h>

#define INACTIVE_CYCLES 1000000000
#define NUMBER_OF_SORTS 1000

int main(void)
{
	volatile unsigned int *output_register = (unsigned int *) 0x2000;
	unsigned char output = 0xFF;
	const int bsort_input_len = 0x3b;
	// *output_register = output;

	while (1)
	{
		// Perform NUMBER_OF_SORTS sorts, and toggle the output each sort
		for (int j = 0; j < NUMBER_OF_SORTS; j++)
		{
			char bsort_input[] = {0x53, 0x69, 0x6e, 0x67, 0x20, 0x74, 0x6f, 0x20, 0x6d, 0x65,
					      0x20, 0x6f, 0x66, 0x20, 0x74, 0x68, 0x65, 0x20, 0x6d, 0x61,
					      0x6e, 0x2c, 0x20, 0x4d, 0x75, 0x73, 0x65, 0x2c, 0x20, 0x74,
					      0x68, 0x65, 0x20, 0x6d, 0x61, 0x6e, 0x20, 0x6f, 0x66, 0x20,
					      0x74, 0x77, 0x69, 0x73, 0x74, 0x73, 0x20, 0x61, 0x6e, 0x64,
					      0x20, 0x74, 0x75, 0x72, 0x6e, 0x73, 0x2e, 0x2e, 0x2e};

			int maxindex = bsort_input_len - 1;

			while (maxindex > 0)
			{
				for (int i = 0; i < maxindex; i++)
				{
					if (bsort_input[i] > bsort_input[i+1])
					{
						/*		swap		*/
						bsort_input[i] ^= bsort_input[i+1];
						bsort_input[i+1] ^= bsort_input[i];
						bsort_input[i] ^= bsort_input[i+1];
					}
				}

				maxindex--;
			}

			if (output == 0xFF) output = 0x00;
			else output = 0xFF;
			// *output_register = output;
			printf("%d\n", output);
		}
		printf("Pausing....\n");
		for (unsigned long int k = 0; k < INACTIVE_CYCLES; k++)
		{
			;
		}
	}

	return 0;
}
