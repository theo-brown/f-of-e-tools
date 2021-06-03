#include <printf.h>

int main(void)
{
	int list[28] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
	       	20, 21, 22, 23, 24, 25, 26, 27, 28};
	int i, j;
	int tot = 0;
	for (i = 0; i<28; i++) {
		for (j = 0; j<28; j++){
			if (list[i] == list[j]) {
				printf("E");
			}
			else if (list[i] > list[j]) {
				if (list[i]) > (list[j] + 8) {
					printf("1");
				}
				else if (list[i] > list[j] + 4) {
					printf("2");
				}
				else {
					printf("3")
				}
			}
			else if (list[i] < list[j]) {
				if (list[i]) < (list[j] - 8) {
					printf("4");
				}
				else if (list[i] < list[j] - 4) {
					printf("5");
				}
				else {
					printf("6")
				}
			}
			else {
				printf_("W");
			}
		}
	}
	return 0;
}
