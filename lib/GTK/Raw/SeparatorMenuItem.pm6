use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::SeparatorMenuItem:ver<3.0.1146>;

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