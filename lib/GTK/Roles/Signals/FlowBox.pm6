use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::FlowBox {
  has %!signals-fb;

  # Copy for each signal.
  method connect-child-activated (
    $obj,
    $signal = 'child-activated',
    &handler?
  ) {
    my $hid;
    %!signals-fb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-child-activated($obj, $signal,
        -> $, $fbc, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $fbc, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-fb{$signal}[0].tap(&handler) with &handler;
    %!signals-fb{$signal}[0];
  }

}

# Define for each signal
sub g-connect-child-activated(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkFlowBoxChild, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
