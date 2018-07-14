use v6.c;

use NativeCall;

use GTK::Raw::Pointers;

unit package GTK::Raw::Bin;

sub gtk_bin_get_child (GtkBin $bin)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_bin_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }
