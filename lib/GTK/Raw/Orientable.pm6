use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Orientable;

sub gtk_orientable_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_orientable_get_orientation (GtkOrientable $orientable)
  returns uint32 # GtkOrientation
  is native($LIBGTK)
  is export
  { * }

sub gtk_orientable_set_orientation (
  GtkOrientable $orientable,
  uint32 $orientation           # GtkOrientation $orientation
)
  is native($LIBGTK)
  is export
  { * }