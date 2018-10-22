use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Scale {
  has %!signals-scale;

  method connect-format-value (
    $obj,
    $signal = 'format-value',
    &handler?
  ) {
    my $hid;
    %!signals-scale{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_format_value($obj, $signal,
        -> $scale, $v, $ud --> Str {
          CATCH {
            default { note($_) }
          }
          my $r = ReturnedValue.new;
          $s.emit( [self, $v, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-scale{$signal}[0].tap(&handler) with &handler;
    %!signals-scale{$signal}[0];
  }

}

sub g_connect_format_value(
  Pointer $app,
  Str $name,
  &handler (Pointer, gdouble, Pointer --> Str),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  is export
  { * }
