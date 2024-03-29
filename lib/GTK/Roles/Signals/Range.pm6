use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;

role GTK::Roles::Signals::Range:ver<3.0.1146> {
  has %!signals-r;

  # (GtkScrollType, gdouble)
  method connect-change-value (
    $obj,
    $signal = 'change-value',
    &handler?
  ) {
    my $hid;
    %!signals-r{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-change-value($obj, $signal,
        -> $ui, $d, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ui, $d, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-r{$signal}[0].tap(&handler) with &handler;
    %!signals-r{$signal}[0];
  }

}

# Define for each signal
sub g-connect-change-value(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, gdouble, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
