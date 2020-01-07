use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::EntryCompletion {
  has %!signals-ec;

  # Copy for each signal.
  method connect-on-match (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ec{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-on-match($obj, $signal,
        -> $, $tm, $ti, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $tm, $ti, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ec{$signal}[0].tap(&handler) with &handler;
    %!signals-ec{$signal}[0];
  }

}

# Define for each signal
sub g-connect-on-match(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTreeModel, GtkTreeIter, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
