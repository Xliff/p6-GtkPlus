use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Rectangle;

sub gdk_rectangle_equal (GdkRectangle $rect1, GdkRectangle $rect2)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_rectangle_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gdk_rectangle_intersect (
  GdkRectangle $src1,
  GdkRectangle $src2,
  GdkRectangle $dest
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_rectangle_union (
  GdkRectangle $src1,
  GdkRectangle $src2,
  GdkRectangle $dest
)
  is native(gtk)
  is export
  { * }