#include <stdio.h>

int int_compare(long int *a, long int *b) {
	if (*a > *b) return 1;
	if (*b < *a) return -1;
	return 0;
}
