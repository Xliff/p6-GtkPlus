use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals::Statusbar {
  has %!signals-sb;

  # GtkStatusbar, guint, gchar, gpointer --> void
  method connect-text (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-sb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-text($obj, $signal,
        -> $, $ui, $str, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ui, $str, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

}

# Define for each signal
sub g-connect-text(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
