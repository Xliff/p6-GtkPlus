use v6.c;

use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::Subs;
use GLib::Raw::ReturnedValue;

role GTK::Roles::Signals::TreeView {
  has %!signals-tv;

  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> void
  method connect-row (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-row($obj, $signal,
        -> $, $ti, $tp, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $tp, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  # GtkTreeView, GtkTreeIter, GtkTreePath, gpointer --> gboolean
  method connect-test-row (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-test-row($obj, $signal,
        -> $, $ti, $tp, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $ti, $tp, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

  # GtkTreeView, gboolean, gboolean, gboolean, gpointer --> gboolean
  method connect-expand-collapse (
    $obj,
    $signal = 'expand-collapse-cursor-row',
    &handler?
  ) {
    my $hid;
    %!signals-tv{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-expand-collapse($obj, $signal,
        -> $, $b1, $b2, $b3, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $b1, $b2, $b3, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-tv{$signal}[0].tap(&handler) with &handler;
    %!signals-tv{$signal}[0];
  }

}

# Define for each signal
sub g-connect-row(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTreeIter, GtkTreePath, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-test-row(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTreeIter, GtkTreePath, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-expand-collapse(
  Pointer $app,
  Str $name,
  &handler (Pointer, gboolean, gboolean, gboolean, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
