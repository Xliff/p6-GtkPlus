use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
<<<<<<< HEAD
=======
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45

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
            default { note $_; }
          }

<<<<<<< HEAD
          $s.emit( [self, $i, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
=======
          my $r = ReturnedValue.new;
          $s.emit( [self, $i, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45
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
            default { note $_; }
          }

<<<<<<< HEAD
          $s.emit( [self, $ptr, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
=======
          my $r = ReturnedValue.new;
          $s.emit( [self, $ptr, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45
    };
    %!signals-mi{$signal}[0].tap(&handler) with &handler;
    %!signals-mi{$signal}[0];
  }

}

# Define for each signal
<<<<<<< HEAD
sub g_connect_toggle_size_allocate (
=======
sub g_connect_toggle-size-allocate(
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

<<<<<<< HEAD
sub g_connect_toggle_size_request(
=======
sub g_connect_toggle-size-allocate(
>>>>>>> 3fe12b2267efcadbc9466bf34cb9e1e7db5c0b45
  Pointer $app,
  Str $name,
  &handler (Pointer, Pointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
