use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TextIter:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::ListData;

use GTK::Roles::Types:ver<3.0.1146>;

use Pango::Language;
use GLib::GList;
use GDK::Pixbuf;

use GTK::TextChildAnchor:ver<3.0.1146>;
use GTK::TextMark:ver<3.0.1146>;
use GTK::TextTag:ver<3.0.1146>;

use GLib::Roles::ListData;
use GLib::Roles::Implementor;

# BOXED TYPE

class GTK::TextIter:ver<3.0.1146> {
  also does GLib::Roles::Implementor;
  also does GTK::Roles::Types;

  has GtkTextIter $!ti is implementor;

  submethod BUILD ( :$textiter ) {
    $!ti = $textiter if $textiter;
  }

  method GTK::Raw::Structs::GtkTextIter
    is also<
      TextIter
      GtkTextIter
    >
  { $!ti }

  multi method new (GtkTextIter $textiter) {
    return unless $textiter;

    $textiter ?? self.bless(:$textiter) !! Nil;
  }
  multi method new {
    my $textiter = GtkTextIter.new;

    $textiter ?? self.bless(:$textiter) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method line is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_line($!ti);
      },
      STORE => sub ($, Int() $line_number is copy) {
        my gint $ln = $line_number;

        gtk_text_iter_set_line($!ti, $ln);
      }
    );
  }

  method line_index is rw is also<line-index> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_line_index($!ti);
      },
      STORE => sub ($, Int() $byte_on_line is copy) {
        my gint $b = $byte_on_line;

        gtk_text_iter_set_line_index($!ti, $b);
      }
    );
  }

  method line_offset is rw is also<line-offset> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_line_offset($!ti);
      },
      STORE => sub ($, int() $char_on_line is copy) {
        my gint $c = $char_on_line;

        gtk_text_iter_set_line_offset($!ti, $c);
      }
    );
  }

  method offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_offset($!ti);
      },
      STORE => sub ($, Int() $char_offset is copy) {
        my gint $c = $char_offset;

        gtk_text_iter_set_offset($!ti, $c);
      }
    );
  }

  method visible_line_index is rw is also<visible-line-index> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_visible_line_index($!ti);
      },
      STORE => sub ($, Int() $byte_on_line is copy) {
        my gint $b = $byte_on_line;

        gtk_text_iter_set_visible_line_index($!ti, $b);
      }
    );
  }

  method visible_line_offset is rw is also<visible-line-offset> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_iter_get_visible_line_offset($!ti);
      },
      STORE => sub ($, Int() $char_on_line is copy) {
        my gint $c = $char_on_line;

        gtk_text_iter_set_visible_line_offset($!ti, $c);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method assign (GtkTextIter() $other) {
    gtk_text_iter_assign($!ti, $other);
  }

  method backward_char is also<backward-char> {
    so gtk_text_iter_backward_char($!ti);
  }

  method backward_chars (Int() $count) is also<backward-chars> {
    my $c = $count;

    so gtk_text_iter_backward_chars($!ti, $c);
  }

  method backward_cursor_position is also<backward-cursor-position> {
    so gtk_text_iter_backward_cursor_position($!ti);
  }

  method backward_cursor_positions (Int() $count)
    is also<backward-cursor-positions>
  {
    my gint $c = $count;

    so gtk_text_iter_backward_cursor_positions($!ti, $c);
  }

  multi method backward_find_char (
    &pred,                 # Function Pointer
    gpointer $user_data  = Pointer,
    GtkTextIter $limit = GtkTextIter
  )
    is also<backward-find-char>
  {
    so gtk_text_iter_backward_find_char($!ti, &pred, $user_data, $limit);
  }

  method backward_line is also<backward-line> {
    so gtk_text_iter_backward_line($!ti);
  }

  method backward_lines (Int() $count) is also<backward-lines> {
    my gint $c = $count;

    so gtk_text_iter_backward_lines($!ti, $c);
  }

  method backward_search (
    Str() $str,
    Int() $flags,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    GtkTextIter() $limit
  )
    is also<backward-search>
  {
    my guint $f = $flags;

    so gtk_text_iter_backward_search(
      $!ti,
      $str,
      $f,
      $match_start,
      $match_end,
      $limit
    );
  }

  method backward_sentence_start is also<backward-sentence-start> {
    so gtk_text_iter_backward_sentence_start($!ti);
  }

  method backward_sentence_starts (Int() $count)
    is also<backward-sentence-starts>
  {
    my gint $c = $count;

    so gtk_text_iter_backward_sentence_starts($!ti, $c);
  }

  method backward_to_tag_toggle (GtkTextTag() $tag)
    is also<backward-to-tag-toggle>
  {
    so gtk_text_iter_backward_to_tag_toggle($!ti, $tag);
  }

  method backward_visible_cursor_position
    is also<backward-visible-cursor-position>
  {
    so gtk_text_iter_backward_visible_cursor_position($!ti);
  }

  method backward_visible_cursor_positions (Int() $count)
    is also<backward-visible-cursor-positions>
  {
    my gint $c = $count;

    so gtk_text_iter_backward_visible_cursor_positions($!ti, $c);
  }

  method backward_visible_line is also<backward-visible-line> {
    so gtk_text_iter_backward_visible_line($!ti);
  }

  method backward_visible_lines (Int() $count)
    is also<backward-visible-lines>
  {
    my gint $c = $count;

    so gtk_text_iter_backward_visible_lines($!ti, $c);
  }

  method backward_visible_word_start is also<backward-visible-word-start> {
    so gtk_text_iter_backward_visible_word_start($!ti);
  }

  method backward_visible_word_starts (Int() $count)
    is also<backward-visible-word-starts>
  {
    my gint $c = $count;

    so gtk_text_iter_backward_visible_word_starts($!ti, $c);
  }

  method backward_word_start is also<backward-word-start> {
    so gtk_text_iter_backward_word_start($!ti);
  }

  method backward_word_starts (Int() $count) is also<backward-word-starts> {
    my gint $c = $count;

    so gtk_text_iter_backward_word_starts($!ti, $c);
  }

  method begins_tag (GtkTextTag() $tag) is also<begins-tag> {
    so gtk_text_iter_begins_tag($!ti, $tag);
  }

  method can_insert (Int() $default_editability) is also<can-insert> {
    my gboolean $de = $default_editability.so.Int;

    so gtk_text_iter_can_insert($!ti, $de);
  }

  method compare (GtkTextIter() $rhs) {
    gtk_text_iter_compare($!ti, $rhs);
  }

  method copy (:$raw = False) {
    my $ti = gtk_text_iter_copy($!ti);

    $ti ??
      ( $raw ?? $ti !! GTK::TextIter.new($ti) )
      !!
      Nil;
  }

  method editable (Int() $default_setting) {
    my gboolean $ds = $default_setting.so.Int;

    so gtk_text_iter_editable($!ti, $ds);
  }

  method ends_line is also<ends-line> {
    so gtk_text_iter_ends_line($!ti);
  }

  method ends_sentence is also<ends-sentence> {
    so gtk_text_iter_ends_sentence($!ti);
  }

  method ends_tag (GtkTextTag() $tag) is also<ends-tag> {
    so gtk_text_iter_ends_tag($!ti, $tag);
  }

  method ends_word is also<ends-word> {
    so gtk_text_iter_ends_word($!ti);
  }

  method equal (GtkTextIter() $rhs) {
    so gtk_text_iter_equal($!ti, $rhs);
  }

  method forward_char is also<forward-char> {
    so gtk_text_iter_forward_char($!ti);
  }

  method forward_chars (Int() $count) is also<forward-chars> {
    my gint $c = $count;

    so gtk_text_iter_forward_chars($!ti, $c);
  }

  method forward_cursor_position is also<forward-cursor-position> {
    so gtk_text_iter_forward_cursor_position($!ti);
  }

  method forward_cursor_positions (Int() $count)
    is also<forward-cursor-positions>
  {
    my gint $c = $count;

    so gtk_text_iter_forward_cursor_positions($!ti, $c);
  }

  multi method forward_find_char (
    &pred,               # Function Pointer
    gpointer $user_data = Pointer,
    GtkTextIter() $limit = GtkTextIter
  ) {
    so gtk_text_iter_forward_find_char($!ti, &pred, $user_data, $limit);
  }

  method forward_line is also<forward-line> {
    so gtk_text_iter_forward_line($!ti);
  }

  method forward_lines (Int() $count) is also<forward-lines> {
    my gint $c = $count;

    so gtk_text_iter_forward_lines($!ti, $c);
  }

  method forward_search (
    Str() $str,
    Int() $flags,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    GtkTextIter() $limit
  )
    is also<forward-search>
  {
    my $f = $flags;

    so gtk_text_iter_forward_search(
      $!ti,
      $str,
      $f,
      $match_start,
      $match_end,
      $limit
    );
  }

  method forward_sentence_end is also<forward-sentence-end> {
    so gtk_text_iter_forward_sentence_end($!ti);
  }

  method forward_sentence_ends (Int() $count)
    is also<forward-sentence-ends>
  {
    my gint $c = $count;

    so gtk_text_iter_forward_sentence_ends($!ti, $c);
  }

  method forward_to_end () is also<forward-to-end> {
    so gtk_text_iter_forward_to_end($!ti);
  }

  method forward_to_line_end is also<forward-to-line-end> {
    so gtk_text_iter_forward_to_line_end($!ti);
  }

  method forward_to_tag_toggle (GtkTextTag() $tag)
    is also<forward-to-tag-toggle>
  {
    so gtk_text_iter_forward_to_tag_toggle($!ti, $tag);
  }

  method forward_visible_cursor_position
    is also<forward-visible-cursor-position>
  {
    so gtk_text_iter_forward_visible_cursor_position($!ti);
  }

  method forward_visible_cursor_positions (Int() $count)
    is also<forward-visible-cursor-positions>
  {
    my gint $c = $count;

    so gtk_text_iter_forward_visible_cursor_positions($!ti, $c);
  }

  method forward_visible_line is also<forward-visible-line> {
    so gtk_text_iter_forward_visible_line($!ti);
  }

  method forward_visible_lines (Int() $count)
    is also<forward-visible-lines>
  {
    my gint $c = $count;

    so gtk_text_iter_forward_visible_lines($!ti, $c);
  }

  method forward_visible_word_end is also<forward-visible-word-end> {
    so gtk_text_iter_forward_visible_word_end($!ti);
  }

  method forward_visible_word_ends (Int() $count)
    is also<forward-visible-word-ends>
  {
    my gint $c = $count;

    so gtk_text_iter_forward_visible_word_ends($!ti, $c);
  }

  method forward_word_end is also<forward-word-end> {
    so gtk_text_iter_forward_word_end($!ti);
  }

  method forward_word_ends (Int() $count) is also<forward-word-ends> {
    my gint $c = $count;

    so gtk_text_iter_forward_word_ends($!ti, $c);
  }

  method free {
    gtk_text_iter_free($!ti);
  }

  proto method get_attributes (|)
    is also<get-attributes>
  { * }

  multi method get_attributes {
    my $v = GtkTextAttributes.new;
    callwith($v);
    $v;
  }
  multi method get_attributes (GtkTextAttributes $values) {
    so gtk_text_iter_get_attributes($!ti, $values);
  }

  method get_buffer ( :$raw = False )
    is also<
      get-buffer
      buffer
    >
  {
    # Late binding to prevent circular dependency.
    my $b = gtk_text_iter_get_buffer($!ti);

    $b ??
      ( $raw ?? $b !! ::('GTK::TextBuffer').new($b) )
      !!
      Nil;
  }

  method get_bytes_in_line
    is also<
      get-bytes-in-line
      bytes_in_line
      bytes-in-line
    >
  {
    gtk_text_iter_get_bytes_in_line($!ti);
  }

  method get_char
    is also<
      get-char
      char
    >
  {
    gtk_text_iter_get_char($!ti);
  }

  method get_chars_in_line
    is also<
      get-chars-in-line
      chars_in_line
      chars-in-line
    >
  {
    gtk_text_iter_get_chars_in_line($!ti);
  }

  method get_child_anchor (:$raw = False)
    is also<
      get-child-anchor
      child_anchor
      child-anchor
    >
  {
    my $ta = gtk_text_iter_get_child_anchor($!ti);

    $ta ??
      ( $raw ?? $ta !! GTK::TextChildAnchor.new($ta) )
      !!
      Nil;
  }

  method get_language (:$raw = False)
    is also<
      get-language
      language
    >
  {
    my $l = gtk_text_iter_get_language($!ti);

    $l ??
      ( $raw ?? $l !! Pango::Language.new($l) )
      !!
      Nil;
  }

  method get_marks (:$glist = False, :$raw = False)
    is also<
      get-marks
      marks
    >
  {
    my $ll = gtk_text_iter_get_marks($!ti);

    return Nil unless $ll;
    return $ll if     $glist;

    $ll = GLib::GList.new($ll) but GLib::Roles::ListData[GtkTextMark];

    $raw ?? $ll.Array !! $ll.Array.map({ GTK::TextMark.new($_) });
  }

  method get_pixbuf (:$raw = False)
    is also<
      get-pixbuf
      pixbuf
    >
  {
    my $p = gtk_text_iter_get_pixbuf($!ti);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  proto method get_slice(|)
    is also<get-slice>
  { * }

  multi method get_slice (GTK::TextIter:U:
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_iter_get_slice($start, $end);
  }
  multi method get_slice (GtkTextIter() $end)  {
    GTK::TextIter.get_slice($!ti, $end);
  }

  method get_tags (:$glist = False, :$raw = False) is also<get-tags> {
    my $tl = gtk_text_iter_get_tags($!ti);

    return Nil unless $tl;
    return $tl if     $glist;

    $tl = GLib::GList($tl) but GLib::Roles::ListData[GtkTextTag];

    $raw ?? $tl.Array !! $tl.Array.map({ GTK::TextTag.new($_) });
  }

  proto method get_text (|)
    is also<get-text>
  { * }

  multi method get_text (GTK::TextIter:U:
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_iter_get_text($start, $end);
  }
  multi method get_text (GtkTextIter() $end)  {
    GTK::TextIter.get_text($!ti, $end);
  }

  method get_toggled_tags (Int() $toggled_on)
    is also<get-toggled-tags>
  {
    my gboolean $t = $toggled_on.so.Int;

    gtk_text_iter_get_toggled_tags($!ti, $t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_iter_get_type, $n, $t );
  }

  proto method get_visible_slice (|)
    is also<get-visible-slice>
  { * }

  multi method get_visible_slice(GTK::TextIter:U:
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_iter_get_visible_slice($start, $end);
  }
  multi method get_visible_slice (GtkTextIter() $end)  {
    GTK::TextIter.get_visible_slice($!ti, $end);
  }

  proto method get_visible_text (|)
    is also<get-visible-text>
  { * }

  multi method get_visible_text(GTK::TextIter:U:
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_iter_get_visible_text($start, $end);
  }
  multi method get_visible_text (GtkTextIter() $end) {
    GTK::TextIter.get_visible_text($!ti, $end);
  }

  method has_tag (GtkTextTag() $tag) is also<has-tag> {
    so gtk_text_iter_has_tag($!ti, $tag);
  }

  method in_range (GtkTextIter() $start, GtkTextIter() $end)
    is also<in-range>
  {
    so gtk_text_iter_in_range($!ti, $start, $end);
  }

  method inside_sentence is also<inside-sentence> {
    so gtk_text_iter_inside_sentence($!ti);
  }

  method inside_word is also<inside-word> {
    so gtk_text_iter_inside_word($!ti);
  }

  method is_cursor_position is also<is-cursor-position> {
    so gtk_text_iter_is_cursor_position($!ti);
  }

  method is_end is also<is-end> {
    so gtk_text_iter_is_end($!ti);
  }

  method is_start is also<is-start> {
    so gtk_text_iter_is_start($!ti);
  }

  method order (GtkTextIter() $second) {
    gtk_text_iter_order($!ti, $second);
  }

  method starts_line is also<starts-line> {
    so gtk_text_iter_starts_line($!ti);
  }

  method starts_sentence is also<starts-sentence> {
    so gtk_text_iter_starts_sentence($!ti);
  }

  method starts_tag (GtkTextTag() $tag) is also<starts-tag> {
    so gtk_text_iter_starts_tag($!ti, $tag);
  }

  method starts_word is also<starts-word> {
    so gtk_text_iter_starts_word($!ti);
  }

  method toggles_tag (GtkTextTag() $tag) is also<toggles-tag> {
    so gtk_text_iter_toggles_tag($!ti, $tag);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
