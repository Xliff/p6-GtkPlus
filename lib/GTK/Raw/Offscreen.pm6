use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Offscreen;

sub gtk_offscreen_window_get_pixbuf (GtkOffscreen $offscreen)
  returns GdkPixbuf
  is native($LIBGTK)
  is export
  { * }

sub gtk_offscreen_window_get_surface (GtkOffscreen $offscreen)
  returns cairo_surface_t
  is native($LIBGTK)
  is export
  { * }

sub gtk_offscreen_window_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_offscreen_window_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }