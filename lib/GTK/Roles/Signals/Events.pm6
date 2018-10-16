use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

role GTK::Roles::Signals::Events {

  # Copy for each signal.
  method connect-event (
    $obj,
    $signal,
    %signals,
    &handler?
  ) {
    my $hid;
    %signals{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_event($obj, $signal,
        -> $o, $e, $ud {
          CATCH {
            default { note $_; }
          }

          $s.emit( [self, $o, $e, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
<<<<<<< HEAD
    %signals{$signal}[0].tap(&handler) with &handler;
    %signals{$signal}[0];
=======
    %!signals-cb{$signal}[0].tap(&handler) with &handler;
    %!signals-cb{$signal}[0];
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45
  }

}

# Define for each signal
sub g_connect_event(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
