use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Signals::Generic;

role GTK::Compat::Roles::Signals::Device {
  also does GTK::Roles::Signals::Generic;

  has %!signals-device;

  # GdkDevice, GdkDeviceTool, gpointer --> void
  method connect-tool-changed (
    $obj,
    $signal = 'tool-changed',
    &handler?
  ) {
    my $hid;
    %!signals-device{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tool-changed($obj, $signal,
        -> $, $t, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $t, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-device{$signal}[0].tap(&handler) with &handler;
    %!signals-device{$signal}[0];
  }
}

# GdkDevice, GdkDeviceTool, gpointer --> void
sub g-connect-tool-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkDeviceTool, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
