use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ColorChooser;

sub gtk_color_chooser_widget_new ()
  returns GtkColorChooser
  is native(gtk)
  is export
  { * }

sub gtk_color_chooser_add_palette (
  GtkColorChooser $chooser,
  uint32 $orientation,
  gint $colors_per_line,
  gint $n_colors,
  GTK::Compat::RGBA $colors
)
  is native(gtk)
  is export
  { * }

sub gtk_color_chooser_get_rgba (
  GtkColorChooser $chooser,
  GTK::Compat::RGBA $color
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
  GTK::Compat::RGBA $color
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