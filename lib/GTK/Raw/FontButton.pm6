use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::FontButton;

sub gtk_font_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_font_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_font_button_new_with_font (gchar $fontname)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_use_size (GtkFontButton $font_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_use_font (GtkFontButton $font_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_show_style (GtkFontButton $font_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_show_size (GtkFontButton $font_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_font_name (GtkFontButton $font_button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_font_button_get_title (GtkFontButton $font_button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_use_size (GtkFontButton $font_button, gboolean $use_size)
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_use_font (GtkFontButton $font_button, gboolean $use_font)
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_show_style (GtkFontButton $font_button, gboolean $show_style)
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_show_size (GtkFontButton $font_button, gboolean $show_size)
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_font_name (GtkFontButton $font_button, gchar $fontname)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_button_set_title (GtkFontButton $font_button, gchar $title)
  is native(gtk)
  is export
  { * }