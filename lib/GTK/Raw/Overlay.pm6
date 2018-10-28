use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Overlay;

sub gtk_overlay_add_overlay (GtkOverlay $overlay, GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_overlay_get_overlay_pass_through (
  GtkOverlay $overlay,
  GtkWidget $widget
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_overlay_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_overlay_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_overlay_reorder_overlay (
  GtkOverlay $overlay,
  GtkWidget $child,
  gint $position
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_overlay_set_overlay_pass_through (
  GtkOverlay $overlay,
  GtkWidget $widget,
  gboolean $pass_through
)
  is native($LIBGTK)
  is export
  { * }