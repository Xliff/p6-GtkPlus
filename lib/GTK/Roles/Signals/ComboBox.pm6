use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::ComboBox {
  has %!signals-cb;

  # Copy for each signal.
  method connect-format-entry-text (
    $obj,
    $signal = 'format-entry-text',
    &handler?
  ) {
    my $hid;
    %!signals-cb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_format_entry_text($obj, $signal,
        -> $cb, $p, $ud --> Str {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $p, $ud, $r] );
          # die 'Return value is not a string!' unless $r.r ~~ Str;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-cb{$signal}[0].tap(&handler) with &handler;
    %!signals-cb{$signal}[0];
  }

  method connect-move-active (
    $obj,
    $signal = 'move-active',
    &handler?
  ) {
    my $hid;
    %!signals-cb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_move_active($obj, $signal,
        -> $cb, $st, $ud {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $st, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-cb{$signal}[0].tap(&handler) with &handler;
    %!signals-cb{$signal}[0];
  }

}

# Define for each signal
sub g_connect_format_entry_text(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer --> Str),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_move_active(
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
