use v6.c;

use NativeCall;

use Pango::Raw::Types;
use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::FontChooser:ver<3.0.1146>;

sub gtk_font_chooser_get_font_face (GtkFontChooser $fontchooser)
  returns PangoFontFace
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_font_family (GtkFontChooser $fontchooser)
  returns PangoFontFamily
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_font_size (GtkFontChooser $fontchooser)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_filter_func (
  GtkFontChooser $fontchooser,
  &filter (PangoFontFamily, PangoFontFace, Pointer --> gboolean),
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_font (GtkFontChooser $fontchooser)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_font_map (GtkFontChooser $fontchooser)
  returns PangoFontMap
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_show_preview_entry (GtkFontChooser $fontchooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_preview_text (GtkFontChooser $fontchooser)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_get_font_desc (GtkFontChooser $fontchooser)
  returns PangoFontDescription
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_font (GtkFontChooser $fontchooser, gchar $fontname)
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_font_map (
  GtkFontChooser $fontchooser,
  PangoFontMap $fontmap
)
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_show_preview_entry (
  GtkFontChooser $fontchooser,
  gboolean $show_preview_entry
)
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_preview_text (
  GtkFontChooser $fontchooser,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_set_font_desc (
  GtkFontChooser $fontchooser,
  PangoFontDescription $font_desc
)
  is native(gtk)
  is export
  { * }
