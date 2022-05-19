use v6.c;

use NativeCall;
use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::TextIter:ver<3.0.1146>;

sub gtk_text_iter_assign (GtkTextIter $iter, GtkTextIter $other)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_char (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_chars (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_cursor_position (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_cursor_positions (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_find_char (
  GtkTextIter $iter,
  &pred (gunichar, gpointer --> gboolean),
  gpointer $user_data,
  GtkTextIter $limit
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_lines (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_search (
  GtkTextIter $iter,
  gchar $str,
  uint32 $flags,                # GtkTextSearchFlags $flags,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  GtkTextIter $limit
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_sentence_start (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_sentence_starts (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_to_tag_toggle (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_cursor_position (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_cursor_positions (
  GtkTextIter $iter,
  gint $count
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_lines (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_word_start (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_visible_word_starts (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_word_start (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_backward_word_starts (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_begins_tag (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_can_insert (GtkTextIter $iter, gboolean $default_editability)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_compare (GtkTextIter $lhs, GtkTextIter $rhs)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_copy (GtkTextIter $iter)
  returns GtkTextIter
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_editable (GtkTextIter $iter, gboolean $default_setting)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_ends_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_ends_sentence (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_ends_tag (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_ends_word (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_equal (GtkTextIter $lhs, GtkTextIter $rhs)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_char (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_chars (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_cursor_position (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_cursor_positions (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_find_char (
  GtkTextIter $iter,
  &pred,
  gpointer $user_data,
  GtkTextIter $limit
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_lines (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_search (
  GtkTextIter $iter,
  gchar $str,
  uint32 $flags,                  # GtkTextSearchFlags $flags,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  GtkTextIter $limit
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_sentence_end (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_sentence_ends (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_to_end (GtkTextIter $iter)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_to_line_end (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_to_tag_toggle (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_cursor_position (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_cursor_positions (
  GtkTextIter $iter,
  gint $count
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_lines (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_word_end (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_visible_word_ends (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_word_end (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_forward_word_ends (GtkTextIter $iter, gint $count)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_free (GtkTextIter $iter)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_attributes (GtkTextIter $iter, GtkTextAttributes $values)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_buffer (GtkTextIter $iter)
  returns GtkTextBuffer
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_bytes_in_line (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_char (GtkTextIter $iter)
  returns gunichar
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_chars_in_line (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_child_anchor (GtkTextIter $iter)
  returns GtkTextChildAnchor
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_language (GtkTextIter $iter)
  returns PangoLanguage
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_marks (GtkTextIter $iter)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_pixbuf (GtkTextIter $iter)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_slice (GtkTextIter $start, GtkTextIter $end)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_tags (GtkTextIter $iter)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_text (GtkTextIter $start, GtkTextIter $end)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_toggled_tags (GtkTextIter $iter, gboolean $toggled_on)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_visible_slice (GtkTextIter $start, GtkTextIter $end)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_visible_text (GtkTextIter $start, GtkTextIter $end)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_has_tag (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_in_range (
  GtkTextIter $iter,
  GtkTextIter $start,
  GtkTextIter $end
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_inside_sentence (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_inside_word (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_is_cursor_position (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_is_end (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_is_start (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_order (GtkTextIter $first, GtkTextIter $second)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_starts_line (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_starts_sentence (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_starts_tag (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_starts_word (GtkTextIter $iter)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_toggles_tag (GtkTextIter $iter, GtkTextTag $tag)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_line_offset (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_visible_line_index (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_visible_line_offset (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_line (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_offset (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_get_line_index (GtkTextIter $iter)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_line_offset (GtkTextIter $iter, gint $char_on_line)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_visible_line_index (
  GtkTextIter $iter,
  gint $byte_on_line
)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_visible_line_offset (
  GtkTextIter $iter,
  gint $char_on_line
)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_line (GtkTextIter $iter, gint $line_number)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_offset (GtkTextIter $iter, gint $char_offset)
  is native(gtk)
  is export
  { * }

sub gtk_text_iter_set_line_index (GtkTextIter $iter, gint $byte_on_line)
  is native(gtk)
  is export
  { * }
