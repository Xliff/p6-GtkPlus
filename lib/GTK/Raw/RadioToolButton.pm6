use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::GtkRadioToolButton:ver<3.0.1146>;

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

sub gtk_radio_tool_button_new_from_stock (GSList $group, Str $stock_id)
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
  Str $stock_id
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