use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::MenuToolButton;

sub gtk_menu_tool_button_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_new (GtkWidget $icon_widget, gchar $label)
  returns GtkToolItem
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_new_from_stock (gchar $stock_id)
  returns GtkToolItem
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_markup (
  GtkMenuToolButton $button,
  gchar $markup
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_text (
  GtkMenuToolButton $button,
  gchar $text
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_get_menu (GtkMenuToolButton $button)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_menu_tool_button_set_menu (GtkMenuToolButton $button, GtkWidget $menu)
  is native($LIBGTK)
  is export
  { * }