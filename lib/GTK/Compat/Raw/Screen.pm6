use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Screen;

sub gdk_screen_get_active_window (GdkScreen $screen)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_default ()
  returns GdkScreen
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_display (GdkScreen $screen)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_height (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_height_mm (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_at_point (GdkScreen $screen, gint $x, gint $y)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_at_window (GdkScreen $screen, GdkWindow $window)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_geometry (
  GdkScreen $screen,
  gint $monitor_num,
  GdkRectangle $dest
)
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_height_mm (GdkScreen $screen, gint $monitor_num)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_plug_name (GdkScreen $screen, gint $monitor_num)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_scale_factor (GdkScreen $screen, gint $monitor_num)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_width_mm (GdkScreen $screen, gint $monitor_num)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_monitor_workarea (
  GdkScreen $screen,
  gint $monitor_num,
  GdkRectangle $dest
)
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_n_monitors (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_number (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_primary_monitor (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_rgba_visual (GdkScreen $screen)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_root_window (GdkScreen $screen)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_setting (GdkScreen $screen, gchar $name, GValue $value)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_system_visual (GdkScreen $screen)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_toplevel_windows (GdkScreen $screen)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_width (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_width_mm (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_window_stack (GdkScreen $screen)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_screen_is_composited (GdkScreen $screen)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_screen_list_visuals (GdkScreen $screen)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_screen_make_display_name (GdkScreen $screen)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_resolution (GdkScreen $screen)
  returns gdouble
  is native(gdk)
  is export
  { * }

sub gdk_screen_get_font_options (GdkScreen $screen)
  returns cairo_font_options_t
  is native(gdk)
  is export
  { * }

sub gdk_screen_set_resolution (GdkScreen $screen, gdouble $dpi)
  is native(gdk)
  is export
  { * }

sub gdk_screen_set_font_options (
  GdkScreen $screen,
  cairo_font_options_t $options
)
  is native(gdk)
  is export
  { * }
