use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::Application:ver<3.0.1146> {
  has %!signals-app;

  # Copy for each signal.
  method connect-application-signal (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-app{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_application_signal($obj, $signal,
        -> $a, $w, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-app{$signal}[0].tap(&handler) with &handler;
    %!signals-app{$signal}[0];
  }

}

# Define for each signal
sub g_connect_application_signal(
  Pointer $app,
  Str $name,
  &handler (Pointer, Pointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
