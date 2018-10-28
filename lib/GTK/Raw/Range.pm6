use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Range;

sub gtk_range_get_range_rect (GtkRange $range, GdkRectangle $range_rect)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_slider_range (GtkRange $range, gint $slider_start, gint $slider_end)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_increments (GtkRange $range, gdouble $step, gdouble $page)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_range (GtkRange $range, gdouble $min, gdouble $max)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_flippable (GtkRange $range)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_value (GtkRange $range)
  returns gdouble
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_round_digits (GtkRange $range)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_adjustment (GtkRange $range)
  returns GtkAdjustment
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_fill_level (GtkRange $range)
  returns gdouble
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_show_fill_level (GtkRange $range)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_restrict_to_fill_level (GtkRange $range)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_lower_stepper_sensitivity (GtkRange $range)
  returns uint32 # GtkSensitivityType
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_min_slider_size (GtkRange $range)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_upper_stepper_sensitivity (GtkRange $range)
  returns uint32 # GtkSensitivityType
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_inverted (GtkRange $range)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_get_slider_size_fixed (GtkRange $range)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_flippable (GtkRange $range, gboolean $flippable)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_value (GtkRange $range, gdouble $value)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_round_digits (GtkRange $range, gint $round_digits)
  is native($LIBGTK)
  is export
  { * }

# (GtkRange $range, GtkAdjustment $adjustment)
sub gtk_range_set_adjustment (GtkRange $range, uint32 $adjustment)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_fill_level (GtkRange $range, gdouble $fill_level)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_show_fill_level (GtkRange $range, gboolean $show_fill_level)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_restrict_to_fill_level (GtkRange $range, gboolean $restrict_to_fill_level)
  is native($LIBGTK)
  is export
  { * }

# (GtkRange $range, GtkSensitivityType $sensitivity)
sub gtk_range_set_lower_stepper_sensitivity (GtkRange $range, uint32 $sensitivity)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_min_slider_size (GtkRange $range, gint $min_size)
  is native($LIBGTK)
  is export
  { * }

# (GtkRange $range, GtkSensitivityType $sensitivity)
sub gtk_range_set_upper_stepper_sensitivity (GtkRange $range, uint32 $sensitivity)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_inverted (GtkRange $range, gboolean $setting)
  is native($LIBGTK)
  is export
  { * }

sub gtk_range_set_slider_size_fixed (GtkRange $range, gboolean $size_fixed)
  is native($LIBGTK)
  is export
  { * }