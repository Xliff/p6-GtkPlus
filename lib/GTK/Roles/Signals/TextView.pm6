use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::TextView {
  has %!signals-tv;

  # GtkTextView, GtkTextExtendSelection, GtkTextIter, GtkTextIter, GtkTextIter, gpointer --> gboolean
  method connect-extend-selection (
    $obj,
    $signal = 'extend-selection',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-extend-selection($obj, $signal,
        -> $, $es, $ti1, $ti2, $ti3, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti1, $ti2, $ti3, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

}

# GtkTextView, GtkTextExtendSelection, GtkTextIter, GtkTextIter, GtkTextIter, gpointer --> gboolean
sub g-connect-extend-selection(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, GtkTextIter, GtkTextIter, GtkTextIter, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
