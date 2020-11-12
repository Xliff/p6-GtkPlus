use v6.c;

use Method::Also;

use GTK::Raw::TextBuffer;
use GTK::Raw::Types;

use GLib::Value;
use GTK::TargetList;
use GTK::TextIter;
use GTK::TextMark;
use GTK::TextTagTable;

use GLib::Roles::Object;
use GTK::Roles::Signals::TextBuffer;

class GTK::TextBuffer {
  also does GLib::Roles::Object;
  also does GTK::Roles::Signals::TextBuffer;

  has GtkTextBuffer $!tb is implementor;

  submethod BUILD(:$buffer) {
    self.setTextBuffer($buffer) if $buffer;
  }

  method setTextBuffer($buffer) {
    self!setObject($!tb = $buffer);             # GLib::Roles::Properties
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-tb;
  }

  method GTK::Raw::Definitions::GtkTextBuffer
    is also<
      TextBuffer
      GtkTextBuffer
    >
  { $!tb }

  multi method new (GtkTextTagTable() $text_tag_table) {
    my $buffer = gtk_text_buffer_new($text_tag_table);

    $buffer ?? self.bless(:$buffer) !! Nil;
  }
  multi method new (GtkTextBuffer $buffer) {
    $buffer ?? self.bless(:$buffer) !! Nil;
  }
  multi method new {
    my $buffer = gtk_text_buffer_new(GtkTextTagTable);

    $buffer ?? self.bless(:$buffer) !! Nil;
  }

  method !resolve-text-arg($val is copy) {
    # First check if object can be coerced, then coerce it to a supported
    # type
    if $val.^can('Buf').elems {
      $val .= Buf;
    } elsif $val.^can('Str').elems {
      $val .= Str;
    }
    do given $val {
      when Buf { .decode }
      when Str { $_      }

      default {
        die qq:to/D/.chomp;
GTK::TextBuffer does not know how to handle { .^name }, when setting text
D

      }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  proto method apply_tag (|)
    is also<apply-tag>
  { * }

  # Is originally:
  # GtkTextBuffer, GtkTextTag, GtkTextIter, GtkTextIter, gpointer --> void
  multi method apply_tag {
    self.connect-tag($!tb, 'apply-tag');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method begin-user-action is also<begin_user_action> {
    self.connect($!tb, 'begin-user-action');
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method changed {
    self.connect($!tb, 'changed');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextIter, gpointer --> void
  method delete-range is also<delete_range> {
    self.connect-delete-range($!tb);
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method end-user-action is also<end_user_action> {
    self.connect($!tb, 'end-user-action');
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextChildAnchor, gpointer --> void
  method insert-child-anchor is also<insert_child_anchor> {
    self.connect-insert-child-anchor($!tb);
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GdkPixbuf, gpointer --> void
  method insert-pixbuf is also<insert_pixbuf> {
    self.connect-insert-pixbuf($!tb);
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, gchar, gint, gpointer --> void
  method insert-text is also<insert_text> {
    self.connect-insert-text($!tb);
  }

  # Is originally:
  # GtkTextBuffer, GtkTextMark, gpointer --> void
  method mark-deleted is also<mark_deleted> {
    self.connect-mark-deleted($!tb);
  }

  # Is originally:
  # GtkTextBuffer, GtkTextIter, GtkTextMark, gpointer --> void
  method mark-set is also<mark_set> {
    self.connect-mark-set($!tb);
  }

  # Is originally:
  # GtkTextBuffer, gpointer --> void
  method modified-changed is also<modified_changed> {
    self.connect($!tb, 'modified-changed');
  }

  # Is originally:
  # GtkTextBuffer, GtkClipboard, gpointer --> void
  method paste-done is also<paste_done> {
    self.connect-paste-done($!tb);
  }

  # Is originally:
  # GtkTextBuffer, GtkTextTag, GtkTextIter, GtkTextIter, gpointer --> void
  method remove-tag is also<remove_tag> {
    self.connect-tag($!tb, 'remove-tag');
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

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkTargetList
  method copy-target-list (:$raw = False)
    is rw
    is also<copy_target_list>
  {
    my GLib::Value $gv .= new( GTK::TargetList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('copy-target-list', $gv)
        );

        return Nil unless $gv.boxed;

        my $tl = cast(GtkTargetList, $gv.boxed);
        $raw ?? $tl !! GTK::TargetList.new($tl);
      },
      STORE => -> $, $val is copy {
        warn 'copy-target-list does not allow writing'
      }
    );
  }

  # Type: gint
  method cursor-position
    is rw
    is also<cursor_position>
  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cursor-position', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'cursor-position does not allow writing'
      }
    );
  }

  # Type: gboolean
  method has-selection
    is rw
    is also<has_selection>
  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('has-selection', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-selection does not allow writing'
      }
    );
  }

  # Type: GtkTargetList
  method paste-target-list (:$raw = False)
    is rw
    is also<paste_target_list>
  {
    my GLib::Value $gv .= new( GTK::TargetList.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('paste-target-list', $gv)
        );

        return Nil unless $gv.boxed;

        my $tl = cast(GtkTargetList, $gv.boxed);
        $raw ?? $tl !!GTK::TargetList.new($tl);
      },
      STORE => -> $,  $val is copy {
        warn 'paste-target-list does not allow writing'
      }
    );
  }

  # Type: GtkTextTagTable
  method tag-table (:$raw = False)
    is rw
    is also<tag_table>
  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('tag-table', $gv)
        );

