use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GLib::Raw::Types;

role GIO::DBus::Roles::Signals::AuthObserver {
  has %!signals-dao;

  # GDBusAuthObserver, gchar, gpointer --> gboolean
  method connect-allow-mechanism (
    $obj,
    $signal = 'allow-mechanism',
    &handler?
  ) {
    my $hid;
    %!signals-dao{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-allow-mechanism($obj, $signal,
        -> $, $g, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $g, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dao{$signal}[0].tap(&handler) with &handler;
    %!signals-dao{$signal}[0];
  }

  # GDBusAuthObserver, GIOStream, GCredentials, gpointer --> gboolean
  method connect-authorize-authenticated-peer (
    $obj,
    $signal = 'authorize-authenticated-peer',
    &handler?
  ) {
    my $hid;
    %!signals-dao{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-authorize-authenticated-peer($obj, $signal,
        -> $, $ios, $c, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ios, $c, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dao{$signal}[0].tap(&handler) with &handler;
    %!signals-dao{$signal}[0];
  }

}

# GDBusAuthObserver, gchar, gpointer --> gboolean
sub g-connect-allow-mechanism(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GDBusAuthObserver, GIOStream, GCredentials, gpointer --> gboolean
sub g-connect-authorize-authenticated-peer(
  Pointer $app,
  Str $name,
  &handler (Pointer, GIOStream, GCredentials, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
