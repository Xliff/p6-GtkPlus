use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;

unit package GTK::Compat::Raw::Monitor;

sub gdk_monitor_get_display (GdkMonitor $monitor)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_geometry (GdkMonitor $monitor, GdkRectangle $geometry)
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_height_mm (GdkMonitor $monitor)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_manufacturer (GdkMonitor $monitor)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_model (GdkMonitor $monitor)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_refresh_rate (GdkMonitor $monitor)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_scale_factor (GdkMonitor $monitor)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_subpixel_layout (GdkMonitor $monitor)
  returns uint32 # GdkSubpixelLayout
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_width_mm (GdkMonitor $monitor)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_monitor_get_workarea (GdkMonitor $monitor, GdkRectangle $workarea)
  is native(gdk)
  is export
  { * }

sub gdk_monitor_is_primary (GdkMonitor $monitor)
  returns uint32
  is native(gdk)
  is export
  { * }
