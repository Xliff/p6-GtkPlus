use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::

sub gtk_orientable_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_orientable_get_orientation (GtkOrientable $orientable)
  returns GtkOrientation
  is native('gtk-3')
  is export
  { * }

sub gtk_orientable_set_orientation (
  GtkOrientable $orientable,
  uint32 $orientation           # GtkOrientation $orientation
)
  is native('gtk-3')
  is export
  { * }
