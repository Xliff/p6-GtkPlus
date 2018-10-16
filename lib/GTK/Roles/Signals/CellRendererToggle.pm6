use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::CellRendererToggle {
  has %!signals-crt;

  # Copy for each signal.
  method connect-toggled (
    $obj,
    $signal = 'toggled',
    &handler?
  ) {
    my $hid;
    %!signals-crt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_toggled($obj, $signal,
        -> $crt, $p, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $p, $ud, $r] );
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
sub g_connect_toggled(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
