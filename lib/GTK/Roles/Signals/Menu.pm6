use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::Menu:ver<3.0.1146> {
  has %!signals-menu;

  # Copy for each signal.
  method connect-popped-up (
    $obj,
    $signal = 'popped-up',
    &handler?
  ) {
    my $hid;
    %!signals-menu{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_popped_up($obj, $signal,
        -> $m, $flpr, $finr, $fx, $fy, $ud {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $flpr, $finr, $fx, $fy, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-menu{$signal}[0].tap(&handler) with &handler;
    %!signals-menu{$signal}[0];
  }

}

# Define for each signal
sub g_connect_popped_up(
  Pointer $app,
  Str $name,
  &handler (GtkMenu, Pointer, Pointer, gboolean, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
