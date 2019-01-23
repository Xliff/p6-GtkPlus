use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Seat;;

use GTK::Roles::Types;
use GTK::Roles::Signals::Generic;

use GTK::Compat::Device;
use GTK::Compat::Display;

class GTK::Compat::Seat {
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals::Generic;

  has GdkSeat $!s;

  submethod BUILD(:$seat) {
    $!s = $seat
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_capabilities is also<get-capabilities> {
    gdk_seat_get_capabilities($!s);
  }

  method get_display is also<get-display> {
    GTK::Compat::Display.new( gdk_seat_get_display($!s) );
  }

  method get_keyboard is also<get-keyboard> {
    GTK::Compat::Device.new( gdk_seat_get_keyboard($!s) );
  }

  method get_pointer is also<get-pointer> {
    GTK::Compat::Device.new( gdk_seat_get_pointer($!s) );
  }

  method get_slaves (Int() $capabilities) is also<get-slaves> {
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

