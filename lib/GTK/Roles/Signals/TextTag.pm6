use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::TextTag {
  has %!signals-tt;

  # GtkTextTag, GObject, GdkEvent, GtkTextIter, gpointer --> gboolean
  method connect-event (
    $obj,
    $signal = 'event',
    &handler?
  ) {
    my $hid;
    %!signals-tt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-event($obj, $signal,
        -> $, $go, $e, $ti, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my @valid-types = (Bool, Enumeration);
          my $r = ReturnedValue.new;
          $s.emit( [self, $go, $e, $ti, $ud, $r] );
          die 'Invalid return type!' unless $r.r ~~ @valid-types.any;
          $r.r .= Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tt{$signal}[0].tap(&handler) with &handler;
    %!signals-tt{$signal}[0];
  }

}

# GtkTextTag, GObject, GdkEvent, GtkTextIter, gpointer --> gboolean
sub g-connect-event(
  Pointer $app,
  Str $name,
  &handler (Pointer, GObject, GdkEvent, GtkTextIter, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
