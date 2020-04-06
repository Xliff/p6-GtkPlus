use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::Separator;

sub gtk_separator_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_separator_new (uint32 $o)
  returns GtkWidget
  is native(gtk)
  is export
  { * }