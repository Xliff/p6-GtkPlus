use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

role GIO::Roles::Signals::TlsConnection {
  has %!signals-tc;

  # GTlsConnection, GTlsCertificate, GTlsCertificateFlags, gpointer --> gboolean
  method connect-accept-certificate (
    $obj,
    $signal = 'accept-certificate',
    &handler?
  ) {
    my $hid;
    %!signals-tc{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-accept-certificate($obj, $signal,
        -> $, $c, $cf, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $c, $cf, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-tc{$signal}[0].tap(&handler) with &handler;
    %!signals-tc{$signal}[0];
  }

}

# GTlsConnection, GTlsCertificate, GTlsCertificateFlags, gpointer --> gboolean
sub g-connect-accept-certificate(
  Pointer $app,
  Str $name,
  &handler (Pointer, GTlsCertificate, GTlsCertificateFlags, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
