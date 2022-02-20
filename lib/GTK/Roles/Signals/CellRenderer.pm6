use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::CellRenderer:ver<3.0.1146> {
  has %!signals-cr;

  # Copy for each signal.
  method connect-editing-started (
    $obj,
    $signal = 'editing-started',
    &handler?
  ) {
    my $hid;
    %!signals-cr{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_editing_started($obj, $signal,
        -> $cr, $ce, $p, $ud {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ce, $p, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-cr{$signal}[0].tap(&handler) with &handler;
    %!signals-cr{$signal}[0];
  }

}

# Define for each signal
sub g_connect_editing_started(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkCellEditable, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
