use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::MenuShell {
  has %!signals-ms;

  # Copy for each signal.
  method connect-insert (
    $obj,
    $signal = 'insert',
    &handler?
  ) {
    my $hid;
    %!signals-ms{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert($obj, $signal,
        -> $, $w, $i, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ms{$signal}[0].tap(&handler) with &handler;
    %!signals-ms{$signal}[0];
  }

}

# Define for each signal
sub g-connect-insert(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
