use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Widget;

role GTK::Roles::Signals::Widget {
  has %!signals-widget;

  method connect-widget-event(
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-widget-event($obj, $signal,
        -> $, $e, $ud --> uint32 {
          CATCH { default { $s.quit($_) } }

          my @valid-types = (Bool, Int);
          $s.emit( [self, $e, $ud, $r] );
          die 'Invalid return type' if $r.r ~~ @valid-types.any;
          $r.r = .Int if $r.r ~~ @valid-types.any;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  method connect-draw(
    $obj,
    $signal = 'draw',
    &handler?
  ) {
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      g-connect-draw($obj, $signal,
        -> $, $cr, $ud --> uint32 {
          $s.emit( [self, $cr, $ud] );
          CATCH { default { $s.quit($_) } }
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }
}

sub g-connect-widget-event(
  Pointer $app,
  Str $bane,
  &handler (Pointer, GdkEvent, Pointer --> uint32),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  is export
  { * }

sub g-connect-draw(
  Pointer $app,
  Str $bane,
  &handler (Pointer, CairoContext, Pointer --> uint32),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  is export
  { * }
