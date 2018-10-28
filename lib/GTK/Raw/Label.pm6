use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Label;

sub gtk_label_get_current_uri (GtkLabel $l)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_layout (GtkLabel $l)
 returns PangoLayout
 is native($LIBGTK)
 is export
 { * }

sub gtk_label_get_layout_offsets (GtkLabel $l, gint $x, gint $y)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_mnemonic_keyval (GtkLabel $l)
  returns guint
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_selection_bounds (GtkLabel $l, gint $start, gint $end)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_new (Str $text)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_new_with_mnemonic (Str $text)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_select_region (GtkLabel $l, gint $start_offset, gint $end_offset)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_markup (GtkLabel $l, gchar $str)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_markup_with_mnemonic (GtkLabel $l, gchar $str)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_pattern (GtkLabel $l, gchar $pattern)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_text_with_mnemonic (GtkLabel $l, gchar $str)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_lines (GtkLabel $l)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_use_markup (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_label (GtkLabel $l)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_line_wrap (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_width_chars (GtkLabel $l)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_attributes (GtkLabel $l)
 returns PangoAttrList
 is native($LIBGTK)
 is export
 { * }

sub gtk_label_get_justify (GtkLabel $l)
  returns uint32 # GtkJustification
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_use_underline (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_line_wrap_mode (GtkLabel $l)
 returns uint32 # PangoWrapMode
 is native($LIBGTK)
 is export
 { * }

sub gtk_label_get_max_width_chars (GtkLabel $l)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_selectable (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_text (GtkLabel $l)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_track_visited_links (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_ellipsize (GtkLabel $l)
 returns uint32 # PangoEllipsizeMode
 is native($LIBGTK)
 is export
 { * }

sub gtk_label_get_xalign (GtkLabel $l)
  returns gfloat
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_yalign (GtkLabel $l)
  returns gfloat
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_single_line_mode (GtkLabel $l)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_angle (GtkLabel $l)
  returns gdouble
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_get_mnemonic_widget (GtkLabel $l)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_lines (GtkLabel $l, gint $lines)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_use_markup (GtkLabel $l, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_label (GtkLabel $l, gchar $str)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_line_wrap (GtkLabel $l, gboolean $wrap)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_width_chars (GtkLabel $l, gint $n_chars)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_attributes (GtkLabel $l, PangoAttrList $attrs)
  is native($LIBGTK)
  is export
  { * }

# (GtkLabel $l, GtkJustification $jtype)
sub gtk_label_set_justify (GtkLabel $l, uint32 $jtype)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_use_underline (GtkLabel $l, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

# (GtkLabel $l, PangoWrapMode $wrap_mode)
sub gtk_label_set_line_wrap_mode (GtkLabel $l, uint32 $wrap_mode)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_max_width_chars (GtkLabel $l, gint $n_chars)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_selectable (GtkLabel $l, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_text (GtkLabel $l, gchar $str)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_track_visited_links (GtkLabel $l, gboolean $track_links)
  is native($LIBGTK)
  is export
  { * }

#(GtkLabel $l, PangoEllipsizeMode $mode)
sub gtk_label_set_ellipsize (GtkLabel $l, uint32 $mode)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_xalign (GtkLabel $l, gfloat $xalign)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_yalign (GtkLabel $l, gfloat $yalign)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_single_line_mode (GtkLabel $l, gboolean $single_line_mode)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_angle (GtkLabel $l, gdouble $angle)
  is native($LIBGTK)
  is export
  { * }

sub gtk_label_set_mnemonic_widget (GtkLabel $l, GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }