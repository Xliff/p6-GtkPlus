use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

role GTK::Roles::Signals::Container {
  has %!signals-Container;

  # Copy for each signal.
  method connect-container-signal (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-Container{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_container($obj, $signal,
        -> $c, $w, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $w, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-Container{$signal}[0].tap(&handler) with &handler;
    %!signals-Container{$signal}[0];
  }

}

# Define for each signal
sub g_connect_container(
  Pointer $app,
  Str $name,
  &handler (GtkContainer, GtkWidget, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
