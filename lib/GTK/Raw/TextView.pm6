use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Pango::Raw::Types;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TextView:ver<3.0.1146>;

sub gtk_text_view_add_child_at_anchor (
  GtkTextView $text_view,
  GtkWidget $child,
  GtkTextChildAnchor $anchor
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_backward_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_backward_display_line_start (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_buffer_to_window_coords (
  GtkTextView $text_view,
  uint32 $win,                 # GtkTextWindowType $win,
  gint $buffer_x,
  gint $buffer_y,
  gint $window_x,
  gint $window_y
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_forward_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_forward_display_line_end (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_border_window_size (
  GtkTextView $text_view,
  uint32 $type                  # GtkTextWindowType $type
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_cursor_locations (
  GtkTextView $text_view,
  GtkTextIter $iter,
  GdkRectangle $strong,
  GdkRectangle $weak
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_default_attributes (GtkTextView $text_view)
  returns GtkTextAttributes
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_hadjustment (GtkTextView $text_view)
  returns uint32 # GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_iter_at_location (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint $x,
  gint $y
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_iter_at_position (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint $trailing,
  gint $x,
  gint $y
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_iter_location (
  GtkTextView $text_view,
  GtkTextIter $iter,
  GdkRectangle $location
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_line_at_y (
  GtkTextView $text_view,
  GtkTextIter $target_iter,
  gint $y,
  gint $line_top
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_line_yrange (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint $y,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_vadjustment (GtkTextView $text_view)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_visible_rect (
  GtkTextView $text_view,
  GdkRectangle $visible_rect
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_window (
  GtkTextView $text_view,
  uint32 $window              # GtkTextWindowType $win
)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_window_type (GtkTextView $text_view, GdkWindow $window)
  returns uint32 # GtkTextWindowType
  is native(gtk)
  is export
  { * }

sub gtk_text_view_im_context_filter_keypress (
  GtkTextView $text_view,
  GdkEventKey $event
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_move_mark_onscreen (GtkTextView $text_view, GtkTextMark $mark)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_move_visually (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gint $count
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_text_view_new_with_buffer (GtkTextBuffer $buffer)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_text_view_place_cursor_onscreen (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_reset_cursor_blink (GtkTextView $text_view)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_reset_im_context (GtkTextView $text_view)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_scroll_mark_onscreen (
  GtkTextView $text_view,
  GtkTextMark $mark
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_scroll_to_iter (
  GtkTextView $text_view,
  GtkTextIter $iter,
  gdouble $within_margin,
  gboolean $use_align,
  gdouble $xalign,
  gdouble $yalign
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_scroll_to_mark (
  GtkTextView $text_view,
  GtkTextMark $mark,
  gdouble $within_margin,
  gboolean $use_align,
  gdouble $xalign,
  gdouble $yalign
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_border_window_size (
  GtkTextView $text_view,
  uint32 $type,               # GtkTextWindowType $type,
  gint $size
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_starts_display_line (
  GtkTextView $text_view,
  GtkTextIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_window_to_buffer_coords (
  GtkTextView $text_view,
  uint32 $win,                # GtkTextWindowType $win,
  gint $window_x,
  gint $window_y,
  gint $buffer_x,
  gint $buffer_y
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_input_hints (GtkTextView $text_view)
  returns uint32 # GtkInputHints
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_pixels_below_lines (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_monospace (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_tabs (GtkTextView $text_view)
  returns PangoTabArray
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_pixels_above_lines (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_overwrite (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_right_margin (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_left_margin (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_accepts_tab (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_top_margin (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_wrap_mode (GtkTextView $text_view)
  returns uint32 # GtkWrapMode
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_justification (GtkTextView $text_view)
  returns uint32 # GtkJustification
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_input_purpose (GtkTextView $text_view)
  returns uint32 # GtkInputPurpose
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_pixels_inside_wrap (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_bottom_margin (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_editable (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_cursor_visible (GtkTextView $text_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_indent (GtkTextView $text_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_text_view_get_buffer (GtkTextView $text_view)
  returns GtkTextBuffer
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_buffer (
  GtkTextView $text_view,
  GtkTextBuffer $buffer
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_input_hints (
  GtkTextView $text_view,
  uint32 $hints               # GtkInputHints $hints
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_pixels_below_lines (
  GtkTextView $text_view,
  gint $pixels_below_lines
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_monospace (
  GtkTextView $text_view,
  gboolean $monospace
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_tabs (GtkTextView $text_view, PangoTabArray $tabs)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_pixels_above_lines (
  GtkTextView $text_view,
  gint $pixels_above_lines
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_overwrite (GtkTextView $text_view, gboolean $overwrite)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_right_margin (GtkTextView $text_view, gint $right_margin)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_left_margin (GtkTextView $text_view, gint $left_margin)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_accepts_tab (GtkTextView $text_view, gboolean $accepts_tab)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_top_margin (GtkTextView $text_view, gint $top_margin)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_wrap_mode (
  GtkTextView $text_view,
  uint32 $wrap_mopde,         # GtkWrapMode $wrap_mode
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_justification (
  GtkTextView $text_view,
  uint32 $justification        # GtkJustification $justification
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_input_purpose (
  GtkTextView $text_view,
  uint32 $purpose             # GtkInputPurpose $purpose
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_pixels_inside_wrap (
  GtkTextView $text_view,
  gint $pixels_inside_wrap
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_bottom_margin (GtkTextView $text_view, gint $bottom_margin)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_editable (GtkTextView $text_view, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_cursor_visible (GtkTextView $text_view, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_set_indent (GtkTextView $text_view, gint $indent)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_add_child_in_window (
  GtkTextView $text_view,
  GtkWidget   $child,
  uint32      $which_window,
  # window coordinates
  gint        $xpos,
  gint        $ypos
)
  is native(gtk)
  is export
  { * }

sub gtk_text_view_move_child (
  GtkTextView $text_view,
  GtkWidget   $child,
  # window coordinates
  gint        $xpos,
  gint        $ypos
)
 is native(gtk)
 is export
 { * }
