use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Entry {
  has %!signals-e;

  method connect-entry-icon (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-e{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-entry-icon($obj, $signal,
        -> $, $ip, $ev, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ip, $ev, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-e{$signal}[0].tap(&handler) with &handler;
    %!signals-e{$signal}[0];
  }

}

# Define for each signal

sub g-connect-entry-icon(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
