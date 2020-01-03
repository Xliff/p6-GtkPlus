use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::Object {
  has %!signals-do;

  # GDBusObject, GDBusInterface, gpointer
  method connect-interface (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-do{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-interface($obj, $signal,
        -> $, $, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-do{$signal}[0].tap(&handler) with &handler;
    %!signals-do{$signal}[0];
  }

}

# GDBusObject, GDBusInterface, gpointer
sub g-connect-interface(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusInterface, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
