use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::Connection {
  has %!signals-c;

  # GDBusConnection, gboolean, GError, gpointer
  method connect-closed (
    $obj,
    $signal = 'closed',
    &handler?
  ) {
    my $hid;
    %!signals-c{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-closed($obj, $signal,
        -> $, $b, $e, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $b, $e, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-c{$signal}[0].tap(&handler) with &handler;
    %!signals-c{$signal}[0];
  }

}

# GDBusConnection, gboolean, GError, gpointer
sub g-connect-closed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gboolean, GError, Pointer),
  Pointer $data,
  uint32 $flags
)
returns uint64
is native(gobject)
is symbol('g_signal_connect_object')
{ * }
