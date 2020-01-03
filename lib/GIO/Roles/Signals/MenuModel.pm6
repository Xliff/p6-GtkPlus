use v6.c;

use NativeCall;

use GLib::Raw::Types;

role GIO::Roles::Signals::MenuModel {
  has %!signals-mm;

  method connect-items-changed(
    $obj,
    $signal = 'items-changed',
    &handler?
  ) {
    my $hid;
    %!signals-mm{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-items-changed($obj, $signal,
        -> $, $i1, $i2, $i3, $ud  {
            CATCH { default { note($_) } }

            $s.emit( [self, $i1, $i2, $i3, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-mm{$signal}[0].tap(&handler) with &handler;
    %!signals-mm{$signal}[0];
  }

}

sub g-connect-items-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, gint, Pointer),
  Pointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
