use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package gdk::Raw::Device;

sub gdk_device_free_history (
  uint32 $events,                 # GdkTimeCoord $events,
  gint $n_events
)
  is native(gdk)
  is export
  { * }

sub gdk_device_get_associated_device (GdkDevice $device)
  returns GdkDevice
  is native(gdk)
  is export
  { * }

sub gdk_device_get_axes (GdkDevice $device)
  returns uint32 # GdkAxisFlags
  is native(gdk)
  is export
  { * }

sub gdk_device_get_axis (
  GdkDevice $device,
  gdouble $axes,
  uint32 $use,                    # GdkAxisUse $use,
  gdouble $value
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_get_axis_use (GdkDevice $device, guint $index)
  returns uint32 # GdkAxisUse
  is native(gdk)
  is export
  { * }

sub gdk_device_get_axis_value (
  GdkDevice $device,
  gdouble $axes,
  GdkAtom $axis_label,
  gdouble $value
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_get_device_type (GdkDevice $device)
  returns uint32 # GdkDeviceType
  is native(gdk)
  is export
  { * }

sub gdk_device_get_display (GdkDevice $device)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_device_get_has_cursor (GdkDevice $device)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_get_history (
  GdkDevice $device,
  GdkWindow $window,
  guint32 $start,
  guint32 $stop,
  uint32 $events,                 # GdkTimeCoord $events,
  gint $n_events
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_get_key (
  GdkDevice $device,
  guint $index_,
  guint $keyval,
  uint32 $mods                    # GdkModifierType $modifiers
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_get_last_event_window (GdkDevice $device)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_device_get_n_axes (GdkDevice $device)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_device_get_n_keys (GdkDevice $device)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_device_get_name (GdkDevice $device)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_device_get_position (
  GdkDevice $device,
  GdkScreen $screen,
  gint $x,
  gint $y
)
  is native(gdk)
  is export
  { * }

sub gdk_device_get_position_double (
  GdkDevice $device,
  GdkScreen $screen,
  gdouble $x,
  gdouble $y
)
  is native(gdk)
  is export
  { * }

sub gdk_device_get_product_id (GdkDevice $device)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_device_get_seat (GdkDevice $device)
  returns GdkSeat
  is native(gdk)
  is export
  { * }

sub gdk_device_get_source (GdkDevice $device)
  returns uint32 # GdkInputSource
  is native(gdk)
  is export
  { * }

sub gdk_device_get_state (
  GdkDevice $device,
  GdkWindow $window,
  gdouble $axes,
  uint32 $mask # GdkModifierType $mask
)
  is native(gdk)
  is export
  { * }

sub gdk_device_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_device_get_vendor_id (GdkDevice $device)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_device_get_window_at_position (
  GdkDevice $device,
  gint $win_x,
  gint $win_y
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_device_get_window_at_position_double (
  GdkDevice $device,
  gdouble $win_x,
  gdouble $win_y
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_device_grab (
  GdkDevice $device,
  GdkWindow $window,
  uint32 $grab_o, # GdkGrabOwnership $grab_ownership,
  gboolean $owner_events,
  uint32 $event_mask, # GdkEventMask $event_mask,
  GdkCursor $cursor,
  guint32 $time
)
  returns uint32 # GdkGrabStatus
  is native(gdk)
  is export
  { * }

sub gdk_device_grab_info_libgdk_only (
  GdkDisplay $display,
  GdkDevice $device,
  GdkWindow $grab_window,
  gboolean $owner_events
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_device_list_axes (GdkDevice $device)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_device_list_slave_devices (GdkDevice $device)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_device_set_axis_use (
  GdkDevice $device,
  guint $index,
  uint32 $use # GdkAxisUse $use
)
  is native(gdk)
  is export
  { * }

sub gdk_device_set_key (
  GdkDevice $device,
  guint $index_,
  guint $keyval,
  uint32 $mods # GdkModifierType $modifiers
)
  is native(gdk)
  is export
  { * }

sub gdk_device_ungrab (GdkDevice $device, guint32 $time)
  is native(gdk)
  is export
  { * }

sub gdk_device_warp (GdkDevice $device, GdkScreen $screen, gint $x, gint $y)
  is native(gdk)
  is export
  { * }

sub gdk_device_get_mode (GdkDevice $device)
  returns uint32 # GdkInputMode
  is native(gdk)
  is export
  { * }

sub gdk_device_set_mode (
  GdkDevice $device,
  uint32 $mode # GdkInputMode $mode
)
  returns uint32
  is native(gdk)
  is export
  { * }
