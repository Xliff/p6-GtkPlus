use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::Display;

sub gdk_display_beep (GdkDisplay $display)
  is native(gdk)
  is export
  { * }

sub gdk_display_close (GdkDisplay $display)
  is native(gdk)
  is export
  { * }

sub gdk_display_device_is_grabbed (GdkDisplay $display, GdkDevice $device)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_flush (GdkDisplay $display)
  is native(gdk)
  is export
  { * }

sub gdk_display_get_app_launch_context (GdkDisplay $display)
  returns GdkAppLaunchContext
  is native(gdk)
  is export
  { * }

sub gdk_display_get_default ()
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_display_get_default_cursor_size (GdkDisplay $display)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_display_get_default_group (GdkDisplay $display)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_display_get_default_screen (GdkDisplay $display)
  returns GdkScreen
  is native(gdk)
  is export
  { * }

sub gdk_display_get_default_seat (GdkDisplay $display)
  returns GdkSeat
  is native(gdk)
  is export
  { * }

sub gdk_display_get_device_manager (GdkDisplay $display)
  returns GdkDeviceManager
  is native(gdk)
  is export
  { * }

sub gdk_display_get_event (GdkDisplay $display)
  returns GdkEvent
  is native(gdk)
  is export
  { * }

sub gdk_display_get_maximal_cursor_size (
  GdkDisplay $display,
  guint $width,
  guint $height
)
  is native(gdk)
  is export
  { * }

sub gdk_display_get_monitor (GdkDisplay $display, gint $monitor_num)
  returns GdkMonitor
  is native(gdk)
  is export
  { * }

sub gdk_display_get_monitor_at_point (GdkDisplay $display, gint $x, gint $y)
  returns GdkMonitor
  is native(gdk)
  is export
  { * }

sub gdk_display_get_monitor_at_window (GdkDisplay $display, GdkWindow $window)
  returns GdkMonitor
  is native(gdk)
  is export
  { * }

sub gdk_display_get_n_monitors (GdkDisplay $display)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_display_get_n_screens (GdkDisplay $display)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_display_get_name (GdkDisplay $display)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_display_get_pointer (
  GdkDisplay $display,
  GdkScreen $screen,
  gint $x,
  gint $y,
  uint32 $mask                    # GdkModifierType $mask
)
  is native(gdk)
  is export
  { * }

sub gdk_display_get_primary_monitor (GdkDisplay $display)
  returns GdkMonitor
  is native(gdk)
  is export
  { * }

sub gdk_display_get_screen (GdkDisplay $display, gint $screen_num)
  returns GdkScreen
  is native(gdk)
  is export
  { * }

sub gdk_display_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_display_get_window_at_pointer (
  GdkDisplay $display,
  gint $win_x,
  gint $win_y
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_display_has_pending (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_is_closed (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_keyboard_ungrab (GdkDisplay $display, guint32 $time_)
  is native(gdk)
  is export
  { * }

sub gdk_display_list_devices (GdkDisplay $display)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_display_list_seats (GdkDisplay $display)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_display_notify_startup_complete (
  GdkDisplay $display,
  gchar $startup_id
)
  is native(gdk)
  is export
  { * }

sub gdk_display_open (gchar $display_name)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_display_open_default_libgtk_only ()
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_display_peek_event (GdkDisplay $display)
  returns GdkEvent
  is native(gdk)
  is export
  { * }

sub gdk_display_pointer_is_grabbed (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_pointer_ungrab (GdkDisplay $display, guint32 $time_)
  is native(gdk)
  is export
  { * }

sub gdk_display_put_event (GdkDisplay $display, GdkEvent $event)
  is native(gdk)
  is export
  { * }

sub gdk_display_request_selection_notification (
  GdkDisplay $display,
  GdkAtom $selection
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_set_double_click_distance (
  GdkDisplay $display,
  guint $distance
)
  is native(gdk)
  is export
  { * }

sub gdk_display_set_double_click_time (GdkDisplay $display, guint $msec)
  is native(gdk)
  is export
  { * }

sub gdk_display_store_clipboard (
  GdkDisplay $display,
  GdkWindow $clipboard_window,
  guint32 $time_,
  GdkAtom $targets,
  gint $n_targets
)
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_clipboard_persistence (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_composite (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_cursor_alpha (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_cursor_color (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_input_shapes (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_selection_notification (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_supports_shapes (GdkDisplay $display)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_display_sync (GdkDisplay $display)
  is native(gdk)
  is export
  { * }

sub gdk_display_warp_pointer (
  GdkDisplay $display,
  GdkScreen $screen,
  gint $x,
  gint $y
)
  is native(gdk)
  is export
  { * }
