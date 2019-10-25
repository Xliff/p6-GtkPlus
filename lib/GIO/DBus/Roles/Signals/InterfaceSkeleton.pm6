use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::InterfaceSkeleton {
  has %!signals-dis;

  # GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
  method connect-g-authorize-method (
    $obj,
    $signal = 'g-authorize-method',
    &handler?
  ) {
    my $hid;
    %!signals-dis{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-g-authorize-method($obj, $signal,
        -> $, $, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dis{$signal}[0].tap(&handler) with &handler;
    %!signals-dis{$signal}[0];
  }

}

# GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
sub g-connect-g-authorize-method(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusMethodInvocation, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
