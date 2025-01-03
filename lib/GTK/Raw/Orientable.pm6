use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Orientable:ver<3.0.1146>;

sub gtk_orientable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_orientable_get_orientation (GtkOrientable $orientable)
  returns uint32 # GtkOrientation
  is native(gtk)
  is export
  { * }

sub gtk_orientable_set_orientation (
  GtkOrientable $orientable,
  uint32 $orientation           # GtkOrientation $orientation
)
  is native(gtk)
  is export
  { * }