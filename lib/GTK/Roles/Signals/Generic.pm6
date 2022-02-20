use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Subs:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

use GLib::Roles::Signals::Generic;

role GTK::Roles::Signals::Generic:ver<3.0.1146> {
  also does GLib::Roles::Signals::Generic;

  has %!signals-gtk;

  method connect-event (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_event>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_event($obj, $signal,
        -> $, $e, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $e, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-widget (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_widget>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_widget($obj, $signal,
        -> $, $w, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-movement-step (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_movement_step>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_movement_step($obj, $signal,
        -> $, $ms, $nc, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ms, $nc, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-move-cursor1 (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_move_cursor1>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor1($obj, $signal,
        -> $, $ms, $c, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ms, $c, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-move-cursor2 (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_move_cursor2>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor2($obj, $signal,
        -> $, $ms, $c, $es, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ms, $c, $es, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-activate-link (
    $obj,
    $signal = 'activate_link',
    &handler?
  )
    is also<connect_activate_link>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_activate_link($obj, $signal,
        -> $, $uri, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $uri, $ud, $r] );
          # die 'Invalid return type' if $r.r ~~ Bool;
          # $r.r = .Int if $r.r ~~ Bool;
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-menu (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_menu>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_menu($obj, $signal,
        -> $, $m, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $m, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

  method connect-delete (
    $obj,
    $signal,
    &handler?
  )
    is also<connect_delete>
  {
    my $hid;
    %!signals-gtk{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-delete($obj, $signal,
        -> $, $t, $c, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $t, $c, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-gtk{$signal}[0].tap(&handler) with &handler;
    %!signals-gtk{$signal}[0];
  }

}

sub g_connect(
  Pointer $app,
  Str $name,
  &handler (GtkWidget $h_widget, Pointer $h_data),
  Pointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# Define for each signal
sub g_connect_event(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_widget(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_menu(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkMenu, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_movement_step(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_move_cursor1 (
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_move_cursor2(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, gint, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g_connect_activate_link(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-delete(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
