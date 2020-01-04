use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Seat;;

use GDK::Device;
use GDK::Display;

use GDK::Roles::Signals::Device;

class GDK::Seat {
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
  method get_capabilities
    is also<
      get-capabilities
      capabilities
    >
  {
    GdkSeatCapabilitiesEnum( gdk_seat_get_capabilities($!s) );
  }

  method get_display (:$raw = False) is also<get-display display> {
    my $d = gdk_seat_get_display($!s)

    $d ??
      ( $raw ?? $d !! GDK::Display.new($d) )
      !!
      Nil;
  }

  method get_keyboard (:$raw = False) is also<get-keyboard keyboard> {
    my $dev = gdk_seat_get_keyboard($!s)

    $dev ??
      ( $raw ?? $d !! GDK::Device.new($dev) )
      !!
      Nil;
  }

  method get_pointer (:$raw = False) is also<get-pointer pointer> {
    my $dev = gdk_seat_get_pointer($!s);

    $dev ??
      ( $raw ?? $d !! GDK::Device.new($dev) )
      !!
      Nil;
  }

  method get_slaves (Int() $capabilities, :$glist = False, :$raw = False)
    is also<get-slaves slaves>
  {
    my guint $c = $capabilities;

    my $sl = gdk_seat_get_slaves($!s, $c);

    return Nil unless $sl;
    return $sl if $glist;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[GdkDevice];
    $raw ?? $sl.Array !! $sl.Array.map({ GDK::Device.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_seat_get_type, $n, $t );
  }

  method grab (
    GdkWindow() $window,
    Int() $capabilities,
    Int() $owner_events,
    GdkCursor() $cursor,
    GdkEvent() $event is copy,
    GdkSeatGrabPrepareFunc $prepare_func = Pointer,
    gpointer $prepare_func_data = Pointer;
  ) {
    my guint32 ($c, $oe) = ($capabilities, $owner_events);

    GdkGrabStatusEnum(
      gdk_seat_grab(
        $!s,
        $window,
        $c,
        $oe,
        $cursor,
        $event,
        $prepare_func,
        $prepare_func_data
      )
    );
  }

  method ungrab {
    gdk_seat_ungrab($!s);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
