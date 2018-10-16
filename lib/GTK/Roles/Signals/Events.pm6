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
            default { $s.quit($_) }
          }

          $s.emit( [self, $o, $e, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %signals{$signal}[0].tap(&handler) with &handler;
    %signals{$signal}[0];
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
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
