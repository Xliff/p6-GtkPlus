use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::GtkRadioToolButton;

sub gtk_radio_tool_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_new (GSList $group)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_new_from_stock (GSList $group, gchar $stock_id)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_new_from_widget (GtkRadioToolButton $group)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_new_with_stock_from_widget (
  GtkRadioToolButton $group,
  gchar $stock_id
)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_get_group (GtkRadioToolButton $button)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_radio_tool_button_set_group (
  GtkRadioToolButton $button,
  GSList $group
)
  is native(gtk)
  is export
  { * }