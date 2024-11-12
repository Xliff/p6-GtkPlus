use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::MenuToolButton:ver<3.0.1146>;

sub gtk_menu_tool_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_new (GtkWidget $icon_widget, Str $label)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_new_from_stock (Str $stock_id)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_markup (
  GtkMenuToolButton $button,
  Str $markup
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_tool_button_set_arrow_tooltip_text (
  GtkMenuToolButton $button,
  Str $text
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