use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::Sub;

sub g_io_error_quark ()
  returns GQuark
  is export
  is native(gio)
{ * }