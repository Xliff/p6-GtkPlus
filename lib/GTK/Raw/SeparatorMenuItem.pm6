use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::SeparatorMenuItem;

sub gtk_separator_menu_item_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_separator_menu_item_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }