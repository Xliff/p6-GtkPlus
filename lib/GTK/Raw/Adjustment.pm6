use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Adjustment:ver<3.0.1146>;

sub gtk_adjustment_changed (GtkAdjustment $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_clamp_page (
  GtkAdjustment $adjustment,
  gdouble $lower,
  gdouble $upper
)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_configure (
  GtkAdjustment $adjustment,
  gdouble $value,
  gdouble $lower,
  gdouble $upper,
  gdouble $step_increment,
  gdouble $page_increment,
  gdouble $page_size
)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_minimum_increment (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_new (
  gdouble $value,
  gdouble $lower,
  gdouble $upper,
  gdouble $step_increment,
  gdouble $page_increment,
  gdouble $page_size
)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_value_changed (GtkAdjustment $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_lower (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_page_size (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_step_increment (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_upper (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_value (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_get_page_increment (GtkAdjustment $adjustment)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_lower (GtkAdjustment $adjustment, gdouble $lower)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_page_size (
  GtkAdjustment $adjustment,
  gdouble $page_size
)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_step_increment (
  GtkAdjustment $adjustment,
  gdouble $step_increment
)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_upper (GtkAdjustment $adjustment, gdouble $upper)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_value (GtkAdjustment $adjustment, gdouble $value)
  is native(gtk)
  is export
  { * }

sub gtk_adjustment_set_page_increment (
  GtkAdjustment $adjustment,
  gdouble $page_increment
)
  is native(gtk)
  is export
  { * }