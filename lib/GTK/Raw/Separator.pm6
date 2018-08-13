use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Separator;

sub gtk_separator_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_separator_new (uint32 $o)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }
