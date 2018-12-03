use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Raw::Device;

sub gdk_device_free_history (GdkTimeCoord $events, gint $n_events)
  is native(gtk)
  is export
  { * }

sub gdk_device_get_associated_device (GdkDevice $device)
  returns GdkDevice
  is native(gtk)
  is export
  { * }

sub gdk_device_get_axes (GdkDevice $device)
  returns uint32 # GdkAxisFlags
  is native(gtk)
  is export
  { * }

sub gdk_device_get_axis (
  GdkDevice $device,
  gdouble $axes,
  uint32 $use # GdkAxisUse $use,
  gdouble $value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_get_axis_use (GdkDevice $device, guint $index_)
  returns # GdkAxisUse
  is native(gtk)
  is export
  { * }

sub gdk_device_get_axis_value (
  GdkDevice $device,
  gdouble $axes,
  GdkAtom $axis_label,
  gdouble $value
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_get_device_type (GdkDevice $device)
  returns GdkDeviceType
  is native(gtk)
  is export
  { * }

sub gdk_device_get_display (GdkDevice $device)
  returns GdkDisplay
  is native(gtk)
  is export
  { * }

sub gdk_device_get_has_cursor (GdkDevice $device)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_get_history (
  GdkDevice $device,
  GdkWindow $window,
  guint32 $start,
  guint32 $stop,
  GdkTimeCoord $events,
  gint $n_events
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_get_key (
  GdkDevice $device,
  guint $index_,
  guint $keyval,
  uint32 $mods # GdkModifierType $modifiers
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_get_last_event_window (GdkDevice $device)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gdk_device_get_n_axes (GdkDevice $device)
  returns gint
  is native(gtk)
  is export
  { * }

sub gdk_device_get_n_keys (GdkDevice $device)
  returns gint
  is native(gtk)
  is export
  { * }

sub gdk_device_get_name (GdkDevice $device)
  returns Str
  is native(gtk)
  is export
  { * }

sub gdk_device_get_position (
  GdkDevice $device,
  GdkScreen $screen,
  gint $x,
  gint $y
)
  is native(gtk)
  is export
  { * }

sub gdk_device_get_position_double (
  GdkDevice $device,
  GdkScreen $screen,
  gdouble $x,
  gdouble $y
)
  is native(gtk)
  is export
  { * }

sub gdk_device_get_product_id (GdkDevice $device)
  returns Str
  is native(gtk)
  is export
  { * }

sub gdk_device_get_seat (GdkDevice $device)
  returns GdkSeat
  is native(gtk)
  is export
  { * }

sub gdk_device_get_source (GdkDevice $device)
  returns GdkInputSource
  is native(gtk)
  is export
  { * }

sub gdk_device_get_state (
  GdkDevice $device,
  GdkWindow $window,
  gdouble $axes,
  uint32 $mask # GdkModifierType $mask
)
  is native(gtk)
  is export
  { * }

sub gdk_device_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gdk_device_get_vendor_id (GdkDevice $device)
  returns Str
  is native(gtk)
  is export
  { * }

sub gdk_device_get_window_at_position (
  GdkDevice $device,
  gint $win_x,
  gint $win_y
)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gdk_device_get_window_at_position_double (
  GdkDevice $device,
  gdouble $win_x,
  gdouble $win_y
)
  returns GdkWindow
  is native(gtk)
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
  is native(gtk)
  is export
  { * }

sub gdk_device_grab_info_libgtk_only (
  GdkDisplay $display,
  GdkDevice $device,
  GdkWindow $grab_window,
  gboolean $owner_events
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gdk_device_list_axes (GdkDevice $device)
  returns GList
  is native(gtk)
  is export
  { * }

sub gdk_device_list_slave_devices (GdkDevice $device)
  returns GList
  is native(gtk)
  is export
  { * }

sub gdk_device_set_axis_use (
  GdkDevice $device,
  guint $index,
  uint32 $use # GdkAxisUse $use
)
  is native(gtk)
  is export
  { * }

sub gdk_device_set_key (
  GdkDevice $device,
  guint $index_,
  guint $keyval,
  uint32 $mods # GdkModifierType $modifiers
)
  is native(gtk)
  is export
  { * }

sub gdk_device_ungrab (GdkDevice $device, guint32 $time)
  is native(gtk)
  is export
  { * }

sub gdk_device_warp (GdkDevice $device, GdkScreen $screen, gint $x, gint $y)
  is native(gtk)
  is export
  { * }

sub gdk_device_get_mode (GdkDevice $device)
  returns uint32 # GdkInputMode
  is native(gtk)
  is export
  { * }

sub gdk_device_set_mode (
  GdkDevice $device,
  uint32 $mode # GdkInputMode $mode
)
  returns uint32
  is native(gtk)
  is export
  { * }
