use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::SpinButton {
  has %!signals-sp;

  # GtkSpinButton, gdouble is rw, gpointer --> gint
  # NOTE: Due to limitations in the current implementation, the
  #       best way to write the gdouble pointer is as a CArray[num64]
  #       with only ONE value. So you'd only write to $d[0] or risk
  #       a segmentation fault!
  method connect-input (
    $obj,
    $signal = 'input',
    &handler?
  ) {
    my $hid;
    %!signals-sp{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-input($obj, $signal,
        -> $, $d, $ud --> gint {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $d, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sp{$signal}[0].tap(&handler) with &handler;
    %!signals-sp{$signal}[0];
  }

}

# Define for each signal
sub g-connect-input(
  Pointer $app,
  Str $name,
  &handler (Pointer, CArray[num64], Pointer --> gint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
