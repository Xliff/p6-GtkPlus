use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ColorChooser;

sub gtk_color_chooser_widget_new()
  returns GtkColorChooser
  is native('gtk-3')
  is export
  { * }

#(GtkColorChooser $chooser, GtkOrientation $orientation, gint $colors_per_line, gint $n_colors, GdkRGBA $colors)
sub gtk_color_chooser_add_palette (GtkColorChooser $chooser, uint32 $orientation, gint $colors_per_line, gint $n_colors, GdkRGBA $colors)
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_get_rgba (GtkColorChooser $chooser, GdkRGBA $color)
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_set_rgba (GtkColorChooser $chooser, GdkRGBA $color)
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_get_use_alpha (GtkColorChooser $chooser)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_set_use_alpha (GtkColorChooser $chooser, gboolean $use_alpha)
  is native('gtk-3')
  is export
  { * }
