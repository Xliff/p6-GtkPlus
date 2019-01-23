use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Seat;

sub gdk_seat_get_capabilities (GdkSeat $seat)
  returns uint32 # GdkSeatCapabilities
  is native(gdk)
  is export
  { * }

sub gdk_seat_get_display (GdkSeat $seat)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_seat_get_keyboard (GdkSeat $seat)
  returns GdkDevice
  is native(gdk)
  is export
  { * }

sub gdk_seat_get_pointer (GdkSeat $seat)
  returns GdkDevice
  is native(gdk)
  is export
  { * }

sub gdk_seat_get_slaves (
  GdkSeat $seat,
  guint32  $capabilities                  # GdkSeatCapabilities $capabilities,
)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_seat_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_seat_grab (
  GdkSeat $seat,
  GdkWindow $window,
  guint32  $capabilities,                 # GdkSeatCapabilities $capabilities,
  gboolean $owner_events,
  GdkCursor $cursor,
  GdkEvent $event,
  GdkSeatGrabPrepareFunc $prepare_func,
  gpointer $prepare_func_data
)
  returns guint32 # GdkGrabStatus
  is native(gdk)
  is export
  { * }

sub gdk_seat_ungrab (GdkSeat $seat)
  is native(gdk)
  is export
  { * }
