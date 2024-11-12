use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

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
  Str $icon_name,
  uint32 $s                     # GtkIconSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_icon_from_stock (
  GtkTooltip $tooltip,
  Str $stock_id,
  uint32 $s                     # GtkIconSize $size
)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_markup (GtkTooltip $tooltip, Str $markup)
  is native(gtk)
  is export
  { * }

sub gtk_tooltip_set_text (GtkTooltip $tooltip, Str $text)
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