        return Nil unless $gv.object;

        my $ttt = cast(GtkTextTagTable, $gv.object);
        $raw ?? $ttt !!! GTK::TextTagTable.new($ttt);
      },
      STORE => -> $, GtkTextTagTable() $val is copy {
        $gv.object = $val;
        self.prop_set('tag-table', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = self!resolve-text-arg($val);
        self.prop_set('text', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_mark (
    GtkTextMark() $mark,
    GtkTextIter() $where
  )
    is also<add-mark>
  {
    gtk_text_buffer_add_mark($!tb, $mark, $where);
  }

  method add_selection_clipboard (
    GtkClipboard() $clipboard
  )
    is also<add-selection-clipboard>
  {
    gtk_text_buffer_add_selection_clipboard($!tb, $clipboard);
  }

  multi method apply_tag (GtkTextTag() $tag) {
    samewith($tag, |self.get-bounds);
  }
  multi method apply_tag (
    GtkTextTag() $tag,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_apply_tag($!tb, $tag, $start, $end);
  }

  proto method apply_tag_by_name (|)
    is also<apply-tag-by-name>
  { * }

  multi method apply_tag_by_name (Str() $name) {
    samewith($name, |self.get-bounds);
  }
  multi method apply_tag_by_name (
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
    my gboolean ($i, $de) = ($interactive, $default_editable).map( *.so.Int );

    gtk_text_buffer_backspace($!tb, $iter, $i, $de);
  }

  method start_user_action is also<start-user-action> {
    gtk_text_buffer_begin_user_action($!tb);
  }

  method copy_clipboard (GtkClipboard() $clipboard)
    is also<copy-clipboard>
  {
    gtk_text_buffer_copy_clipboard($!tb, $clipboard);
  }

  method create_child_anchor (GtkTextIter() $iter)
    is also<create-child-anchor>
  {
    gtk_text_buffer_create_child_anchor($!tb, $iter);
  }

  method create_mark (
    Str()         $mark_name,
    GtkTextIter() $where,
    Int()         $left_gravity,           # gboolean $left_gravity
                  :$raw = False
  )
    is also<create-mark>
  {
    my gboolean $lg = $left_gravity.so.Int;
    my $tm = gtk_text_buffer_create_mark($!tb, $mark_name, $where, $lg);

    $tm ??
      ( $raw ?? $tm !! GTK::TextMark.new($tm) )
      !!
      Nil;
  }

  # method create_tag omitted due to '...' parameter.

  method cut_clipboard (
    GtkClipboard() $clipboard,
    Int() $default_editable       # gboolean $default_editable
  )
    is also<cut-clipboard>
  {
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_cut_clipboard($!tb, $clipboard, $de);
  }

  multi method delete {
    samewith(|self.get-bounds);
  }
  multi method delete (
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_delete($!tb, $start, $end);
  }

  proto method delete_interactive (|)
    is also<delete-interactive>
  { * }

  multi method delete_interactive (Int() $default_editable) {
    samewith(|self.get-bounds, $default_editable);
  }
  multi method delete_interactive (
    GtkTextIter() $start_iter,
    GtkTextIter() $end_iter,
    Int() $default_editable       # gboolean $default_editable
  ) {
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_delete_interactive($!tb, $start_iter, $end_iter, $de);
  }

  method delete_mark (GtkTextMark() $mark)
    is also<delete-mark>
  {
    gtk_text_buffer_delete_mark($!tb, $mark);
  }

  method delete_mark_by_name (Str() $name)
    is also<delete-mark-by-name>
  {
    gtk_text_buffer_delete_mark_by_name($!tb, $name);
  }

  method delete_selection (
    Int() $interactive,           # gboolean $interactive,
    Int() $default_editable       # gboolean $default_editable
  )
    is also<delete-selection>
  {
    my gboolean ($i, $de) = ($interactive, $default_editable);

    gtk_text_buffer_delete_selection($!tb, $i, $de);
  }

  method finish_user_action is also<finish-user-action> {
    gtk_text_buffer_end_user_action($!tb);
  }

  method !resolve-iter($iter) {
    if $iter {
      die 'Invalid type!' unless
        ($*i = $iter) ~~ (GTK::TextIter, GtkTextIter).any;

      $*i .= GtkTextIter if $*i ~~ GTK::TextIter;
    } else {
      $*i = GtkTextIter.new;

      die 'Could not allocate a new GtkTextIter!' unless $*i;
    }
    $*i;
  }

  method !handle-iter-return($iter, $raw) {
    do if $iter {
      # Tricky assed logic!
      $iter ~~ GTK::TextIter
        ?? ( $raw ?? $*i !! $iter )
        !! ( $raw ?? $*i !! GTK::TextIter.new($*i) )
    } else {
      $raw ?? $*i !! GTK::TextIter.new($*i)
    }
  }

  # cw: Has a proto been attempted for this, yet?
  proto method get_bounds (|)
    is also<get-bounds>
  { * }

  multi method get_bounds (:$raw = False) {
    samewith($, $, :$raw);
  }
  multi method get_bounds (
    $start is rw,
    $end is rw,
    :$raw = False;
  ) {
    my $*i;

    my ($s, $e) = (
      self!resolve-iter($start),
      self!resolve-iter($end)
    );

    gtk_text_buffer_get_bounds($!tb, $s, $e);

    (
      do { $*i = $s; self!handle-iter-return($start, $raw) },
      do { $*i = $e; self!handle-iter-return($end, $raw)   }
    )
  }

  # method get_bounds_p? -- So that we don't have to create objects to get
  # the pointers, to then dispose of the objects...

  method get_char_count
    is also<
      get-char-count
      char_count
      char-count
    >
  {
    gtk_text_buffer_get_char_count($!tb);
  }

  method get_copy_target_list (:$raw = False) is also<get-copy-target-list> {
    my $tl = gtk_text_buffer_get_copy_target_list($!tb);

    $tl ??
      ( $raw ?? $tl !! GTK::TargetList.new($tl) )
      !!
      Nil;
  }

  proto method get_end_iter (|)
    is also<
      get-end-iter
      end_iter
      end-iter
      end
    >
  { * }

  multi method get_end_iter (:$raw = False) {
    samewith($, :$raw);
  }
  multi method get_end_iter ($iter is rw, :$raw = False) {
    $iter = GtkTextIter.new unless $iter ~~ GtkTextIter;

    die 'Cannot allocate GtkTextIter!' unless $iter;

    gtk_text_buffer_get_end_iter($!tb, $iter);

    $raw ?? $iter !! GTK::TextIter.new($iter);
  }

  method get_has_selection is also<get-has-selection> {
    so gtk_text_buffer_get_has_selection($!tb);
  }

  method get_insert (:$raw = False) is also<get-insert> {
    my $tm = gtk_text_buffer_get_insert($!tb);

    $tm ??
      ( $raw ?? $tm !! GTK::TextMark.new($tm) )
      !!
      Nil;
  }

  proto method get_iter_at_child_anchor (|)
    is also<get-iter-at-child-anchor>
  { * }

  multi method get_iter_at_child_anchor (
    GtkTextChildAnchor() $anchor,
    :$raw = False
  ) {
    samewith($, $anchor, :$raw);
  }
  multi method get_iter_at_child_anchor (
    $iter,
    GtkTextChildAnchor() $anchor,
    :$raw = False;
  ) {
    my $*i;

    gtk_text_buffer_get_iter_at_child_anchor(
      $!tb,
      self!resolve-iter($iter),
      $anchor
    );
    self!handle-iter-return($iter, $raw);
  }

  proto method get_iter_at_line (|)
    is also<get-iter-at-line>
  { * }

  multi method get_iter_at_line (Int() $line_number, :$raw = False) {
    samewith($, $line_number, :$raw);
  }
  multi method get_iter_at_line (
    $iter,
    Int() $line_number,            # gint $line_number
    :$raw = False;
  ) {
    my gint $ln = $line_number;
    my $*i;

    # So what to do if $iter is a GTK::TextIter, or a GtkTextIter?
    # How do we handle the return value. Do we try to return the inbound
    # object or create a new one?

    # For now, we just blow whatever we had away (again... OBJECT?!)
    # and see how that affects the existing test cases. This will more than
    # likely be revisited in the very near future.

    gtk_text_buffer_get_iter_at_line($!tb, self!resolve-iter($iter), $ln);
    self!handle-iter-return($iter, $raw);
  }

  proto method get_iter_at_line_index (|)
    is also<get-iter-at-line-index>
  { * }

  multi method get_iter_at_line_index (
    Int() $line_number,           # gint $line_number,
    Int() $byte_index,            # gint $byte_index
    :$raw = False
  ) {
    samewith($, $line_number, $byte_index, :$raw);
  }
  multi method get_iter_at_line_index (
    $iter,
    Int() $line_number,           # gint $line_number,
    Int() $byte_index,            # gint $byte_index
    :$raw = False
  ) {
    my gint ($ln, $bi) = ($line_number, $byte_index);
    my $*i;

    gtk_text_buffer_get_iter_at_line_index(
      $!tb,
      self!resolve-iter($iter),
      $ln,
      $bi
    );
    self!handle-iter-return($iter, $raw);
  }

  proto method get_iter_at_line_offset (|)
    is also<get-iter-at-line-offset>
  { * }

  multi method get_iter_at_line_offset (
    Int() $line_number,           # gint $line_number,
    Int() $char_offset,           # gint $char_offset
    :$raw = False
  ) {
    samewith($, $line_number, $char_offset, :$raw);
  }
  multi method get_iter_at_line_offset (
    $iter,
    Int() $line_number,           # gint $line_number,
    Int() $char_offset,           # gint $char_offset
    :$raw = False
  ) {
    my gint ($ln, $co) = ($line_number, $char_offset);
    my $*i;

    gtk_text_buffer_get_iter_at_line_offset(
      $!tb,
      self!resolve-iter($iter),
      $ln,
      $co
    );
    self!handle-iter-return($iter, $raw);
  }

  proto method get_iter_at_mark (|)
    is also<get-iter-at-mark>
  { * }

  multi method get_iter_at_mark (GtkTextMark() $mark, :$raw = False) {
    samewith($, $mark, :$raw);
  }
  multi method get_iter_at_mark (
    $iter,
    GtkTextMark() $mark,
    :$raw = False;
  ) {
    my $*i;

    gtk_text_buffer_get_iter_at_mark(
      $!tb,
      self!resolve-iter($iter),
      $mark
    );
    self!handle-iter-return($iter);
  }

  proto method get_iter_at_offset (|)
    is also<get-iter-at-offset>
  { * }

  multi method get_iter_at_offset (
    Int() $char_offset,            # gint $char_offset
    :$raw = False
  ) {
    samewith($, $char_offset, :$raw);
  }
  multi method get_iter_at_offset (
    $iter,
    Int() $char_offset,            # gint $char_offset
    :$raw = False
  ) {
    my gint $co = $char_offset;
    my $*i;

    gtk_text_buffer_get_iter_at_offset(
      $!tb,
      self!resolve-iter($iter),
      $co
    );
    self!handle-iter-return($iter, $raw);
  }

  method get_line_count is also<get-line-count> {
    gtk_text_buffer_get_line_count($!tb);
  }

  method get_mark (Str() $name, :$raw = False) is also<get-mark> {
    my $tm = gtk_text_buffer_get_mark($!tb, $name);

    $tm ??
      ( $raw ?? $tm !! GTK::TextMark.new($tm) )
      !!
      Nil;
  }

  method get_paste_target_list (:$raw = False) is also<get-paste-target-list> {
    my $tl = gtk_text_buffer_get_paste_target_list($!tb);

    $tl ??
      ( $raw ?? $tl !! GTK::TargetList.new($tl) )
      !!
      Nil;
  }

  method get_selection_bound (:$raw = False) is also<get-selection-bound> {
    my $tm = gtk_text_buffer_get_selection_bound($!tb);

    $tm ??
      ( $raw ?? $tm !! GTK::TextMark.new($tm) )
      !!
      Nil;
  }

  proto method get_selection_bounds (|)
    is also<get-selection-bounds>
  { * }

  multi method get_selection_bounds (:$raw = False) {
    samewith($, $, :all, :$raw);
  }
  multi method get_selection_bounds (
    $start,
    $end  ,
    :$all = False,
    :$raw = False
  ) {
    my $*i;
    my ($s, $e) = (
      self!resolve-iter($start),
      self!resolve-iter($end)
    );
    my $rv = so gtk_text_buffer_get_selection_bounds($!tb, $s, $e);

    $all.not ??
      $rv
      !!
      (
        $rv,
        do { $*i = $s; self!handle-iter-return($start, $raw) },
        do { $*i = $e; self!handle-iter-return($end, $raw)   }
      )
  }

  method get_slice (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $include_hidden_chars   # gboolean $include_hidden_chars
  )
    is also<get-slice>
  {
    my gboolean $ih = $include_hidden_chars.so.Int;

    gtk_text_buffer_get_slice($!tb, $start, $end, $ih);
  }

  proto method get_start_iter (|)
    is also<
      get-start-iter
      start_iter
      start-iter
      start
    >
  { * }

  multi method get_start_iter (:$raw = False) {
    samewith($, :$raw);
  }
  multi method get_start_iter ($iter, :$raw = False) {
    my $*i;

    gtk_text_buffer_get_start_iter( $!tb, self!resolve-iter($iter) );
    self!handle-iter-return($iter, $raw)
  }

  method get_tag_table (:$raw = False) is also<get-tag-table> {
    my $tt = gtk_text_buffer_get_tag_table($!tb);

    $tt ??
      ( $raw ?? $tt !! GTK::TextTagTable.new($tt) )
      !!
      Nil;
  }

  proto method get_text (|)
    is also<get-text>
  { * }

  multi method get_text (Int() $include_hidden_chars) {
    samewith(|self.get-bounds, $include_hidden_chars);
  }
  multi method get_text (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int()         $include_hidden_chars = False   # gboolean $include_hidden_chars
  ) {
    my gboolean $ih = $include_hidden_chars.so.Int;

    gtk_text_buffer_get_text($!tb, $start, $end, $ih);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, ^gtk_text_buffer_get_type, $n, $t );
  }

  # Convenience
  multi method append (Buf $text) {
    samewith($text.encode);
  }
  multi method append (
    Str() $text,
    Int() $len = $text.chars
  ) {
    self.insert(self.get_end_iter, $text, $len);
  }

  # Convenience
  multi method prepend(Buf $text) {
    samewith($text.decode);
  }
  multi method prepend (
    Str() $text,
    Int() $len = $text.chars
  ) {
    self.insert(self.get_start_iter, $text, $len);
  }

  multi method insert (
    GtkTextIter() $iter,
    Buf $text
  ) {
    samewith($iter, $text.encode);
  }
  multi method insert (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len = $text.chars      # gint $len
  ) {
    my gint $l = $len;

    gtk_text_buffer_insert($!tb, $iter, $text, $l);
  }

  proto method insert_at_cursor (|)
    is also<insert-at-cursor>
  { * }

  multi method insert_at_cursor (Buf $text) {
    samewith($text.encode)
  }
  multi method insert_at_cursor (
    Str() $text,
    Int() $len  = $text.chars     # gint $len
  ) {
    my gint $l = $len;

    gtk_text_buffer_insert_at_cursor($!tb, $text, $l);
  }

  multi method insert_child_at_iter (
    GtkTextIter() $iter,
    GtkTextChildAnchor $anchor
  )
    is also<insert-child-at-iterr>
  {
    gtk_text_buffer_insert_child_anchor($!tb, $iter, $anchor);
  }

  proto method insert_interactive (|)
    is also<insert-interactive>
  { * }

  multi method insert_interractive (
    GtkTextIter() $iter,
    Buf $text,
    Int() $default_editable
  ) {
    my $t = $text.encode;

    samewith($iter, $t, $t.chars, $default_editable);
  }
  multi method insert_interactive (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len is copy,           # gint $len,
    Int() $default_editable       # gboolean $default_editable
  ) {
    $text = self!resolve-text-arg($text);
    $len //= $text.chars;
    my gint $l = $len;
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_insert_interactive($!tb, $iter, $text, $l, $de);
  }

  proto method insert_interractive_at_cursor (|)
    is also<insert-interactive-at-cursor>
  { * }

  multi method insert_interractive_at_cursor (
    Buf $text,
    Int() $default_editable
  ) {
    my $t = $text.encode;

    samewith($t, $t.chars, $default_editable);
  }
  multi method insert_interactive_at_cursor (
    Str() $text,
    Int() $len is copy,           # gint $len,
    Int() $default_editable       # gboolean $default_editable
  ) {
    $len //= $text.chars;
    my gint     $l  = $len;
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_insert_interactive_at_cursor($!tb, $text, $l, $de);
  }

  # Convenience method
  method append_markup (Str() $markup) is also<append-markup> {
    self.insert_markup(self.end, $markup);
  }

  proto method insert_markup(|)
    is also<insert-markup>
  { * }

  multi method insert_markup (
    GtkTextIter() $iter,
    Buf           $markup
  ) {
    my $t = $markup.decode;
    samewith($iter, $t, $t.chars);
  }
  multi method insert_markup (
    GtkTextIter() $iter,
    Str()         $markup is copy,
    Int()         $len    =  $markup.chars
  ) {
    my gint $l = $len;

    $markup = self!resolve-text-arg($markup);
    gtk_text_buffer_insert_markup($!tb, $iter, $markup, $l);
  }

  method insert_pixbuf_at_iter (
    GtkTextIter() $iter,
    GdkPixbuf $pixbuf
  )
    is also<insert-pixbuf-at-iter>
  {
    gtk_text_buffer_insert_pixbuf($!tb, $iter, $pixbuf);
  }

  # Whole-buffer multi's for insert operation don't make much sense.

  method insert_range (
    GtkTextIter() $iter,
    GtkTextIter() $start,
    GtkTextIter() $end
  )
    is also<insert-range>
  {
    gtk_text_buffer_insert_range($!tb, $iter, $start, $end);
  }

  method insert_range_interactive (
    GtkTextIter() $iter,
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $default_editable       # gboolean $default_editable
  )
    is also<insert-range-interactive>
  {
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_insert_range_interactive($!tb, $iter, $start, $end, $de);
  }

  proto method append_with_tag (|)
    is also<append-with-tag>
    { * }

  multi method append_with_tag(Buf $text, Str $tag_name) {
    samewith($text.decode, $tag_name);
  }
  multi method append_with_tag(Str() $text, Str $tag_name) {
    self.insert_with_tag_by_name(
      self.get_end_iter, $text, $text.chars, $tag_name
    )
  }
  multi method append_with_tag (Buf $text, GtkTextTag() $tag) {
    samewith($text.decode, $tag);
  }
  multi method append_with_tag (Str() $text, GtkTextTag() $tag) {
    self.insert_with_tag(self.get_end_iter, $text, $text.chars, $tag);
  }

  proto method prepend_with_tag (|)
    is also<prepend-with-tag>
  { * }

  multi method prepend_with_tag (Buf $text, Str $tag_name) {
    samewith($text.decode, $tag_name);
  }
  multi method prepend_with_tag (Str() $text, Str $tag_name) {
    self.insert_with_tag_by_name(
      self.get_start_iter, $text, $text.chars, $tag_name
    )
  }
  multi method prepend_with_tag (Buf $text, GtkTextTag() $tag) {
    samewith($text.decode, $tag);
  }
  multi method prepend_with_tag (Str() $text, GtkTextTag() $tag) {
    self.insert_with_tag(self.get_start_iter, $text, $text.chars, $tag);
  }

  proto method insert_with_tag (|)
    is also<insert-with-tag>
  { * }

  multi method insert_with_tag (
    GtkTextIter() $iter,
    Buf $text,
    GtkTextTag() $tag
  ) {
    my $t = $text.decode;

    samewith($iter, $t, $t.chars, $tag);
  }
  multi method insert_with_tag (
    GtkTextIter() $iter,
    Str $text,
    GtkTextTag() $tag
  ) {
    samewith($iter, $text, $text.chars, $tag);
  }
  multi method insert_with_tag (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len,
    GtkTextTag() $tag
  ) {
    my gint $l = $len;

    gtk_text_buffer_insert_with_tags(
      $!tb, $iter, $text, $l, $tag, GtkTextTag
    );
  }

  proto method insert_with_tag_by_name (|)
    is also<insert-with-tag-by-name>
  { * }

  multi method insert_with_tag_by_name (
    GtkTextIter() $iter,
    Buf $text,
    Str() $tag_name
  ) {
    my $t = $text.decode;

    samewith($iter, $t, $t.chars, $tag_name);
  }
  multi method insert_with_tag_by_name (
    GtkTextIter() $iter,
    Str $text,
    Str() $tag_name
  ) {
   samewith($iter, $text, $text.chars, $tag_name);
  }
  multi method insert_with_tag_by_name (
    GtkTextIter() $iter,
    Str() $text,
    Int() $len,
    Str() $tag_name,
  ) {
    my gint $l = $len;

    gtk_text_buffer_insert_with_tags_by_name (
      $!tb, $iter, $text, $l, $tag_name, Str
    );
  }

  method move_mark (
    GtkTextMark() $mark,
    GtkTextIter() $where
  )
    is also<move-mark>
  {
    gtk_text_buffer_move_mark($!tb, $mark, $where);
  }

  method move_mark_by_name (Str() $name, GtkTextIter() $where)
    is also<move-mark-by-name>
  {
    gtk_text_buffer_move_mark_by_name($!tb, $name, $where);
  }

  method paste_clipboard (
    GtkClipboard() $clipboard,
    GtkTextIter() $override_location,
    Int() $default_editable       # gboolean $default_editable
  )
    is also<paste-clipboard>
  {
    my gboolean $de = $default_editable.so.Int;

    gtk_text_buffer_paste_clipboard($!tb, $clipboard, $override_location, $de);
  }

  method place_cursor (GtkTextIter() $where)
    is also<place-cursor>
  {
    gtk_text_buffer_place_cursor($!tb, $where);
  }

  proto method remove_all_tags (|)
    is also<remove-all-tags>
    { * }

  multi method remove_all_tags {
    samewith(|self.get-bounds);
  }
  multi method remove_all_tags (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_text_buffer_remove_all_tags($!tb, $start, $end);
  }

  method remove_selection_clipboard (GtkClipboard() $clipboard)
    is also<remove-selection-clipboard>
  {
    gtk_text_buffer_remove_selection_clipboard($!tb, $clipboard);
  }

  proto method emit_remove_tag (|)
    is also<emit-remove-tag>
  { * }

  multi method emit_remove_tag (GtkTextTag $tag) {
    samewith($tag, |self.get-bounds);
  }
  multi method emit_remove_tag (
    GtkTextTag() $tag,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_remove_tag($!tb, $tag, $start, $end);
  }

  proto method remove_tag_by_name (|)
    is also<remove-tag-by-name>
  { * }

  multi method remove_tag_by_name (Str() $name) {
    samewith($name, |self.get-bounds);
  }
  multi method remove_tag_by_name (
    Str() $name,
    GtkTextIter() $start,
    GtkTextIter() $end
  ) {
    gtk_text_buffer_remove_tag_by_name($!tb, $name, $start, $end);
  }

  method select_range (GtkTextIter() $ins, GtkTextIter() $bound)
    is also<select-range>
  {
    gtk_text_buffer_select_range($!tb, $ins, $bound);
  }

  method set_text (
    $text is copy,
    Int $len? is copy
  )
    is also<set-text>
  {
    $text = self!resolve-text-arg($text);
    $len //= $text.chars;
    my gint $l = $len;

    gtk_text_buffer_set_text($!tb, $text, $l);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
