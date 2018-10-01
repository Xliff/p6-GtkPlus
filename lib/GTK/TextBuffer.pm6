use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextBuffer;
use GTK::Raw::Types;
use GTK::Roles::Types;

use GTK::TextIter;

class GTK::TextBuffer {
  also does GTK::Roles::Types;

  has GtkTextBuffer $!tb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    # This should be moved to a role so that non GtkWidgets can use it!
    # $o.setType('GTK::TextBuffer');
    $o;
  }

  submethod BUILD(:$buffer) {
    $!tb = $buffer;
  }

  multi method new($text_tag_table = GtkTextTagTable) {
    my $buffer = gtk_text_buffer_new($text_tag_table);
    self.bless(:$buffer);
  }
  multi method new(GtkTextBuffer $buffer) {
    self.bless(:$buffer);
  }

  method GTK::Raw::Types::GtkTextBuffer {
    $!tb;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextBuffer, GtkTextTag, GtkTextIter, GtkTextIter, gpointer --> void
  method apply-tag {
    self.connect($!tb, 'apply-tag');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method begin-user-action {
    self.connect($!tb, 'begin-user-action');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method changed {
    self.connect($!tb, 'changed');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextIter, gpointer --> void
  method delete-range {
    self.connect($!tb, 'delete-range');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method end-user-action {
    self.connect($!tb, 'end-user-action');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextChildAnchor, gpointer --> void
  method insert-child-anchor {
    self.connect($!tb, 'insert-child-anchor');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GdkPixbuf, gpointer --> void
  method insert-pixbuf {
    self.connect($!tb, 'insert-pixbuf');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, gchar, gint, gpointer --> void
  method insert-text {
    self.connect($!tb, 'insert-text');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextMark, gpointer --> void
  method mark-deleted {
    self.connect($!tb, 'mark-deleted');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextMark, gpointer --> void
  method mark-set {
    self.connect($!tb, 'mark-set');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method modified-changed {
    self.connect($!tb, 'modified-changed');
  }

  # Is originally:
  # GtkTextBuffer, GtkClipboard, gpointer --> void
  method paste-done {
    self.connect($!tb, 'paste-done');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextTag, GtkTextIter, GtkTextIter, gpointer --> void
  method remove-tag {
    self.connect($!tb, 'remove-tag');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method modified is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_buffer_get_modified($!tb);
      },
      STORE => sub ($, $setting is copy) {
        gtk_text_buffer_set_modified($!tb, $setting);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_mark (
    GtkTextMark() $mark,
    GtkTextIter() $where
  ) {
    gtk_text_buffer_add_mark($!tb, $mark, $where);
  }

  method add_selection_clipboard (
    GtkClipboard() $clipboard
  ) {
    gtk_text_buffer_add_selection_clipboard($!tb, $clipboard);
  }

  method apply_tag (
    GtkTextTag() $tag,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_apply_tag($!tb, $tag, $start, $end);
  }

  method apply_tag_by_name (
    Str() $name,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_apply_tag_by_name($!tb, $name, $start, $end);
  }

  method backspace (
    GtkTextIter() $iter,
    Int() $interactive,           # gboolean $interactive,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my @b = ($interactive, $default_editable);
    my gboolean ($i, $de) = self.RESOLVE-BOOL(@b);;
    gtk_text_buffer_backspace($!tb, $iter, $i, $de);
  }

  method begin_user_action {
    gtk_text_buffer_begin_user_action($!tb);
  }

  method copy_clipboard (GtkClipboard() $clipboard) {
    gtk_text_buffer_copy_clipboard($!tb, $clipboard);
  }

  method create_child_anchor (GtkTextIter() $iter) {
    gtk_text_buffer_create_child_anchor($!tb, $iter);
  }

  method create_mark (
    gchar $mark_name,
    GtkTextIter() $where,
    Int() $left_gravity           # gboolean $left_gravity
  ) {
    my gboolean $lg = self.RESOLE-BOOL($left_gravity);
    gtk_text_buffer_create_mark($!tb, $mark_name, $where, $lg);
  }

  method cut_clipboard (
    GtkClipboard() $clipboard,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_cut_clipboard($!tb, $clipboard, $de);
  }

  method delete (
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_delete($!tb, $start, $end);
  }

  method delete_interactive (
    GtkTextIter() $start_iter,
    GtkTextIter() $end_iter,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_delete_interactive($!tb, $start_iter, $end_iter, $de);
  }

  method delete_mark (GtkTextMark() $mark) {
    gtk_text_buffer_delete_mark($!tb, $mark);
  }

  method delete_mark_by_name (gchar $name) {
    gtk_text_buffer_delete_mark_by_name($!tb, $name);
  }

  method delete_selection (
    Int() $interactive,           # gboolean $interactive,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my @b = ($interactive, $default_editable);
    my gboolean ($i, $de) = self.RESOLVE-BOOL(@b);
    gtk_text_buffer_delete_selection($!tb, $i, $de);
  }

  method end_user_action {
    gtk_text_buffer_end_user_action($!tb);
  }

  multi method get_bounds {
    my GtkTextIter $start .= new;
    my GtkTextIter $end .= new;
    samewith($start, $end);
    (
      GTK::TextIter.new($start),
      GTK::TextIter.new($end)
    )
  }
  multi method get_bounds (
    GtkTextIter() $start is rw,
    GtkTextIter() $end is rw
  ) {
    gtk_text_buffer_get_bounds($!tb, $start, $end);
  }

  method get_char_count {
    gtk_text_buffer_get_char_count($!tb);
  }

  method get_copy_target_list {
    gtk_text_buffer_get_copy_target_list($!tb);
  }

  multi method get_end_iter (GtkTextIter() $iter) {
    gtk_text_buffer_get_end_iter($!tb, $iter);
  }

  method get_has_selection {
    gtk_text_buffer_get_has_selection($!tb);
  }

  method get_insert {
    gtk_text_buffer_get_insert($!tb);
  }

  method get_iter_at_child_anchor (
    GtkTextIter() $iter,
    GtkTextChildAnchor $anchor
  ) {
    gtk_text_buffer_get_iter_at_child_anchor($!tb, $iter, $anchor);
  }

  method get_iter_at_line (
    GtkTextIter() $iter,
    Int() $line_number            # gint $line_number
  ) {
    my gint $ln = self.RESOLVE-INT($line_number);
    gtk_text_buffer_get_iter_at_line($!tb, $iter, $ln);
  }

  method get_iter_at_line_index (
    GtkTextIter() $iter,
    Int() $line_number,           # gint $line_number,
    Int() $byte_index             # gint $byte_index
  ) {
    my @i = ($line_number, $byte_index);
    my gint ($ln, $bi) = self.RESOLVE-INT(@i);
    gtk_text_buffer_get_iter_at_line_index($!tb, $iter, $ln, $bi);
  }

  method get_iter_at_line_offset (
    GtkTextIter() $iter,
    Int() $line_number,           # gint $line_number,
    Int() $char_offset            # gint $char_offset
  ) {
    my @i = ($line_number, $char_offset);
    my gint ($ln, $co) = self.RESOLVE-INT(@i);
    gtk_text_buffer_get_iter_at_line_offset($!tb, $iter, $ln, $co);
  }

  method get_iter_at_mark (
    GtkTextIter() $iter,
    GtkTextMark() $mark
  ) {
    gtk_text_buffer_get_iter_at_mark($!tb, $iter, $mark);
  }

  method get_iter_at_offset (
    GtkTextIter() $iter,
    Int() $char_offset            # gint $char_offset
  ) {
    my gint $co = self.RESOLVE-INT($char_offset);
    gtk_text_buffer_get_iter_at_offset($!tb, $iter, $co);
  }

  method get_line_count {
    gtk_text_buffer_get_line_count($!tb);
  }

  method get_mark (Str() $name) {
    gtk_text_buffer_get_mark($!tb, $name);
  }

  method get_paste_target_list {
    gtk_text_buffer_get_paste_target_list($!tb);
  }

  method get_selection_bound {
    gtk_text_buffer_get_selection_bound($!tb);
  }

  multi method get_selection_bounds (
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_get_selection_bounds($!tb, $start, $end);
  }

  method get_slice (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $include_hidden_chars   # gboolean $include_hidden_chars
  ) {
    my gboolean $ih = self.RESOLVE-BOOL($include_hidden_chars);
    gtk_text_buffer_get_slice($!tb, $start, $end, $ih);
  }

  method get_start_iter (GtkTextIter $iter) {
    gtk_text_buffer_get_start_iter($!tb, $iter);
  }

  method get_tag_table {
    gtk_text_buffer_get_tag_table($!tb);
  }

  multi method get_text (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $include_hidden_chars   # gboolean $include_hidden_chars
  ) {
    my gboolean $ih = self.RESOLVE-BOOL($include_hidden_chars);
    gtk_text_buffer_get_text($!tb, $start, $end, $ih);
  }

  method get_type {
    gtk_text_buffer_get_type();
  }

  multi method insert (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len                    # gint $len
  ) {
    my gint $l = self.RESOLVE-INT($len);
    gtk_text_buffer_insert($!tb, $iter, $text, $l);
  }

  method insert_at_cursor (
    Str() $text,
    Int() $len                    # gint $len
  ) {
    my gint $l = self.RESOLVE-INT($len);
    gtk_text_buffer_insert_at_cursor($!tb, $text, $l);
  }

  method insert_child_anchor (
    GtkTextIter() $iter,
    GtkTextChildAnchor $anchor
  ) {
    gtk_text_buffer_insert_child_anchor($!tb, $iter, $anchor);
  }

  method insert_interactive (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len,                   # gint $len,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gint $l = self.RESOLVE-INT($len);
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_insert_interactive($!tb, $iter, $text, $l, $de);
  }

  method insert_interactive_at_cursor (
    Str() $text,
    Int() $len,                   # gint $len,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gint $l = self.RESOLVE-INT($len);
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_insert_interactive_at_cursor($!tb, $text, $l, $de);
  }

  method insert_markup (
    GtkTextIter() $iter,
    Str() $markup,
    Int() $len                    # gint $len
  ) {
    my gint $l = self.RESOLVE-INT($len);
    gtk_text_buffer_insert_markup($!tb, $iter, $markup, $l);
  }

  method insert_pixbuf (
    GtkTextIter() $iter,
    GdkPixbuf $pixbuf
  ) {
    gtk_text_buffer_insert_pixbuf($!tb, $iter, $pixbuf);
  }

  method insert_range (
    GtkTextIter() $iter,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_insert_range($!tb, $iter, $start, $end);
  }

  method insert_range_interactive (
    GtkTextIter() $iter,
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_insert_range_interactive($!tb, $iter, $start, $end, $de);
  }

  method move_mark (
    GtkTextMark() $mark,
    GtkTextIter() $where
  ) {
    gtk_text_buffer_move_mark($!tb, $mark, $where);
  }

  method move_mark_by_name (Str() $name, GtkTextIter() $where) {
    gtk_text_buffer_move_mark_by_name($!tb, $name, $where);
  }

  method paste_clipboard (
    GtkClipboard() $clipboard,
    GtkTextIter() $override_location,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gboolean $de = self.RESOLVE-BOOL($default_editable);
    gtk_text_buffer_paste_clipboard($!tb, $clipboard, $override_location, $de);
  }

  method place_cursor (GtkTextIter() $where) {
    gtk_text_buffer_place_cursor($!tb, $where);
  }

  method remove_all_tags (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_text_buffer_remove_all_tags($!tb, $start, $end);
  }

  method remove_selection_clipboard (GtkClipboard() $clipboard) {
    gtk_text_buffer_remove_selection_clipboard($!tb, $clipboard);
  }

  method remove_tag (
    GtkTextTag() $tag,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_remove_tag($!tb, $tag, $start, $end);
  }

  method remove_tag_by_name (
    Str() $name,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_remove_tag_by_name($!tb, $name, $start, $end);
  }

  method select_range (GtkTextIter() $ins, GtkTextIter() $bound) {
    gtk_text_buffer_select_range($!tb, $ins, $bound);
  }

  method set_text (
    Str() $text,
    Int $len?                   # gint $len, can't use Int() since optional.
  ) {
    my gint $l = $len ?? self.RESOLVE-INT($len) !! $text.chars;
    gtk_text_buffer_set_text($!tb, $text, $l);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
