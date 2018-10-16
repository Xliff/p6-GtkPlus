use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Window {
  has %!signals-win;

  # Copy for each signal.
  method connect-enable-debugging (
    $obj,
    $signal = 'connect-enable-debugging',
    &handler?
  ) {
    my $hid;
    %!signals-win{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_enable_debugging($obj, $signal,
        -> $w, $t, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $t, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-win{$signal}[0].tap(&handler) with &handler;
    %!signals-win{$signal}[0];
  }

  # Copy for each signal.
  method connect-set-focus (
    $obj,
    $signal='set-focus',
    &handler?
  ) {
    my $hid;
    %!signals-win{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_set_focus($obj, $signal,
        -> $w, $widget, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $widget, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-win{$signal}[0].tap(&handler) with &handler;
    %!signals-win{$signal}[0];
  }

}

# Define for each signal
sub g_connect_enable_debugging(
  Pointer $app,
  Str $name,
  &handler (GtkWindow, gboolean, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# Define for each signal
sub g_connect_set_focus (
  Pointer $app,
  Str $name,
  &handler (GtkWindow, GtkWidget, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
