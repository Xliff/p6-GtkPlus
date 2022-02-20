use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::ScrolledWindow:ver<3.0.1146> {
  has %!signals-sw;

  # (guint, guint) --> guint
  method connect-scroll-child (
    $obj,
    $signal = 'scroll-child',
    &handler?
  ) {
    my $hid;
    %!signals-sw{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-scroll-child($obj, $signal,
        -> $, $ui1, $ui2, $ud --> guint {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ui1, $ui2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sw{$signal}[0].tap(&handler) with &handler;
    %!signals-sw{$signal}[0];
  }

}

# Define for each signal
sub g-connect-scroll-child(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, guint, Pointer --> guint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
