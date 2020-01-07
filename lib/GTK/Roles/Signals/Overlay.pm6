use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Overlay {
  has %!signals-o;

  # Copy for each signal.
  method connect-widget-rect (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-o{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-widget-rect($obj, $signal,
        -> $, $w, $rect, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $rect, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-o{$signal}[0].tap(&handler) with &handler;
    %!signals-o{$signal}[0];
  }

}

# Define for each signal
sub g-connect-widget-rect(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, GdkRectangle, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
