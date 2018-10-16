use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::AppButton {
  has %!signals-ab;

  # Copy for each signal.
  method connect-custom-item-activated (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ab{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_custom_item_activated($obj, $signal,
        -> $ac, $item, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $item, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ab{$signal}[0].tap(&handler) with &handler;
    %!signals-ab{$signal}[0];
  }

}

# Define for each signal
sub g_connect_custom_item_activated(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
