use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::Offscreen;

sub gtk_offscreen_window_get_pixbuf (GtkOffscreen $offscreen)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_offscreen_window_get_surface (GtkOffscreen $offscreen)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_offscreen_window_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_offscreen_window_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }