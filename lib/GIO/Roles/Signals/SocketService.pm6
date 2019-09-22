use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ReturnedValue;

role GIO::Roles::Signals::SocketService {
  has %!signals-ss;

  # GSocketService, GSocketConnection, GObject, gpointer --> gboolean
  method connect-incoming (
    $obj,
    $signal = 'incoming',
    &handler?
  ) {
    my $hid;
    %!signals-ss{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-incoming($obj, $signal,
        -> $ss, $sc, $go, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $sc, $go, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ss{$signal}[0].tap(&handler) with &handler;
    %!signals-ss{$signal}[0];
  }

}

# GSocketService, GSocketConnection, GObject, gpointer --> gboolean
sub g-connect-incoming(
  Pointer $app,
  Str $name,
  &handler (Pointer, GSocketConnection, GObject, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
