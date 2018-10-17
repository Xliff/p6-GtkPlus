use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

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
        -> $o, $e, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $o, $e, $ud] );
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
        -> $c, $w, $ud {
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
        -> $crt, $p, $ud {
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

sub g_connect_string(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
