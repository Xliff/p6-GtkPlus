use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Entry {
  has %!signals-e;

  # Copy for each signal.
  method connect-delete-from-cursor (
    $obj,
    $signal = 'connect-delete-from-cursor',
    &handler?
  ) {
    my $hid;
    %!signals-e{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-delete-from-cursor($obj, $signal,
        -> $, $t, $c, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $t, $c, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-e{$signal}[0].tap(&handler) with &handler;
    %!signals-e{$signal}[0];
  }

  method connect-entry-icon (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-e{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-entry-icon($obj, $signal,
        -> $, $ip, $ev, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ip, $ev, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-e{$signal}[0].tap(&handler) with &handler;
    %!signals-e{$signal}[0];
  }

  method connect-move-cursor (
    $obj,
    $signal = 'move-cursor',
    &handler?
  ) {
    my $hid;
    %!signals-e{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-move-cursor($obj, $signal,
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
    %!signals-e{$signal}[0].tap(&handler) with &handler;
    %!signals-e{$signal}[0];
  }

}

# Define for each signal
sub g-connect-delete-from-cursor(
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

sub g-connect-entry-icon(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-move-cursor(
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
