#include <stdio.h>
#include <time.h>
#include <glib.h>

#include "gio/gio.h"

void main(int argc, char **argv) {
	printf ("sizeof time_t is: %ld\n", sizeof(time_t));
	printf ("G_IO_ERROR_FAILED = %d\n", G_IO_ERROR_FAILED);
	printf ("G_IO_ERROR_NONE = %d\n", G_IO_ERROR_NONE);
	printf ("G_IO_ERROR_WOULD_BLOCK = %d\n", G_IO_ERROR_WOULD_BLOCK);
	printf ("G_IO_ERROR_BROKEN_PIPE = %d\n", G_IO_ERROR_BROKEN_PIPE);
}
