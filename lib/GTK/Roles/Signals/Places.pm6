use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Places {
  has %!signals-p;

  # (GObject, gpointer, gint)
  method connect-drag-perform-drop (
    $obj,
    $signal = 'drag-perform-drop',
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-perform-drop($obj, $signal,
        -> $, $obj, $p, $i, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $obj, $p, $i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

  # (GdkDragContext, GObject, gpointer) --> gint
  method connect-drag-action-requested (
    $obj,
    $signal = 'drag-action-requested',
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-action-requested($obj, $signal,
        -> $, $dc, $obj, $p, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $dc, $obj, $p, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

  # GObject, uint
  method connect-open-location (
    $obj,
    $signal = 'open-location',
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-open-location($obj, $signal,
        -> $, $obj, $go, $ui, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $go, $ui, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

  # GtkWidget, GFile, GVolume,
  method connect-populate-popup (
    $obj,
    $signal = 'populate-popup',
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-populate-popup($obj, $signal,
        -> $, $w, $f, $v, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $w, $f, $v, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

  # GMountOperation
  method connect-mount_op (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-mount_op($obj, $signal,
        -> $, $mo, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $mo, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

}

# Define for each signal
sub g-connect-drag-perform-drop(
  Pointer $app,
  Str $name,
  &handler (Pointer, GObject, Pointer, int, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# (GdkDragContext, GObject, gpointer) --> gint
sub g-connect-drag-action-requested(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkDragContext, GObject, Pointer, Pointer --> gint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-open-location(
  Pointer $app,
  Str $name,
  &handler (Pointer, GObject, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-populate-popup(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, GFile, GVolume, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

sub g-connect-mount_op(
  Pointer $app,
  Str $name,
  &handler (Pointer, GMountOperation, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
