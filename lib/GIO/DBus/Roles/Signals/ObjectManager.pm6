use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::ObjectManager {
  has %!signals-dom;

  # GDBusObjectManager, GDBusObject, GDBusInterface, gpointer
  method connect-interface (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-dom{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-interface($obj, $signal,
        -> $, $dbo, $dbi, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $dbo, $dbi, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dom{$signal}[0].tap(&handler) with &handler;
    %!signals-dom{$signal}[0];
  }

  # GDBusObjectManager, GDBusObject, gpointer
  method connect-object (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-dom{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-object($obj, $signal,
        -> $, $dbo, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $dbo, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dom{$signal}[0].tap(&handler) with &handler;
    %!signals-dom{$signal}[0];
  }

}

# GDBusObjectManager, GDBusObject, GDBusInterface, gpointer
sub g-connect-interface(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusObject, GDBusInterface, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GDBusObjectManager, GDBusObject, gpointer
sub g-connect-object(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusObject, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
