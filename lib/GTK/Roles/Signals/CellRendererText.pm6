use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::CellRendererText {
  has %!signals-crt;

  # Copy for each signal.
  method connect-edited (
    $obj,
    $signal = 'edited',
    &handler?
  ) {
    my $hid;
    %!signals-crt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_edited($obj, $signal,
        -> $crt, $p, $t, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $p, $t, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-crt{$signal}[0].tap(&handler) with &handler;
    %!signals-crt{$signal}[0];
  }

}

# Define for each signal
sub g_connect_edited(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
