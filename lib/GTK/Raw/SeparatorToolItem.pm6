use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::SeparatorToolItem;

sub gtk_separator_tool_item_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_separator_tool_item_new ()
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_separator_tool_item_get_draw (GtkSeparatorToolItem $item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_separator_tool_item_set_draw (GtkSeparatorToolItem $item, gboolean $draw)
  is native('gtk-3')
  is export
  { * }
