use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::IconView {
  has %!signals-iv;

  method connect-activate-cursor-item (
    $obj,
    $signal = 'activate-cursor-item',
    &handler?
  ) {
    my $hid;
    %!signals-iv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_item_activated($obj, $signal,
        -> $iv, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }
          my $r = ReturnedValue.new;
          $s.emit( [self, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-iv{$signal}[0].tap(&handler) with &handler;
    %!signals-iv{$signal}[0];
  }

  method connect-item-activated (
    $obj,
    $signal = 'item-activated',
    &handler?
  ) {
    my $hid;
    %!signals-iv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_item_activated($obj, $signal,
        -> $iv, $tp, $ud {
          CATCH {
            default { note($_) }
          }
          my $r = ReturnedValue.new;
          $s.emit( [self, $tp, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-iv{$signal}[0].tap(&handler) with &handler;
    %!signals-iv{$signal}[0];
  }

  method connect-move-cursor (
    $obj,
    $signal = 'move-cursor',
    &handler?
  ) {
    my $hid;
    %!signals-iv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor($obj, $signal,
        -> $iv, $ms, $c, $ud {
          CATCH {
            default { note($_) }
          }
          my $r = ReturnedValue.new;
          $s.emit( [self, $ms, $c, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-iv{$signal}[0].tap(&handler) with &handler;
    %!signals-iv{$signal}[0];
  }

}

sub g_connect_activate_cursor_item(
  Pointer $app,
  Str $name,
  &handler (GtkIconView, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_item_activated(
  Pointer $app,
  Str $name,
  &handler (GtkIconView, GtkTreePath, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_move_cursor (
  Pointer $app,
  Str $name,
  &handler (GtkIconView, uint32, int32, Pointer --> uint32),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
