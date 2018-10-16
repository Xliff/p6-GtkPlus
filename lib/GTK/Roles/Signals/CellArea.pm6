use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::CellArea {
  has %!signals-ca;

  # Copy for each signal.
  method connect-add-editable (
    $obj,
    $signal = 'add-editable',
    &handler?
  ) {
    my $hid;
    %!signals-ca{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_add_editable($obj, $signal,
        -> $a, $cr, $e, $ca, $p, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $cr, $e, $ca, $p, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ca{$signal}[0].tap(&handler) with &handler;
    %!signals-ca{$signal}[0];
  }

  method connect-apply-attributes (
    $obj,
    $signal = 'apply-attributes',
    &handler?
  ) {
    my $hid;
    %!signals-ca{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_apply_attributes($obj, $signal,
        -> $a, $m, $i, $exp, $ext, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $m, $i, $exp, $ext, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ca{$signal}[0].tap(&handler) with &handler;
    %!signals-ca{$signal}[0];
  }

  method connect-focus-changed (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ca{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_focus_changed($obj, $signal,
        -> $a, $cr, $p, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $cr, $p, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ca{$signal}[0].tap(&handler) with &handler;
    %!signals-ca{$signal}[0];
  }

  method connect-remove-editable (
    $obj,
    $signal = 'remove-editable',
    &handler?
  ) {
    my $hid;
    %!signals-ca{$signal} //= do {
      my $s = Supplier.new;
      $hid = g_connect_remove_editable($obj, $signal,
        -> $a, $cr, $ce, $ud {
          CATCH {
            default { note $_; }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $cr, $ce, $ud, $r] );
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-ca{$signal}[0].tap(&handler) with &handler;
    %!signals-ca{$signal}[0];
  }

}

# Define for each signal
sub g_connect_add_editable (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkCellRenderer, GtkCellEditable, GdkRectangle, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_apply_attributes (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTreeModel, GtkTreeIter, gboolean, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_focus_changed (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkCellRenderer, Str, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g_connect_remove_editable (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkCellRenderer, GtkCellEditable, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint32
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
