use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Generic {
  has %!signals-generic;

  # Copy for each signal.
  method connect_event (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_event($obj, $signal,
        -> $, $e, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $e, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_widget (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_widget($obj, $signal,
        -> $, $w, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $w, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_string (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_string($obj, $signal,
        -> $, $p, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $p, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_int (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_int($obj, $signal,
        -> $, $i, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_pointer (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_pointer($obj, $signal,
        -> $, $p, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $p, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_movement_step (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_movement_step($obj, $signal,
        -> $, $ms, $nc, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ms, $nc, $ud ] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_move_cursor (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_cursor($obj, $signal,
        -> $, $ms, $c, $es, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ms, $c, $es, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_activate_link (
    $obj,
    $signal = 'activate_link',
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_activate_link($obj, $signal,
        -> $, $uri, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $uri, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect_menu (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_menu($obj, $signal,
        -> $, $m, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $m, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

}

# Define for each signal
sub g_connect_event(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
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
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_string(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_int(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_pointer(
  Pointer $app,
  Str $name,
  &handler (Pointer, Pointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
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
  is native('gobject_2.0')
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
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_move_cursor(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, gint, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
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
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }
