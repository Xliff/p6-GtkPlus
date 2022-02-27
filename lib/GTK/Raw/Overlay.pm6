use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Overlay:ver<3.0.1146>;

sub gtk_overlay_add_overlay (GtkOverlay $overlay, GtkWidget $widget)
  is native(gtk)
  is export
  { * }

sub gtk_overlay_get_overlay_pass_through (
  GtkOverlay $overlay,
  GtkWidget $widget
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_overlay_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_overlay_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_overlay_reorder_overlay (
  GtkOverlay $overlay,
  GtkWidget $child,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_overlay_set_overlay_pass_through (
  GtkOverlay $overlay,
  GtkWidget $widget,
  gboolean $pass_through
)
  is native(gtk)
  is export
  { * }