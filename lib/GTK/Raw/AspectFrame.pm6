use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::AspectFrame:ver<3.0.1146>;

sub gtk_aspect_frame_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_aspect_frame_new (
  Str $label,
  gfloat $xalign,
  gfloat $yalign,
  gfloat $ratio,
  gboolean $obey_child
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_aspect_frame_set (
  GtkAspectFrame $aspect_frame,
  gfloat $xalign,
  gfloat $yalign,
  gfloat $ratio,
  gboolean $obey_child
)
  is native(gtk)
  is export
  { * }