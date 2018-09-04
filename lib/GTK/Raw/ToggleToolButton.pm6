use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ToggleToolButton;

sub gtk_toggle_tool_button_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_toggle_tool_button_new ()
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_toggle_tool_button_new_from_stock (gchar $stock_id)
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_toggle_tool_button_get_active (GtkToggleToolButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_toggle_tool_button_set_active (
  GtkToggleToolButton $button,
  gboolean $is_active
)
  is native('gtk-3')
  is export
  { * }
