use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Tooltip:ver<3.0.1146>;

sub gtk_tooltip_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_custom (GtkTooltip $tooltip, GtkWidget $custom_widget)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_icon (GtkTooltip $tooltip, GdkPixbuf $pixbuf)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_icon_from_gicon (
  GtkTooltip $tooltip,
  GIcon $gicon,
  uint32 $s                     # GtkIconSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_icon_from_icon_name (
  GtkTooltip $tooltip,
  gchar $icon_name,
  uint32 $s                     # GtkIconSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_icon_from_stock (
  GtkTooltip $tooltip,
  gchar $stock_id,
  uint32 $s                     # GtkIconSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_markup (GtkTooltip $tooltip, gchar $markup)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_text (GtkTooltip $tooltip, gchar $text)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_tip_area (GtkTooltip $tooltip, GdkRectangle $rect)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_trigger_tooltip_query (GdkDisplay $display)
  is native(gtk)
  is export
  { * }