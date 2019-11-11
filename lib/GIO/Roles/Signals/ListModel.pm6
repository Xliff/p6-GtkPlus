use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GIO::Roles::Signals::ListModel {
  has %!signals-lm;

  # GListModel, guint, guint, guint, gpointer
  method connect-items-changed (
    $obj,
    $signal = 'items-changed',
    &handler?
  ) {
    my $hid;
    %!signals-lm{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-items-changed($obj, $signal,
        -> $, $i1, $i2, $i3, $ud {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $i1, $i2, $i3, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-lm{$signal}[0].tap(&handler) with &handler;
    %!signals-lm{$signal}[0];
  }

}

# GListModel, guint, guint, guint, gpointer
sub g-connect-items-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, guint, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
