use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Generic {
  has %!signals-generic;

  # Copy for each signal.
  method connect-event (
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

  method connect-widget (
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

  method connect-string (
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

  method connect-strstr (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_strstr($obj, $signal,
        -> $, $s1, $s2, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $s1, $s2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect-int (
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

  method connect-uint (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_uint($obj, $signal,
        -> $, $ui, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ui, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect-pointer (
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

  method connect-movement-step (
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

  method connect-move-cursor (
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

  method connect-activate-link (
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

  method connect-menu (
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

  method connect-int-rint (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_int_ruint($obj, $signal,
        -> $, $i, $ud --> gint {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $i, $ud, $r] );
          $r.r .= Int if $r.r ~~ (Bool, Enumeration).any;
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect-int-ruint (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_int_ruint($obj, $signal,
        -> $, $i, $ud --> guint {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $i, $ud, $r] );
          $r.r .= Int if $r.r ~~ (Bool, Enumeration).any;
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-generic{$signal}[0].tap(&handler) with &handler;
    %!signals-generic{$signal}[0];
  }

  method connect-uint-ruint (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-generic{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_uint_ruint($obj, $signal,
        -> $, $ui, $ud --> guint {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ui, $ud, $r] );
          $r.r .= Int if $r.r ~~ (Bool, Enumeration).any;
          $r.r;
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

sub g_connect_strstr(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Str, Pointer),
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

# Define for each signal
sub g_connect_uint(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
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

sub g_connect_int_ruint(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer --> guint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_int_rint(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer --> gint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_uint_ruint(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, Pointer --> guint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject_2.0')
  is symbol('g_signal_connect_object')
  { * }
