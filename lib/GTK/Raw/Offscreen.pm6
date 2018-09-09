use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Offscreen;

sub gtk_offscreen_window_get_pixbuf (GtkOffscreenWindow $offscreen)
  returns GdkPixbuf
  is native('gtk-3')
  is export
  { * }

sub gtk_offscreen_window_get_surface (GtkOffscreenWindow $offscreen)
  returns cairo_surface_t
  is native('gtk-3')
  is export
  { * }

sub gtk_offscreen_window_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_offscreen_window_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }
