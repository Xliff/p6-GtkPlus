use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Seat;;

use GTK::Roles::Types;

use GDK::Roles::Signals::Device;

use GDK::Device;
use GDK::Display;

class GDK::Seat {
  also does GTK::Roles::Types;
  also does GDK::Roles::Signals::Device;

  has GdkSeat $!s is implementor;

  submethod BUILD(:$seat) {
    $!s = $seat
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GdkSeat, GdkDevice, gpointer --> void
  method device-added {
    self.connect-device($!s, 'device-added');
  }

  # Is originally:
  # GdkSeat, GdkDevice, gpointer --> void
  method device-removed {
    self.connect-device($!s, 'device-removed');
  }

  # Is originally:
  # GdkSeat, GdkDeviceTool, gpointer --> void
  method tool-added {
    self.connect-device-tool($!s, 'tool-added');
  }

  # Is originally:
  # GdkSeat, GdkDeviceTool, gpointer --> void
  method tool-removed {
    self.connect-device-tool($!s, 'tool-removed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_capabilities is also<get-capabilities capabilities> {
    gdk_seat_get_capabilities($!s);
  }

  method get_display is also<get-display display> {
    GDK::Display.new( gdk_seat_get_display($!s) );
  }

  method get_keyboard is also<get-keyboard keyboard> {
    GDK::Device.new( gdk_seat_get_keyboard($!s) );
  }

  method get_pointer is also<get-pointer pointer> {
    GDK::Device.new( gdk_seat_get_pointer($!s) );
  }

  method get_slaves (Int() $capabilities) is also<get-slaves slaves> {
    my guint $c = self.RESOLVE-UINT($capabilities);
    gdk_seat_get_slaves($!s, $c);
  }

  method get_type is also<get-type> {
    gdk_seat_get_type();
  }

  method grab (
    GdkWindow() $window,
    Int() $capabilities,
    Int() $owner_events,
    GdkCursor() $cursor,
    GdkEvent() $event,
    GdkSeatGrabPrepareFunc $prepare_func = Pointer,
    gpointer $prepare_func_data = Pointer;
  ) {
    my guint32 ($c, $oe) = self.RESOLVE-UINT($capabilities, $owner_events);
    gdk_seat_grab(
      $!s,
      $window,
      $c,
      $oe,
      $cursor,
      $event,
      $prepare_func,
      $prepare_func_data
    );
  }

  method ungrab {
    gdk_seat_ungrab($!s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
