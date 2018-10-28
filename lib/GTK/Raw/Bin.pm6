use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Bin;

sub gtk_bin_get_child (GtkBin $bin)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_bin_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }