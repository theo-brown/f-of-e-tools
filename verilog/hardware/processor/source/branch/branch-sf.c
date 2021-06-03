#include <printf.h>

int main(void)
{
	int list[14] = {19, 10, 8, 17, 9, 1, 3, 6, 8, 12, 34, 5, 2, 8};
	for (i = 1; i<13; i++) {
		if (i == list[i]) {
			printf("E");
		}
		else if (i > list[i]) {
			printf("G");
		}
		else if (i < list[i]) {
			printf("L");
		}
		else {
			printf("W");
		}
	}
	return 0;
}
