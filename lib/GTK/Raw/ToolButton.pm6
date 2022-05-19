use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::ToolButton:ver<3.0.1146>;

sub gtk_tool_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_new (GtkWidget $icon_widget, gchar $label)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_new_from_stock (gchar $stock_id)
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_icon_name (GtkToolButton $button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_use_underline (GtkToolButton $button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_icon_widget (GtkToolButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_stock_id (GtkToolButton $button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_label_widget (GtkToolButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_get_label (GtkToolButton $button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_icon_name (GtkToolButton $button, gchar $icon_name)
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_use_underline (GtkToolButton $button, gboolean $use_underline)
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_icon_widget (GtkToolButton $button, GtkWidget $icon_widget)
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_stock_id (GtkToolButton $button, gchar $stock_id)
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_label_widget (GtkToolButton $button, GtkWidget $label_widget)
  is native(gtk)
  is export
  { * }

sub gtk_tool_button_set_label (GtkToolButton $button, gchar $label)
  is native(gtk)
  is export
  { * }