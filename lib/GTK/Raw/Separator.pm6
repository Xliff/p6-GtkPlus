use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Separator;

sub gtk_separator_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_separator_new (uint32 $o)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }