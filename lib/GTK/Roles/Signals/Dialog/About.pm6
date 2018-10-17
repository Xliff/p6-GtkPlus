use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Dialog::About {
  has %!signals-ad;

  # Copy for each signal.
  method connect-activate-link (
    $obj,
    $signal = 'activate-link',
    &handler?
  ) {
    my $hid;
    %!signals-ad{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-activate-link($obj, $signal,
        -> $ad, $uri, $ud --> gboolean {
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
    %!signals-ad{$signal}[0].tap(&handler) with &handler;
    %!signals-ad{$signal}[0];
  }

}

# Define for each signal
sub g-connect-activate-link(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
