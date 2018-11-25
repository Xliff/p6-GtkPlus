use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ColorButton;

sub gtk_color_button_get_color (GtkColorButton $button, GdkColor $color)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_get_rgba (GtkColorButton $button, GdkRGBA $rgba)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_color_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_color_button_new_with_color (GdkColor $color)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_color_button_new_with_rgba (GdkRGBA $rgba)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_color_button_set_color (GtkColorButton $button, GdkColor $color)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_set_rgba (GtkColorButton $button, GdkRGBA $rgba)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_get_use_alpha (GtkColorButton $button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_color_button_get_title (GtkColorButton $button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_color_button_get_alpha (GtkColorButton $button)
  returns guint16
  is native(gtk)
  is export
  { * }

sub gtk_color_button_set_use_alpha (GtkColorButton $button, gboolean $use_alpha)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_set_title (GtkColorButton $button, gchar $title)
  is native(gtk)
  is export
  { * }

sub gtk_color_button_set_alpha (GtkColorButton $button, guint16 $alpha)
  is native(gtk)
  is export
  { * }
