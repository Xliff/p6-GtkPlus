use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GTK::Compat::Types;

role GIO::DBus::Roles::Signals::Server {
  has %!signals-ds;

  # GDBusServer, GDBusConnection, gpointer --> gboolean
  method connect-new-connection (
    $obj,
    $signal = 'new-connection',
    &handler?
  ) {
    my $hid;
    %!signals-ds{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-new-connection($obj, $signal,
        -> $, $dc, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $dc, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ds{$signal}[0].tap(&handler) with &handler;
    %!signals-ds{$signal}[0];
  }

}

# GDBusServer, GDBusConnection, gpointer --> gboolean
sub g-connect-new-connection(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusConnection, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
returns uint64
is native(gobject)
is symbol('g_signal_connect_object')
{ * }
