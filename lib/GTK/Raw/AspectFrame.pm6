use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::AspectFrame;

sub gtk_aspect_frame_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_aspect_frame_new (
  gchar $label,
  gfloat $xalign,
  gfloat $yalign,
  gfloat $ratio,
  gboolean $obey_child
)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_aspect_frame_set (
  GtkAspectFrame $aspect_frame,
  gfloat $xalign,
  gfloat $yalign,
  gfloat $ratio,
  gboolean $obey_child
)
  is native('gtk-3')
  is export
  { * }
