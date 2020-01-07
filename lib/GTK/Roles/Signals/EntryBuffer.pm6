use v6.c;

use NativeCall;


use GTK::Raw::Types;

role GTK::Roles::Signals::EntryBuffer {
  has %!signals-eb;

  # Copy for each signal.
  method connect-inserted-text (
    $obj,
    $signal = 'inserted-text',
    &handler?
  ) {
    my $hid;
    %!signals-eb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_inserted_text($obj, $signal,
        -> $b, $p, $str, $nc, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $p, $str, $nc, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-eb{$signal}[0].tap(&handler) with &handler;
    %!signals-eb{$signal}[0];
  }

}

# Define for each signal
sub g_connect_inserted_text(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, Str, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
