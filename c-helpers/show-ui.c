#include <gtk/gtk.h>

int
main (int   argc,
      char *argv[])
{
  GtkBuilder *builder;
  GtkWidget *window;
  GObject *button;
  GError *error = NULL;

  if (argc <= 1) {
    g_printerr("Usage: show-ui <name of ui file>\n\n");
    return 1;
  }

  gtk_init (&argc, &argv);

  /* Construct a GtkBuilder instance and load our UI description */
  builder = gtk_builder_new ();
  if (gtk_builder_add_from_file (builder, argv[1], &error) == 0) {
      g_printerr ("Error loading file: %s\n", error->message);
      g_clear_error (&error);
      return 1;
  }

  window = (GtkWidget *)gtk_builder_get_object(builder, "shortcuts-builder");
  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
