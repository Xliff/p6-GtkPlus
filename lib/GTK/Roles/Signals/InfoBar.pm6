use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals::InfoBar {
  has %!signals-ib;

  method connect-response (
    $obj,
    $signal = 'response',
    &handler?
  ) {
    my $hid;
    %!signals-sb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_response($obj, $signal,
        -> $ib, $rid, $ud {
          CATCH {
            default { $s.quit($_); }
          }

          $s.emit( [self, $rid, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ib{$signal}[0].tap(&handler) with &handler;
    %!signals-ib{$signal}[0];
  }
}

sub g_connect_response(
  OpaquePointer $app,
  Str $name,
  &handler (Pointer, gint, Pointer),
  OpaquePointer $data,
  uint32 $connect_flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
