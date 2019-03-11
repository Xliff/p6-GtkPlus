#include <gtk/gtk.h>

void main(int argc, char **argv) {
  gtk_init(&argc, &argv);

  GtkImage *i = (GtkImage *)gtk_image_new();
  GValue v = {0};
  g_value_init(&v, G_TYPE_STRING);
  g_value_set_string(&v, "image-missing");
  const char *props[] = { "icon-name" };
  GValue vals[] = { v };
  g_object_setv((GObject *)i, 1, props, vals);

  g_value_unset(&v);
  g_value_init(&v, G_TYPE_STRING);
  g_object_getv((GObject *)i, 1, props, &v);
  printf(
    "%s, %ld, %ld, %ld\n",
    g_value_get_string(&v),
    G_TYPE_STRING,
    sizeof(v), sizeof(GtkEntry)
  );

}
