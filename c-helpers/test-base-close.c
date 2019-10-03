#include <stdio.h>
#include "glib.h"
#include "gio/gio.h"

void main (int argc, char **argv) {
  GInputStream *base;
  GInputStream *in;
  GError *error;

  g_test_init (&argc, &argv, NULL);

  base = g_memory_input_stream_new_from_data (
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVXYZ", -1, NULL
  );
  in = g_buffered_input_stream_new (base);

  g_filter_input_stream_set_close_base_stream(
    G_FILTER_INPUT_STREAM(in),
    FALSE
  );

  printf("%d\n",
    g_filter_input_stream_get_close_base_stream(
      G_FILTER_INPUT_STREAM(in)
    )
  );
  error = NULL;
  printf("%d\n", g_input_stream_close(in, NULL, &error) );
  g_assert_no_error(error);
  printf("%d\n", g_input_stream_is_closed(in) );
}
