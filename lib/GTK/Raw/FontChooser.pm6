use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::FontChooser;

sub gtk_font_chooser_get_font_face (GtkFontChooser $fontchooser)
  returns PangoFontFace
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_font_family (GtkFontChooser $fontchooser)
  returns PangoFontFamily
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_font_size (GtkFontChooser $fontchooser)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_filter_func (
  GtkFontChooser $fontchooser,
  GtkFontFilterFunc $filter,
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_font (GtkFontChooser $fontchooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_font_map (GtkFontChooser $fontchooser)
  returns PangoFontMap
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_show_preview_entry (GtkFontChooser $fontchooser)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_preview_text (GtkFontChooser $fontchooser)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_get_font_desc (GtkFontChooser $fontchooser)
  returns PangoFontDescription
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_font (GtkFontChooser $fontchooser, gchar $fontname)
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_font_map (
  GtkFontChooser $fontchooser,
  PangoFontMap $fontmap
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_show_preview_entry (
  GtkFontChooser $fontchooser,
  gboolean $show_preview_entry
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_preview_text (
  GtkFontChooser $fontchooser,
  gchar $text
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_font_chooser_set_font_desc (
  GtkFontChooser $fontchooser,
  PangoFontDescription $font_desc
)
  is native($LIBGTK)
  is export
  { * }