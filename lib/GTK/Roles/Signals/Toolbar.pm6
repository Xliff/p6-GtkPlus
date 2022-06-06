use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Subs:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::Toolbar:ver<3.0.1146> {
  has %!signals-tb;

  # GtkToolbar, gint, gint, gint, gpointer --> gboolean
  method connect-popup-context-menu (
    $obj,
    $signal = 'popup-context-menu',
    &handler?
  ) {
    my $hid;
    %!signals-tb{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-popup-context-menu($obj, $signal,
        -> $, $i1, $i2, $i3, $ud --> uint32 {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $i1, $i2, $i3, $ud, $r] );
          # die 'Invalid return type' unless $r.r ~~ (Bool, Int).any;
          # $r.r .= Int if $r.r ~~ Bool;
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tb{$signal}[0].tap(&handler) with &handler;
    %!signals-tb{$signal}[0];
  }

}

# GtkToolbar, gint, gint, gint, gpointer --> gboolean
sub g-connect-popup-context-menu(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, gint, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
