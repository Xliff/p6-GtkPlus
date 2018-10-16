use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

role GTK::Roles::Signals::MenuItem {
  has %!signals-mi;

  # Copy for each signal.
  method connect-toggle-size-allocate (
    $obj,
    $signal = 'toggle-size-allocate',
    &handler?
  ) {
    my $hid;
    %!signals-mi{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_toggle_size_allocate($obj, $signal,
        -> $mu, $i, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $i, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-mi{$signal}[0].tap(&handler) with &handler;
    %!signals-mi{$signal}[0];
  }

  method connect-toggle-size-request (
    $obj,
    $signal = 'toggle-size-request',
    &handler?
  ) {
    my $hid;
    %!signals-mi{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_toggle_size_request($obj, $signal,
        -> $mi, $ptr, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ptr, $ud] );
        },
        OpaquePointer, 0
      );

      [ $s.Supply, $obj, $hid];
    };
    %!signals-mi{$signal}[0].tap(&handler) with &handler;
    %!signals-mi{$signal}[0];
  }

}

# Define for each signal
sub g_connect_toggle_size_allocate (
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_toggle_size_request(
  Pointer $app,
  Str $name,
  &handler (Pointer, Pointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
