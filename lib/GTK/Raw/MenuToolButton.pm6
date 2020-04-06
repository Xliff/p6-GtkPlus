use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::MenuToolButton;

sub gtk_menu_tool_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_new (GtkWidget $icon_widget, gchar $label)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_new_from_stock (gchar $stock_id)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_markup (
  GtkMenuToolButton $button,
  gchar $markup
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_text (
  GtkMenuToolButton $button,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_get_menu (GtkMenuToolButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_set_menu (GtkMenuToolButton $button, GtkWidget $menu)
  is native(gtk)
  is export
  { * }