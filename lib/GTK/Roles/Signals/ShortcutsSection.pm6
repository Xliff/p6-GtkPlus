use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::ShortcutsSection {
  has %!signals-ss;

  # Copy for each signal.
  method connect-change-current-page (
    $obj,
    $signal = 'change-current-page',
    &handler?
  ) {
    my $hid;
    %!signals-ss{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_changePage($obj, $signal,
        -> $ss, $p, $ud --> gboolean {
          CATCH {
            default { note $_; }
          }
          my $r = ReturnedValue.new;
          $s.emit( [self, $p, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ss{$signal}[0].tap(&handler) with &handler;
    %!signals-ss{$signal}[0];
  }

}

# Define for each signal
sub g_connect_changePage(
  Pointer $app,
  Str $name,
  &handler (GtkShortcutsSection, gint, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
