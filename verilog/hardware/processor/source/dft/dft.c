//#include <stdio.h>
#include <math.h>

#define PI 3.14159265
#define REAL 0
#define IMAG 1

float input[] = {0.5       , 0.90909323, 0.72317816, 0.4967802 , 0.73189363,
                0.88073713, 0.51976053, 0.26954413, 0.55830367, 0.76688287,
                0.51049979, 0.41761884, 0.8050414 , 0.98195852, 0.62338217,
                0.39481056};

void dft_k(float *input_values, float* output_value, int k, int num_values)
{
    output_value[REAL] = 0;
    output_value[IMAG] = 0;

    for (int n = 0; n <= num_values-1; n += 1)
    {
        output_value[REAL] += input[n] * cos(2*PI*k*n/num_values);
        output_value[IMAG] += -input[n] * sin(2*PI*k*n/num_values);
    }
}

int main(void)
{
	volatile unsigned int *output_register = (unsigned int *) 0x2000;
	unsigned char output = 0xFF;
	*output_register = output;

    while(1)
    {
        // Number of data points
        int N = 16;
        float output_k[] = {0, 0};
        for (int k = 0; k <= N-1; k+=1)
        {
            dft_k(input, output_k, k, N);
            //printf("%f + %fj\n", output_k[REAL], output_k[IMAG]);
        }
        if (output == 0xFF) output = 0x00;
		else output = 0xFF;
		//printf("%i\n", output);
		*output_register = output;
    }
    return 0;
}
