use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::;
use GTK::Raw::Types;

use GTK::Container;

class GTK::TextView is GTK::Container {
  has GtkTextView $!tv;

  submethod BUILD(:$textview) {
    given $textview {
      when GtkTextView | GtkWidget {
        $!tv = do {
          when GtkTextView { $textview; }
          when GtkWidget   { nativecast(GtkTextView, $textview); }
        }
        self.setContainer($textview);
      }
      when GTK::TextView {
      }
      default {
      }
    }
  }

  method new {
    my $textview = gtk_text_view_new();
    self.bless(:$textview);
  }

  method new_with_buffer (GtkTextBuffer $buffer) {
    my $textview = gtk_text_view_new_with_buffer($buffer);
    self.bless(:$textview);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextView, gpointer --> void
  method backspace {
    self.connect($!w, 'backspace');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method copy-clipboard {
    self.connect($!w, 'copy-clipboard');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method cut-clipboard {
    self.connect($!w, 'cut-clipboard');
  }

  # Is originally:
  # GtkTextView, GtkDeleteType, gint, gpointer --> void
  method delete-from-cursor {
    self.connect($!w, 'delete-from-cursor');
  }

  # Is originally:
  # GtkTextView, GtkTextExtendSelection, GtkTextIter, GtkTextIter, GtkTextIter, gpointer --> gboolean
  method extend-selection {
    self.connect($!w, 'extend-selection');
  }

  # Is originally:
  # GtkTextView, gchar, gpointer --> void
  method insert-at-cursor {
    self.connect($!w, 'insert-at-cursor');
  }

  # Is originally:
  # GtkTextView, GtkMovementStep, gint, gboolean, gpointer --> void
  method move-cursor {
    self.connect($!w, 'move-cursor');
  }

  # Is originally:
  # GtkTextView, GtkScrollStep, gint, gpointer --> void
  method move-viewport {
    self.connect($!w, 'move-viewport');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method paste-clipboard {
    self.connect($!w, 'paste-clipboard');
  }

  # Is originally:
  # GtkTextView, GtkWidget, gpointer --> void
  method populate-popup {
    self.connect($!w, 'populate-popup');
  }

  # Is originally:
  # GtkTextView, gchar, gpointer --> void
  method preedit-changed {
    self.connect($!w, 'preedit-changed');
  }

  # Is originally:
  # GtkTextView, gboolean, gpointer --> void
  method select-all {
    self.connect($!w, 'select-all');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method set-anchor {
    self.connect($!w, 'set-anchor');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method toggle-cursor-visible {
    self.connect($!w, 'toggle-cursor-visible');
  }

  # Is originally:
  # GtkTextView, gpointer --> void
  method toggle-overwrite {
    self.connect($!w, 'toggle-overwrite');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accepts_tab is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_accepts_tab($!tv);
      },
      STORE => sub ($, $accepts_tab is copy) {
        gtk_text_view_set_accepts_tab($!tv, $accepts_tab);
      }
    );
  }

  method bottom_margin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_bottom_margin($!tv);
      },
      STORE => sub ($, $bottom_margin is copy) {
        gtk_text_view_set_bottom_margin($!tv, $bottom_margin);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_buffer($!tv);
      },
      STORE => sub ($, $buffer is copy) {
        gtk_text_view_set_buffer($!tv, $buffer);
      }
    );
  }

  method cursor_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_cursor_visible($!tv);
      },
      STORE => sub ($, $setting is copy) {
        gtk_text_view_set_cursor_visible($!tv, $setting);
      }
    );
  }

  method editable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_editable($!tv);
      },
      STORE => sub ($, $setting is copy) {
        gtk_text_view_set_editable($!tv, $setting);
      }
    );
  }

  method indent is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_indent($!tv);
      },
      STORE => sub ($, $indent is copy) {
        gtk_text_view_set_indent($!tv, $indent);
      }
    );
  }

  method input_hints is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_input_hints($!tv);
      },
      STORE => sub ($, $hints is copy) {
        gtk_text_view_set_input_hints($!tv, $hints);
      }
    );
  }

  method input_purpose is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_input_purpose($!tv);
      },
      STORE => sub ($, $purpose is copy) {
        gtk_text_view_set_input_purpose($!tv, $purpose);
      }
    );
  }

  method justification is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_justification($!tv);
      },
      STORE => sub ($, $justification is copy) {
        gtk_text_view_set_justification($!tv, $justification);
      }
    );
  }

  method left_margin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_left_margin($!tv);
      },
      STORE => sub ($, $left_margin is copy) {
        gtk_text_view_set_left_margin($!tv, $left_margin);
      }
    );
  }

  method monospace is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_monospace($!tv);
      },
      STORE => sub ($, $monospace is copy) {
        gtk_text_view_set_monospace($!tv, $monospace);
      }
    );
  }

  method overwrite is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_overwrite($!tv);
      },
      STORE => sub ($, $overwrite is copy) {
        gtk_text_view_set_overwrite($!tv, $overwrite);
      }
    );
  }

  method pixels_above_lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_above_lines($!tv);
      },
      STORE => sub ($, $pixels_above_lines is copy) {
        gtk_text_view_set_pixels_above_lines($!tv, $pixels_above_lines);
      }
    );
  }

  method pixels_below_lines is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_below_lines($!tv);
      },
      STORE => sub ($, $pixels_below_lines is copy) {
        gtk_text_view_set_pixels_below_lines($!tv, $pixels_below_lines);
      }
    );
  }

  method pixels_inside_wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_pixels_inside_wrap($!tv);
      },
      STORE => sub ($, $pixels_inside_wrap is copy) {
        gtk_text_view_set_pixels_inside_wrap($!tv, $pixels_inside_wrap);
      }
    );
  }

  method right_margin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_right_margin($!tv);
      },
      STORE => sub ($, $right_margin is copy) {
        gtk_text_view_set_right_margin($!tv, $right_margin);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_tabs($!tv);
      },
      STORE => sub ($, $tabs is copy) {
        gtk_text_view_set_tabs($!tv, $tabs);
      }
    );
  }

  method top_margin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_top_margin($!tv);
      },
      STORE => sub ($, $top_margin is copy) {
        gtk_text_view_set_top_margin($!tv, $top_margin);
      }
    );
  }

  method wrap_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_view_get_wrap_mode($!tv);
      },
      STORE => sub ($, $wrap_mode is copy) {
        gtk_text_view_set_wrap_mode($!tv, $wrap_mode);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_child_at_anchor (GtkWidget $child, GtkTextChildAnchor $anchor) {
    gtk_text_view_add_child_at_anchor($!tv, $child, $anchor);
  }
  multi method add_child_at_anchor (GTK::Widget $child, GtkTextChildAnchor $anchor)  {
    samewith($child.widget, $anchor);
  }

  method backward_display_line (GtkTextIter $iter) {
    gtk_text_view_backward_display_line($!tv, $iter);
  }

  method backward_display_line_start (GtkTextIter $iter) {
    gtk_text_view_backward_display_line_start($!tv, $iter);
  }

  method buffer_to_window_coords (
    GtkTextWindowType $win,
    Int() $buffer_x,
    Int() $buffer_y,
    Int() $window_x,
    Int() $window_y
  ) {
    my gint ($bx, $by,$wx, $wy) = ($buffer_x, $buffer_y, $window_x, $window_y);
    gtk_text_view_buffer_to_window_coords($!tv, $win, $bx, $by, $wx, $y);
  }

  method forward_display_line (GtkTextIter $iter) {
    gtk_text_view_forward_display_line($!tv, $iter);
  }

  method forward_display_line_end (GtkTextIter $iter) {
    gtk_text_view_forward_display_line_end($!tv, $iter);
  }

  method get_border_window_size (GtkTextWindowType $type) {
    gtk_text_view_get_border_window_size($!tv, $type);
  }

  method get_cursor_locations (
    GtkTextIter $iter,
    GdkRectangle $strong,
    GdkRectangle $weak
  ) {
    gtk_text_view_get_cursor_locations($!tv, $iter, $strong, $weak);
  }

  method get_default_attributes {
    gtk_text_view_get_default_attributes($!tv);
  }

  method get_hadjustment {
    gtk_text_view_get_hadjustment($!tv);
  }

  method get_iter_at_location (
    GtkTextIter $iter,
    Int() $x,
    Int() $y
  ) {
    my gint ($xx, $yy) = ($x, $y) >>+&<< (0xffff xx 2);
    gtk_text_view_get_iter_at_location($!tv, $iter, $xx, $yy);
  }

  method get_iter_at_position (
    GtkTextIter $iter,
    Int() $trailing,
    Int() $x,
    Int() $y
  ) {
    my gint ($t, $xx, $yy) = ($trailing, $x, $y) >>+&<< (0xffff xx 3);
    gtk_text_view_get_iter_at_position($!tv, $iter, $t, $xx, $yy);
  }

  method get_iter_location (GtkTextIter $iter, GdkRectangle $location) {
    gtk_text_view_get_iter_location($!tv, $iter, $location);
  }

  method get_line_at_y (GtkTextIter $target_iter, Int() $y, Int() $line_top) {
    my gint ($yy, $lt) = ($y, $line_top) >>+&<< (0xffff xx 2);
    gtk_text_view_get_line_at_y($!tv, $target_iter, $yy, $lt);
  }

  method get_line_yrange (GtkTextIter $iter, Int() $y, Int() $height) {
    my gint ($yy, $h) = ($y, $height) >>+&<< (0xffff xx 2);
    gtk_text_view_get_line_yrange($!tv, $iter, $yy, $h);
  }

  method get_type {
    gtk_text_view_get_type();
  }

  method get_vadjustment {
    gtk_text_view_get_vadjustment($!tv);
  }

  method get_visible_rect (GdkRectangle $visible_rect) {
    gtk_text_view_get_visible_rect($!tv, $visible_rect);
  }

  multi method get_window (GtkTextWindowType $win) {
    gtk_text_view_get_window($!tv, $win);
  }

  method get_window_type (GdkWindow $window) {
    gtk_text_view_get_window_type($!tv, $window);
  }

  method im_context_filter_keypress (GdkEventKey $event) {
    gtk_text_view_im_context_filter_keypress($!tv, $event);
  }

  method move_mark_onscreen (GtkTextMark $mark) {
    gtk_text_view_move_mark_onscreen($!tv, $mark);
  }

  method move_visually (GtkTextIter $iter, Int() $count) {
    my gint $c = $count;
    gtk_text_view_move_visually($!tv, $iter, $);
  }

  method place_cursor_onscreen {
    gtk_text_view_place_cursor_onscreen($!tv);
  }

  method reset_cursor_blink {
    gtk_text_view_reset_cursor_blink($!tv);
  }

  method reset_im_context {
    gtk_text_view_reset_im_context($!tv);
  }

  method scroll_mark_onscreen (GtkTextMark $mark) {
    gtk_text_view_scroll_mark_onscreen($!tv, $mark);
  }

  method scroll_to_iter (
    GtkTextIter $iter,
    Num()  $within_margin,
    Bool() $use_align,
    Num()  $xalign,
    Num()  $yalign
  ) {
    my gdouble ($wm, $xa, $ya) = ($within_margin, $xalign, $yalign);
    my gboolean $ua = $use_align.Int;
    gtk_text_view_scroll_to_iter($!tv, $iter, $wm, $ua, $xa, $ya);
  }

  method scroll_to_mark (
    GtkTextMark $mark,
    Num()  $within_margin,
    Bool() $use_align,
    Num()  $xalign,
    Num()  $yalign
  ) {
    my gdouble ($wm, $xa, $ya) = ($within_margin, $xalign, $yalign);
    my gboolean $ua = $use_align.Int;
    gtk_text_view_scroll_to_mark($!tv, $mark, $wm, $ua, $xa, $ya);
  }

  method set_border_window_size (GtkTextWindowType $type, gint $size) {
    gtk_text_view_set_border_window_size($!tv, $type, $size);
  }

  method starts_display_line (GtkTextIter $iter) {
    gtk_text_view_starts_display_line($!tv, $iter);
  }

  method window_to_buffer_coords (
    GtkTextWindowType $win,
    Int() $window_x,
    Int() $window_y,
    Int() $buffer_x,
    Int() $buffer_y
  ) {
    my gint($wx, $wy, $by, $by) =
      ($window_x, $window_y, $buffer_x, $buffer_y)
      >>+&<<
      (0xxxx xx 4);
    gtk_text_view_window_to_buffer_coords($!tv, $win, $wx, $wy, $bx, $by);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
