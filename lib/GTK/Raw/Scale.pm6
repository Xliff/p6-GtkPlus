use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Scale;

# (GtkScale $scale, gdouble $value, GtkPositionType $position, gchar $markup)
sub gtk_scale_add_mark (GtkScale $scale, gdouble $value, uint32 $position, gchar $markup)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_clear_marks (GtkScale $scale)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_layout (GtkScale $scale)
  returns PangoLayout
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_layout_offsets (GtkScale $scale, gint $x, gint $y)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }


# (GtkOrientation $orientation, GtkAdjustment $adjustment)
sub gtk_scale_new (uint32 $orientation, GtkAdjustment $adjustment)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

# (GtkOrientation $orientation, gdouble $min, gdouble $max, gdouble $step)
sub gtk_scale_new_with_range (uint32 $orientation, gdouble $min, gdouble $max, gdouble $step)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_value_pos (GtkScale $scale)
  returns uint32 # GtkPositionType
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_draw_value (GtkScale $scale)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_has_origin (GtkScale $scale)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_get_digits (GtkScale $scale)
  returns gint
  is native($LIBGTK)
  is export
  { * }

# (GtkScale $scale, GtkPositionType $pos)
sub gtk_scale_set_value_pos (GtkScale $scale, uint32 $pos)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_set_draw_value (GtkScale $scale, gboolean $draw_value)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_set_has_origin (GtkScale $scale, gboolean $has_origin)
  is native($LIBGTK)
  is export
  { * }

sub gtk_scale_set_digits (GtkScale $scale, gint $digits)
  is native($LIBGTK)
  is export
  { * }