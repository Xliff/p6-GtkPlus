use v6.c;

use NativeCall;

use GDK::Raw::Types;
use GTK::Raw::Types;

unit package GDK::Raw::Event;

sub gdk_event_copy (GdkEvent $event)
  returns GdkEvent
  is native(gdk)
  is export
{ * }

sub gdk_event_free (GdkEvent $event)
  is native(gdk)
  is export
{ * }

sub gdk_events_get_angle (GdkEvent $event1, GdkEvent $event2, gdouble $angle)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_events_get_center (
  GdkEvent $event1,
  GdkEvent $event2,
  gdouble $x,
  gdouble $y
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_events_get_distance (
  GdkEvent $event1,
  GdkEvent $event2,
  gdouble $distance
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_events_pending ()
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_get_show_events ()
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_set_show_events (gboolean $show_events)
  is native(gdk)
  is export
{ * }

sub gdk_setting_get (Str $name, GValue $value)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get ()
  returns GdkEvent
  is native(gdk)
  is export
{ * }

sub gdk_event_get_axis (GdkEvent $event, uint32 $axis_use, gdouble $value)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_button (GdkEvent $event, guint $button)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_click_count (GdkEvent $event, guint $click_count)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_coords (GdkEvent $event, gdouble $x_win, gdouble $y_win)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_event_sequence (GdkEvent $event)
  returns GdkEventSequence
  is native(gdk)
  is export
{ * }

sub gdk_event_get_event_type (GdkEvent $event)
  returns uint32 # GdkEventType
  is native(gdk)
  is export
{ * }

sub gdk_event_get_keycode (GdkEvent $event, guint16 $keycode)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_keyval (GdkEvent $event, guint $keyval)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_pointer_emulated (GdkEvent $event)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_root_coords (
  GdkEvent $event,
  gdouble $x_root,
  gdouble $y_root
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_scancode (GdkEvent $event)
  returns int32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_scroll_deltas (
  GdkEvent $event,
  gdouble $delta_x,
  gdouble $delta_y
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_scroll_direction (
  GdkEvent $event,
  uint32 $direction                       # GdkScrollDirection $direction
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_seat (GdkEvent $event)
  returns GdkSeat
  is native(gdk)
  is export
{ * }

sub gdk_event_get_state (
  GdkEvent $event,
  uint32 $state                           # GdkModifierType $state
)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_time (GdkEvent $event)
  returns guint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_window (GdkEvent $event)
  returns GdkWindow
  is native(gdk)
  is export
{ * }

sub gdk_event_handler_set (
  &handler (GdkEventAny, Pointer),
  gpointer $data,
  GDestroyNotify $notify
)
  is native(gdk)
  is export
{ * }

sub gdk_event_is_scroll_stop_event (GdkEvent $event)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_new (uint32 $type)
  returns GdkEvent
  is native(gdk)
  is export
{ * }

sub gdk_event_peek ()
  returns GdkEvent
  is native(gdk)
  is export
{ * }

sub gdk_event_put (GdkEvent $event)
  is native(gdk)
  is export
{ * }

sub gdk_event_request_motions (GdkEventMotion $event)
  is native(gdk)
  is export
{ * }

sub gdk_event_sequence_get_type ()
  returns GType
  is native(gdk)
  is export
{ * }

sub gdk_event_triggers_context_menu (GdkEvent $event)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_event_get_screen (GdkEvent $event)
  returns GdkScreen
  is native(gdk)
  is export
{ * }

sub gdk_event_get_device (GdkEvent $event)
  returns GdkDevice
  is native(gdk)
  is export
{ * }

sub gdk_event_get_source_device (GdkEvent $event)
  returns GdkDevice
  is native(gdk)
  is export
{ * }

sub gdk_event_get_device_tool (GdkEvent $event)
  returns GdkDeviceTool
  is native(gdk)
  is export
{ * }

sub gdk_event_set_screen (GdkEvent $event, GdkScreen $screen)
  is native(gdk)
  is export
{ * }

sub gdk_event_set_device (GdkEvent $event, GdkDevice $device)
  is native(gdk)
  is export
{ * }

sub gdk_event_set_source_device (GdkEvent $event, GdkDevice $device)
  is native(gdk)
  is export
{ * }

sub gdk_event_set_device_tool (GdkEvent $event, GdkDeviceTool $tool)
  is native(gdk)
  is export
{ * }
