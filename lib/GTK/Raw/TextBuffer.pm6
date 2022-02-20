use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::TextBuffer:ver<3.0.1146>;

sub gtk_text_buffer_add_mark (
  GtkTextBuffer $buffer,
  GtkTextMark $mark,
  GtkTextIter $where
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_add_selection_clipboard (
  GtkTextBuffer $buffer,
  GtkClipboard $clipboard
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_apply_tag (
  GtkTextBuffer $buffer,
  GtkTextTag $tag,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_apply_tag_by_name (
  GtkTextBuffer $buffer,
  gchar $name,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_backspace (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gboolean $interactive,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_begin_user_action (GtkTextBuffer $buffer)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_copy_clipboard (GtkTextBuffer $buffer, GtkClipboard $clipboard)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_create_child_anchor (GtkTextBuffer $buffer, GtkTextIter $iter)
  returns GtkTextChildAnchor
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_create_mark (
  GtkTextBuffer $buffer,
  gchar $mark_name,
  GtkTextIter $where,
  gboolean $left_gravity
)
  returns GtkTextMark
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_cut_clipboard (
  GtkTextBuffer $buffer,
  GtkClipboard $clipboard,
  gboolean $default_editable
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_delete (
  GtkTextBuffer $buffer,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_delete_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter $start_iter,
  GtkTextIter $end_iter,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_delete_mark (GtkTextBuffer $buffer, GtkTextMark $mark)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_delete_mark_by_name (GtkTextBuffer $buffer, gchar $name)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_delete_selection (
  GtkTextBuffer $buffer,
  gboolean $interactive,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_end_user_action (GtkTextBuffer $buffer)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_bounds (
  GtkTextBuffer $buffer,
  GtkTextIter $start is rw,
  GtkTextIter $end is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_char_count (GtkTextBuffer $buffer)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_copy_target_list (GtkTextBuffer $buffer)
  returns GtkTargetList
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_end_iter (GtkTextBuffer $buffer, GtkTextIter $iter)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_has_selection (GtkTextBuffer $buffer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_insert (GtkTextBuffer $buffer)
  returns GtkTextMark
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_child_anchor (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GtkTextChildAnchor $anchor
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_line (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gint $line_number
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_line_index (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gint $line_number,
  gint $byte_index
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_line_offset (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gint $line_number,
  gint $char_offset
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_mark (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GtkTextMark $mark
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_iter_at_offset (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gint $char_offset
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_line_count (GtkTextBuffer $buffer)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_mark (GtkTextBuffer $buffer, gchar $name)
  returns GtkTextMark
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_paste_target_list (GtkTextBuffer $buffer)
  returns GtkTargetList
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_selection_bound (GtkTextBuffer $buffer)
  returns GtkTextMark
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_selection_bounds (
  GtkTextBuffer $buffer,
  GtkTextIter $start,
  GtkTextIter $end
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_slice (
  GtkTextBuffer $buffer,
  GtkTextIter $start,
  GtkTextIter $end,
  gboolean $include_hidden_chars
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_start_iter (GtkTextBuffer $buffer, GtkTextIter $iter)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_tag_table (GtkTextBuffer $buffer)
  returns GtkTextTagTable
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_text (
  GtkTextBuffer $buffer,
  GtkTextIter $start,
  GtkTextIter $end,
  gboolean $include_hidden_chars
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gchar $text,
  gint $len
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_at_cursor (GtkTextBuffer $buffer, gchar $text, gint $len)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_child_anchor (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GtkTextChildAnchor $anchor
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gchar $text,
  gint $len,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_interactive_at_cursor (
  GtkTextBuffer $buffer,
  gchar $text,
  gint $len,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_markup (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  gchar $markup,
  gint $len
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_pixbuf (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GdkPixbuf $pixbuf
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_range (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_range_interactive (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  GtkTextIter $start,
  GtkTextIter $end,
  gboolean $default_editable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_move_mark (
  GtkTextBuffer $buffer,
  GtkTextMark $mark,
  GtkTextIter $where
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_move_mark_by_name (
  GtkTextBuffer $buffer,
  gchar $name,
  GtkTextIter $where
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_new (GtkTextTagTable $table)
  returns GtkTextBuffer
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_paste_clipboard (
  GtkTextBuffer $buffer,
  GtkClipboard $clipboard,
  GtkTextIter $override_location,
  gboolean $default_editable
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_place_cursor (GtkTextBuffer $buffer, GtkTextIter $where)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_remove_all_tags (
  GtkTextBuffer $buffer,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_remove_selection_clipboard (
  GtkTextBuffer $buffer,
  GtkClipboard $clipboard
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_remove_tag (
  GtkTextBuffer $buffer,
  GtkTextTag $tag,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_remove_tag_by_name (
  GtkTextBuffer $buffer,
  gchar $name,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_select_range (
  GtkTextBuffer $buffer,
  GtkTextIter $ins,
  GtkTextIter $bound
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_set_text (GtkTextBuffer $buffer, gchar $text, gint $len)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_get_modified (GtkTextBuffer $buffer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_set_modified (GtkTextBuffer $buffer, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_with_tags (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  Str $text,
  gint $len,
  GtkTextTag $tag,
  GtkTextTag
)
  is native(gtk)
  is export
  { * }

sub gtk_text_buffer_insert_with_tags_by_name (
  GtkTextBuffer $buffer,
  GtkTextIter $iter,
  Str $text,
  gint $len,
  Str $tag_name,
  Str
)
  is native(gtk)
  is export
  { * }
