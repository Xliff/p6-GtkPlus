use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals::CellRendererAccel {
  has %!signals-cra;

  method connect-accel-edited (
    $obj,
    $signal = 'accel-edited',
    &handler?
  ) {
    my $hid;
    %!signals-cra{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_accel_edited($obj, $signal,
        -> $ca, $ps, $ak, $am, $hk, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ps, $ak, $am, $hk, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-cra{$signal}[0].tap(&handler) with &handler;
    %!signals-cra{$signal}[0];
  }

}

# Define for each signal
sub g_connect_accel_edited (
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, guint, guint, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
