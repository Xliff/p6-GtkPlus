use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::CSSProvider {
  has %!signals-css;

  # GtkCssProvider, GtkCssSection, GError, gpointer --> void
  method connect-parsing-error (
    $obj,
    $signal = 'parsing-error',
    &handler?
  ) {
    my $hid;
    %!signals-css{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-parsing-error($obj, $signal,
        -> $, $s1, $err, $ud {
          CATCH {
            default { $s.quit($_) }
          }
          $s.emit( [self, $s1, $err, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-css{$signal}[0].tap(&handler) with &handler;
    %!signals-css{$signal}[0];
  }

}

# GtkCssProvider, GtkCssSection, GError, gpointer --> void
sub g-connect-parsing-error(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkCssSection, GError, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
