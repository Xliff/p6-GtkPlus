use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Offscreen:ver<3.0.1146>;

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