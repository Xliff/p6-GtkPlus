use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Dialog {
  has %!signals-d;

  # Copy for each signal.
  method connect-response (
    $obj,
    $signal = 'response',
    &handler?
  ) {
    my $hid;
    %!signals-d{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_response($obj, $signal,
        -> $d, $rid, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $rid, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-d{$signal}[0].tap(&handler) with &handler;
    %!signals-d{$signal}[0];
  }

}

# Define for each signal
sub g_connect_response(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
