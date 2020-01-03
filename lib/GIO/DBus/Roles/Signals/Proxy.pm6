use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::Proxy {
  has %!signals-dp;

  # GDBusProxy, GVariant, GStrv, gpointer
  method connect-g-properties-changed (
    $obj,
    $signal = 'g-properties-changed',
    &handler?
  ) {
    my $hid;
    %!signals-dp{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-g-properties-changed($obj, $signal,
        -> $, $v, $sv, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $v, $sv, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dp{$signal}[0].tap(&handler) with &handler;
    %!signals-dp{$signal}[0];
  }

  # GDBusProxy, gchar, gchar, GVariant, gpointer
  method connect-g-signal (
    $obj,
    $signal = 'g-signal',
    &handler?
  ) {
    my $hid;
    %!signals-dp{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-g-signal($obj, $signal,
        -> $, $s1, $s2, $v, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $s1, $s2, $v, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dp{$signal}[0].tap(&handler) with &handler;
    %!signals-dp{$signal}[0];
  }

}

# GDBusProxy, GVariant, GStrv, gpointer
sub g-connect-g-properties-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, GVariant, GStrv, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GDBusProxy, gchar, gchar, GVariant, gpointer
sub g-connect-g-signal(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Str, GVariant, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
