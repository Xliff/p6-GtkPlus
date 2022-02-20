use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;

role GTK::Roles::Signals::ListBox:ver<3.0.1146> {
  has %!signals-lb;

  # Copy for each signal.
  method connect-listboxrow (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-lb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-listboxrow($obj, $signal,
        -> $, $lbr, $ud {
          CATCH {
            default { note $_ }
          }

          $s.emit( [self, $lbr, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-lb{$signal}[0].tap(&handler) with &handler;
    %!signals-lb{$signal}[0];
  }

}

# Define for each signal
sub g-connect-listboxrow(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkListBoxRow, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
