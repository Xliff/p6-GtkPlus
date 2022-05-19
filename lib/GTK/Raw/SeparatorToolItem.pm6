use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::SeparatorToolItem:ver<3.0.1146>;

sub gtk_separator_tool_item_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_separator_tool_item_new ()
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_separator_tool_item_get_draw (GtkSeparatorToolItem $item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_separator_tool_item_set_draw (GtkSeparatorToolItem $item, gboolean $draw)
  is native(gtk)
  is export
  { * }