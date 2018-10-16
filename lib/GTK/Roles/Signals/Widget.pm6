use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals::Widget {
  has %!signals-widget;

  method connect-draw(
    $obj,
    $signal = 'draw',
    &handler?
  ) {
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      g_connect_draw($obj, $signal,
        -> $, $cr, $ud --> uint32 {
          $s.emit( [self, $cr, $ud] );
          CATCH { default { $s.quit($_) } }
          0;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }
}

sub g_connect_draw(
  Pointer $app,
  Str $bane,
  &handler (Pointer, Pointer, Pointer --> uint32),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  is export
  { * }
