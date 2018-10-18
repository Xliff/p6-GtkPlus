use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::<name> {
  has %!signals-<name>;

  # Copy for each signal.
  method connect-<sigName> (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-<name>{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-<sigName>($obj, $signal,
        -> $, <params>, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, <params>, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-<name>{$signal}[0].tap(&handler) with &handler;
    %!signals-<name>{$signal}[0];
  }

}

# Define for each signal
sub g-connect-<sigName>(
  Pointer $app,
  Str $name,
  &handler (<params>, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
