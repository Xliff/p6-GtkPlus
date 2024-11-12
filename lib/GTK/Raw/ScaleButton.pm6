use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ScaleButton:ver<3.0.1146>;

sub gtk_scale_button_get_minus_button (GtkScaleButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_get_plus_button (GtkScaleButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_get_popup (GtkScaleButton $button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

# (GtkIconSize $size, gdouble $min, gdouble $max, gdouble $step, Str $icons)
sub gtk_scale_button_new (
  uint32      $size,
  gdouble     $min,
  gdouble     $max,
  gdouble     $step,
  CArray[Str] $icons
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_set_icons (GtkScaleButton $button, CArray[Str] $icons)
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_get_adjustment (GtkScaleButton $button)
  returns uint32 # GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_get_value (GtkScaleButton $button)
  returns gdouble
  is native(gtk)
  is export
  { * }

# (GtkScaleButton $button, GtkAdjustment $adjustment)
sub gtk_scale_button_set_adjustment (GtkScaleButton $button, uint32 $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_scale_button_set_value (GtkScaleButton $button, gdouble $value)
  is native(gtk)
  is export
  { * }
