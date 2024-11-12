use v6.c;

use NativeCall;

use GDK::RGBA;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ColorChooser:ver<3.0.1146>;

sub gtk_color_chooser_widget_new ()
  returns GtkColorChooserWidget
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_widget_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_add_palette (
  GtkColorChooser $chooser,
  uint32 $orientation,
  gint $colors_per_line,
  gint $n_colors,
  GDK::RGBA $colors
)
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_get_rgba (
  GtkColorChooser $chooser,
  GDK::RGBA $color
)
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_set_rgba (
  GtkColorChooser $chooser,
  GDK::RGBA $color
)
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_get_use_alpha (GtkColorChooser $chooser)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_color_chooser_set_use_alpha (GtkColorChooser $chooser, gboolean $use_alpha)
  is native(gtk)
  is export
{ * }
