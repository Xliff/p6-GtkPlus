use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Bin:ver<3.0.1146>;

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