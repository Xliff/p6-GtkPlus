use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

role GIO::Roles::Signals::FileMonitor {
  has %signals-m;

  # GFileMonitor, GFile, GFile, GFileMonitorEvent, gpointer
  method connect-changed (
    $obj,
    $signal = 'changed',
    &handler?
  ) {
    my $hid;
    %!signals-m{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-changed($obj, $signal,
        -> $, $f1, $f2, $fme, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $f1, $f2, $fme, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-m{$signal}[0].tap(&handler) with &handler;
    %!signals-m{$signal}[0];
  }

}

# GFileMonitor, GFile, GFile, GFileMonitorEvent, gpointer
sub g-connect-changed(
  Pointer $app,
  Str $name,
  &handler (GFileMonitor, GFile, GFile, GFileMonitorEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
