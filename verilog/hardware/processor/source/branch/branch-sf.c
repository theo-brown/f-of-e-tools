#include <printf.h>

int main(void)
{
	int list[60] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
	       	21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
		41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60};
	int i, j;
	int tot;
	for (i = 0; i<60; i++) {
		for (j = 0; j<60; j++){
			if (list[i] == list[j]) {
				tot = 0;
			}
			else if (list[i] > list[j]) {
				if (list[i] > (list[j] + 8)) {
					tot = 1;
				}
				else if (list[i] > (list[j] + 4)) {
					tot = 2;
				}
				else {
					tot = 3;
				}
			}
			else if (list[i] < list[j]) {
				if (list[i] < (list[j] - 8)) {
					tot = 4;
				}
				else if (list[i] < (list[j] - 4)) {
					tot = 5;
				}
				else {
					tot = 6;
				}
			}
			else {
				tot = 7;
			}
		}
	}
	printf("%i", tot);
	return 0;
}
