use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

role GIO::DBus::Roles::Signals::ObjectSkeleton {
  has %!signals-dos;

  # GDBusObjectSkeleton, GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
  method connect-authorize-method (
    $obj,
    $signal = 'authorize-method',
    &handler?
  ) {
    my $hid;
    %!signals-dos{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-authorize-method($obj, $signal,
        -> $os1, $os2, $mi, $ud --> gboolean {
          CATCH {
            default { $s.note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $os1, $os2, $mi, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-dos{$signal}[0].tap(&handler) with &handler;
    %!signals-dos{$signal}[0];
  }

}

# GDBusObjectSkeleton, GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
sub g-connect-authorize-method(
  Pointer $app,
  Str $name,
  &handler (Pointer, GDBusInterfaceSkeleton, GDBusMethodInvocation, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
