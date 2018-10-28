use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Bin;

sub gtk_bin_get_child (GtkBin $bin)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_bin_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }