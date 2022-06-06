use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Separator:ver<3.0.1146>;

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