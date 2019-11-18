use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::TextView;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::Container;
use GTK::TextBuffer;

use GTK::Roles::Scrollable;

use GTK::Roles::Signals::TextView;

use Pango::Tabs;

our subset TextViewAncestry is export of Mu
  where GtkTextView  | GtkScrollable | ContainerAncestry;

class GTK::TextView is GTK::Container {
  also does GTK::Roles::Scrollable;
  also does GTK::Roles::Signals::TextView;

  has GtkTextView $!tv is implementor;
  has $!autoscroll;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$textview) {
    given $textview {
      when TextViewAncestry {
        self.setTextView($textview);
      }
      when GTK::TextView {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkTextView
    is also<TextView>
    { $!tv }

  method setTextView($view) {
    my $to-parent;
    $!tv = do given $view {
      when GtkTextView {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }
      when GtkScrollable {
        $!s = $_;                                   # GTK::Roles::Scrollable
        $to-parent = nativecast(GtkContainer, $_);
        nativecast(GtkTextView, $_);
      }
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkTextView, $_);
      }
    }
    $!s //= nativecast(GtkScrollable, $view);   # GTK::Roles::Scrollable
    self.setContainer($to-parent);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-tv;
  }

  multi method new (TextViewAncestry $textview) {
    my $o = self.bless(:$textview);
    $o.upref;
    $o;
  }
  # Should probably be doing this for ALL objects!
  multi method new (GtkTextBuffer() $buffer) {
    GTK::TextView.new_with_buffer($buffer);
  }
  multi method new {
    my $textview = gtk_text_view_new();
    self.bless(:$textview);
  }

  method new_with_buffer (GtkTextBuffer() $buffer)
    is also<new-with-buffer>
  {
    my $textview = gtk_text_view_new_with_buffer($buffer);
    self.bless(:$textview);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextView, gpointer --> void
  method backspace {
    self.connect($!tv, 'backspace');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method copy-clipboard is also<copy_clipboard> {
    self.connect($!tv, 'copy-clipboard');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method cut-clipboard is also<cut_clipboard> {
    self.connect($!tv, 'cut-clipboard');
  }

  # Is originally:
  # GtkTextView, GtkDeleteType, gint, gpointer --> void
  method delete-from-cursor is also<delete_from_cursor> {
    self.connect-delete($!tv, 'delete-from-cursor');
  }

  # Is originally:
  # GtkTextView, GtkTextExtendSelection, GtkTextIter, GtkTextIter, GtkTextIter, gpointer --> gboolean
  method extend-selection is also<extend_selection> {
    self.connect-extend-selection($!tv);
  }

  # Is originally:
  # GtkTextView, gchar, gpointer --> void
  method insert-at-cursor is also<insert_at_cursor> {
    self.connect-string($!tv, 'insert-at-cursor');
  }

  # Is originally:
  # GtkTextView, GtkMovementStep, gint, gboolean, gpointer --> void
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor2($!tv, 'move-cursor');
  }

  # Is originally:
  # GtkTextView, GtkScrollStep, gint, gpointer --> void
  method move-viewport is also<move_viewport> {
    # Yes, this is the correct handler.
    self.connect-move-cursor1($!tv, 'move-viewport');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method paste-clipboard is also<paste_clipboard> {
    self.connect($!tv, 'paste-clipboard');
  }

  # Is originally:
  # GtkTextView, GtkWidget, gpointer --> void
  method populate-popup is also<populate_popup> {
    self.connect-widget($!tv, 'populate-popup');
  }

  # Is originally:
  # GtkTextView, gchar, gpointer --> void
  method preedit-changed is also<preedit_changed> {
    self.connect-string($!tv, 'preedit-changed');
  }

  # Is originally:
  # GtkTextView, gboolean, gpointer --> void
  method select-all is also<select_all> {
    self.connect-uint($!tv, 'select-all');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method set-anchor is also<set_anchor> {
    self.connect($!tv, 'set-anchor');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method toggle-cursor-visible is also<toggle_cursor_visible> {
    self.connect($!tv, 'toggle-cursor-visible');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method toggle-overwrite is also<toggle_overwrite> {
    self.connect($!tv, 'toggle-overwrite');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accepts_tab is rw is also<accepts-tab> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_text_view_get_accepts_tab($!tv);
      },
      STORE => sub ($, Int() $accepts_tab is copy) {
        my gboolean $at = self.RESOLVE-BOOL($accepts_tab);
        gtk_text_view_set_accepts_tab($!tv, $at);
      }
    );
  }

  method bottom_margin is rw is also<bottom-margin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_bottom_margin($!tv);
      },
      STORE => sub ($, Int() $bottom_margin is copy) {
        my gint $bm = self.RESOLVE-INT($bottom_margin);
        gtk_text_view_set_bottom_margin($!tv, $bm);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::TextBuffer.new( gtk_text_view_get_buffer($!tv) );
      },
      STORE => sub ($, GtkTextBuffer() $buffer is copy) {
        gtk_text_view_set_buffer($!tv, $buffer);
      }
    );
  }

  method cursor_visible is rw is also<cursor-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_text_view_get_cursor_visible($!tv);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_text_view_set_cursor_visible($!tv, $s);
      }
    );
  }

  method editable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_text_view_get_editable($!tv);
      },
      STORE => sub ($, $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_text_view_set_editable($!tv, $s);
      }
    );
  }

  method indent is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_indent($!tv);
      },
      STORE => sub ($, Int() $indent is copy) {
        my $i = self.RESOLVE-INT($indent);
        gtk_text_view_set_indent($!tv, $i);
      }
    );
  }

  method input_hints is rw is also<input-hints> {
    Proxy.new(
      FETCH => sub ($) {
        GtkInputHints( gtk_text_view_get_input_hints($!tv) );
      },
      STORE => sub ($, Int() $hints is copy) {
        my uint32 $h = self.RESOLVE-UINT($hints);
        gtk_text_view_set_input_hints($!tv, $h);
      }
    );
  }

  method input_purpose is rw is also<input-purpose> {
    Proxy.new(
      FETCH => sub ($) {
        GtkInputPurpose( gtk_text_view_get_input_purpose($!tv) );
      },
      STORE => sub ($, Int() $purpose is copy) {
        my uint32 $p = self.RESOLVE-UINT($purpose);
        gtk_text_view_set_input_purpose($!tv, $p);
      }
    );
  }

  method justification is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkJustification( gtk_text_view_get_justification($!tv) );
      },
      STORE => sub ($, Int() $justification is copy) {
        my uint32 $j = self.RESOLVE-UINT($justification);
        gtk_text_view_set_justification($!tv, $j);
      }
    );
  }

  method left_margin is rw is also<left-margin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_left_margin($!tv);
      },
      STORE => sub ($, Int() $left_margin is copy) {
        my gint $lm = self.RESOLVE-INT($left_margin);
        gtk_text_view_set_left_margin($!tv, $lm);
      }
    );
  }

  method monospace is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_text_view_get_monospace($!tv);
      },
      STORE => sub ($, Int() $monospace is copy) {
        my gboolean $m = self.RESOLVE-BOOL($monospace);
        gtk_text_view_set_monospace($!tv, $m);
      }
    );
  }

  method overwrite is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_overwrite($!tv) ?? True !! False;
      },
      STORE => sub ($, Int() $overwrite is copy) {
        my gboolean $o = self.RESOLVE-BOOL($overwrite);
        gtk_text_view_set_overwrite($!tv, $o);
      }
    );
  }

  method pixels_above_lines is rw is also<pixels-above-lines> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_above_lines($!tv);
      },
      STORE => sub ($, Int() $pixels_above_lines is copy) {
        my gint $pal = self.RESOLVE-INT($pixels_above_lines);
        gtk_text_view_set_pixels_above_lines($!tv, $pal);
      }
    );
  }

  method pixels_below_lines is rw is also<pixels-below-lines> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_below_lines($!tv);
      },
      STORE => sub ($, Int() $pixels_below_lines is copy) {
        my gint $pbl = self.RESOLVE-INT($pixels_below_lines);
        gtk_text_view_set_pixels_below_lines($!tv, $pbl);
      }
    );
  }

  method pixels_inside_wrap is rw is also<pixels-inside-wrap> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_inside_wrap($!tv);
      },
      STORE => sub ($, Int() $pixels_inside_wrap is copy) {
        my gint $piw = self.RESOLVE-INT($pixels_inside_wrap);
        gtk_text_view_set_pixels_inside_wrap($!tv, $piw);
      }
    );
  }

  method right_margin is rw is also<right-margin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_right_margin($!tv);
      },
      STORE => sub ($, Int() $right_margin is copy) {
        my gint $rm = self.RESOLVE-INT($right_margin);
        gtk_text_view_set_right_margin($!tv, $rm);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::Tabs.new( gtk_text_view_get_tabs($!tv) );
      },
      STORE => sub ($, PangoTabArray() $tabs is copy) {
        gtk_text_view_set_tabs($!tv, $tabs);
      }
    );
  }

  method top_margin is rw is also<top-margin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_top_margin($!tv);
      },
      STORE => sub ($, Int() $top_margin is copy) {
        my gint $tm = self.RESOLVE-INT($top_margin);
        gtk_text_view_set_top_margin($!tv, $tm);
      }
    );
  }

  method wrap_mode is rw is also<wrap-mode wrap> {
    Proxy.new(
      FETCH => sub ($) {
        GtkWrapMode( gtk_text_view_get_wrap_mode($!tv) );
      },
      STORE => sub ($, Int() $wrap_mode is copy) {
        my uint32 $wm = self.RESOLVE-UINT($wrap_mode);
        gtk_text_view_set_wrap_mode($!tv, $wm);
      }
    );
  }

  # Custom convenience method.
  method text is rw {
    Proxy.new(
      FETCH => -> $ {
        my $tb = self.buffer;
        my ($s, $e) = $tb.get_bounds;
        $tb.get_text($s, $e, False);
      },
      STORE => -> $, Str() $t {
        my $tb = self.buffer;
        $tb.set_text($t);
      }
    );
  }

  # Super convenience.
  # See https://stackoverflow.com/questions/14770018/scroll-to-end-of-scrolledwindow-textview
  method autoscroll is rw {
    state $tap;
    Proxy.new(
      FETCH => -> $ { $!autoscroll // False },
      STORE => -> $, Int() $as {
        $!autoscroll = $as.so;
        if $!autoscroll {
          $tap = self.size-allocate.tap({
            .value = .upper - .page_size given self.vadjustment;
          });
        } else {
          $tap.close;
          $tap = Nil;
        }
      }
    )
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method add_child_in_window (
    GtkWidget() $child,
    Int()       $which_window,
    Int()       $xpos,
    Int()       $ypos
  )
    is also<add-child-in-window>
  {
    my guint $ww = self.RESOLVE-UINT($which_window);
    my @i = ($xpos, $ypos);
    my gint ($xp, $yp) = self.RESOLVE-INT(@i);
    gtk_text_view_add_child_in_window($!tv, $child, $ww, $xp, $yp);
  }

  method move_child (
    GtkWidget() $child,
    Int()       $xpos,
    Int()       $ypos
  )
    is also<move-child>
  {
    my @i = ($xpos, $ypos);
    my gint ($xp, $yp) = self.RESOLVE-INT(@i);
    gtk_text_view_add_child_in_window($!tv, $child, $xp, $yp);
  }

  method add_child_at_anchor (
    GtkWidget() $child,
    GtkTextChildAnchor() $anchor
  )
    is also<add-child-at-anchor>
  {
    gtk_text_view_add_child_at_anchor($!tv, $child, $anchor);
  }

  method backward_display_line (GtkTextIter() $iter)
    is also<backward-display-line>
  {
    gtk_text_view_backward_display_line($!tv, $iter);
  }

  method backward_display_line_start (GtkTextIter() $iter)
    is also<backward-display-line-start>
  {
    gtk_text_view_backward_display_line_start($!tv, $iter);
  }

  method buffer_to_window_coords (
    Int() $win,               # GtkTextWindowType $win,
    Int() $buffer_x,
    Int() $buffer_y,
    Int() $window_x,
    Int() $window_y
  )
    is also<buffer-to-window-coords>
  {
    my @u = ($buffer_x, $buffer_y, $window_x, $window_y);
    my gint ($bx, $by,$wx, $wy) = self.RESOLVE-INT(@u);
    my uint32 $w = self.RESOLVE-UINT($win);
    gtk_text_view_buffer_to_window_coords($!tv, $w, $bx, $by, $wx, $wy);
  }

  method forward_display_line (GtkTextIter() $iter)
    is also<forward-display-line>
  {
    gtk_text_view_forward_display_line($!tv, $iter);
  }

  method forward_display_line_end (GtkTextIter() $iter)
    is also<forward-display-line-end>
  {
    gtk_text_view_forward_display_line_end($!tv, $iter);
  }

  method get_border_window_size (GtkTextWindowType $type)
    is also<get-border-window-size>
  {
    gtk_text_view_get_border_window_size($!tv, $type);
  }

  method get_cursor_locations (
    GtkTextIter() $iter,
    GdkRectangle() $strong,
    GdkRectangle() $weak
  )
    is also<get-cursor-locations>
  {
    gtk_text_view_get_cursor_locations($!tv, $iter, $strong, $weak);
  }

  method get_default_attributes is also<get-default-attributes> {
    gtk_text_view_get_default_attributes($!tv);
  }

  method get_hadjustment is also<get-hadjustment> {
    gtk_text_view_get_hadjustment($!tv);
  }

  method get_iter_at_location (
    GtkTextIter() $iter,
    Int() $x,
    Int() $y
  )
    is also<get-iter-at-location>
  {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@u);
    gtk_text_view_get_iter_at_location($!tv, $iter, $xx, $yy);
  }

  method get_iter_at_position (
    GtkTextIter() $iter,
    Int() $trailing,
    Int() $x,
    Int() $y
  )
    is also<get-iter-at-position>
  {
    my @u = ($trailing, $x, $y);
    my gint ($t, $xx, $yy) = self.RESOLVE-INT(@u);
    gtk_text_view_get_iter_at_position($!tv, $iter, $t, $xx, $yy);
  }

  method get_iter_location (GtkTextIter() $iter, GdkRectangle() $location)
    is also<get-iter-location>
  {
    gtk_text_view_get_iter_location($!tv, $iter, $location);
  }

  method get_line_at_y (
    GtkTextIter() $target_iter,
    Int() $y,
    Int() $line_top
  )
    is also<get-line-at-y>
  {
    my @u = ($y, $line_top);
    my gint ($yy, $lt) = self.RESOLVE-INT(@u);
    gtk_text_view_get_line_at_y($!tv, $target_iter, $yy, $lt);
  }

  method get_line_yrange (GtkTextIter() $iter, Int() $y, Int() $height)
    is also<get-line-yrange>
  {
    my @u = ($y, $height);
    my gint ($yy, $h) = self.RESOLVE-INT(@u);
    gtk_text_view_get_line_yrange($!tv, $iter, $yy, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_text_view_get_type, $n, $t );
  }

  method get_vadjustment is also<get-vadjustment> {
    gtk_text_view_get_vadjustment($!tv);
  }

  method get_visible_rect (GdkRectangle() $visible_rect)
    is also<get-visible-rect>
  {
    gtk_text_view_get_visible_rect($!tv, $visible_rect);
  }

  method get_window (
    Int() $win                  # GtkTextWindowType $win
  )
    is also<get-window>
  {
    my uint32 $w = self.RESOLVE-UINT($win);
    gtk_text_view_get_window($!tv, $w);
  }

  method get_window_type (GdkWindow $window) is also<get-window-type> {
    gtk_text_view_get_window_type($!tv, $window);
  }

  method im_context_filter_keypress (GdkEventKey $event)
    is also<im-context-filter-keypress>
  {
    gtk_text_view_im_context_filter_keypress($!tv, $event);
  }

  method move_mark_onscreen (GtkTextMark() $mark)
    is also<move-mark-onscreen>
  {
    gtk_text_view_move_mark_onscreen($!tv, $mark);
  }

  method move_visually (GtkTextIter() $iter, Int() $count)
    is also<move-visually>
  {
    my gint $c = self.RESOLVE-INT($count);
    gtk_text_view_move_visually($!tv, $iter, $c);
  }

  method place_cursor_onscreen is also<place-cursor-onscreen> {
    gtk_text_view_place_cursor_onscreen($!tv);
  }

  method reset_cursor_blink is also<reset-cursor-blink> {
    gtk_text_view_reset_cursor_blink($!tv);
  }

  method reset_im_context is also<reset-im-context> {
    gtk_text_view_reset_im_context($!tv);
  }

  method scroll_mark_onscreen (GtkTextMark() $mark)
    is also<scroll-mark-onscreen>
  {
    gtk_text_view_scroll_mark_onscreen($!tv, $mark);
  }

  method scroll_to_iter (
    GtkTextIter() $iter,
    Num()  $within_margin,
    Int() $use_align,
    Num()  $xalign,
    Num()  $yalign
  )
    is also<scroll-to-iter>
  {
    my gdouble ($wm, $xa, $ya) = ($within_margin, $xalign, $yalign);
    my gboolean $ua = $use_align.Int;
    gtk_text_view_scroll_to_iter($!tv, $iter, $wm, $ua, $xa, $ya);
  }

  # Convenience.
  method scroll_to_top is also<scroll-to-top> {
    self.scroll_to_iter(self.buffer.get_start_iter, 0, True, 0, 0);
  }

  # Convenience.
  method scroll_to_bottom is also<scroll-to-bottom> {
    self.scroll_to_iter(self.buffer.get_end_iter, 0, True, 0, 1);
  }

  method scroll_to_mark (
    GtkTextMark() $mark,
    Num() $within_margin,
    Int() $use_align,
    Num() $xalign,
    Num() $yalign
  )
    is also<scroll-to-mark>
  {
    my gdouble ($wm, $xa, $ya) = ($within_margin, $xalign, $yalign);
    # Was it really this simple?
    my gboolean $ua = $use_align.Int;
    gtk_text_view_scroll_to_mark($!tv, $mark, $wm, $ua, $xa, $ya);
  }

  method set_border_window_size (
    Int() $type,                # GtkTextWindowType $type,
    Int() $size                 # gint $size
  )
    is also<set-border-window-size>
  {
    my uint32 $t = self.RESOLVE-UINT($type);
    my gint $s = self.RESOLVE-INT($size);
    gtk_text_view_set_border_window_size($!tv, $t, $s);
  }

  method starts_display_line (GtkTextIter() $iter)
    is also<starts-display-line>
  {
    gtk_text_view_starts_display_line($!tv, $iter);
  }

  method window_to_buffer_coords (
    Int() $win,                # GtkTextWindowType $win,
    Int() $window_x,
    Int() $window_y,
    Int() $buffer_x,
    Int() $buffer_y
  )
    is also<window-to-buffer-coords>
  {
    my @u = ($window_x, $window_y, $buffer_x, $buffer_y);
    my gint ($wx, $wy, $bx, $by) = self.RESOLVE-INT(@u);
    my uint32 $w = self.RESOLVE-UINT($win);
    gtk_text_view_window_to_buffer_coords($!tv, $w, $wx, $wy, $bx, $by);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
