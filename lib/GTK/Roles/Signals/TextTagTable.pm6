use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;

role GTK::Roles::Signals::TextTagTable {
  has %!signals-ttt;

  # Copy for each signal.
  method connect-tag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ttt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tag($obj, $signal,
        -> $, $tag, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $tag, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ttt{$signal}[0].tap(&handler) with &handler;
    %!signals-ttt{$signal}[0];
  }

  # GtkTextTagTable, GtkTextTag, gboolean, gpointer --> void
  method connect-tag-changed (
    $obj,
    $signal = 'tag-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ttt{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-tag-changed($obj, $signal,
        -> $, $tag, $b, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $tag, $b, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ttt{$signal}[0].tap(&handler) with &handler;
    %!signals-ttt{$signal}[0];
  }

}

# Define for each signal
sub g-connect-tag(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextTag, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-tag-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextTag, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
