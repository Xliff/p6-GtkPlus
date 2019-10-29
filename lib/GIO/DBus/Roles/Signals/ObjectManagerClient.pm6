use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::ObjectManagerClient {
  has %!signals-domc;

  # GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, GVariant, GStrv, gpointer
  method connect-interface-proxy-properties-changed (
    $obj,
    $signal = 'interface-proxy-properties-changed',
    &handler?
  ) {
    my $hid;
    %!signals-domc{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-interface-proxy-properties-changed($obj, $signal,
        -> $, $dop, $dp, $v, $sv, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $dop, $dp, $v, $sv, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-domc{$signal}[0].tap(&handler) with &handler;
    %!signals-domc{$signal}[0];
  }

  # GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, gchar, gchar, GVariant, gpointer
  method connect-interface-proxy-signal (
    $obj,
    $signal = 'interface-proxy-signal',
    &handler?
  ) {
    my $hid;
    %!signals-domc{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-interface-proxy-signal($obj, $signal,
        -> $, $dop, $dp, $s1, $s2, $v, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $dop, $dp, $s1, $s2, $v, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-domc{$signal}[0].tap(&handler) with &handler;
    %!signals-domc{$signal}[0];
  }

}
# GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, GVariant, GStrv, gpointer
sub g-connect-interface-proxy-properties-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusObjectProxy, GDBusProxy, GVariant, GStrv, Pointer),
  Pointer $data,
  uint32 $flags
)
returns uint64
is native(gobject)
is symbol('g_signal_connect_object')
{ * }

# GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, gchar, gchar, GVariant, gpointer
sub g-connect-interface-proxy-signal(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusObjectProxy, GDBusProxy, gchar, gchar, GVariant, Pointer),
  Pointer $data,
  uint32 $flags
)
returns uint64
is native(gobject)
is symbol('g_signal_connect_object')
{ * }
