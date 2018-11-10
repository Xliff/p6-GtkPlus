use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ReturnedValue;

our constant CairoSurface := cairo_surface_t;

role GTK::Compat::Roles::Signals::Window {
  has %!signals-window;

  # GdkWindow, gint, gint, gpointer --> CairoSurface
  method connect-create-surface (
    $obj,
    $signal = 'create-surface',
    &handler?
  ) {
    my $hid;
    %!signals-window{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-create-surface($obj, $signal,
        -> $, $i1, $i2, $ud --> CairoSurface {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $i1, $i2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-window{$signal}[0].tap(&handler) with &handler;
    %!signals-window{$signal}[0];
  }

  # GdkWindow, gdouble, gdouble, gpointer, gpointer, gpointer --> void
  method connect-embedder (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-window{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-embedder($obj, $signal,
        -> $, $d1, $d2, $do1 is rw, $do2 is rw, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $d1, $d2, $do1, $do2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-window{$signal}[0].tap(&handler) with &handler;
    %!signals-window{$signal}[0];
  }

  # For now, use GdkRectangle instead of pointer.
  # GdkWindow, gpointer, gpointer, gboolean, gboolean, gpointer --> void
  method connect-moved-to-rect (
    $obj,
    $signal = 'moved-to-rect',
    &handler?
  ) {
    my $hid;
    %!signals-window{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-moved-to-rect($obj, $signal,
        -> $, $r1, $r2, $b1, $b2, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $r1, $r2, $b1, $b2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-window{$signal}[0].tap(&handler) with &handler;
    %!signals-window{$signal}[0];
  }

  # GdkWindow, gdouble, gdouble, gpointer --> GdkWindow
  method connect-pick-embedded-child (
    $obj,
    $signal = 'pick-embedded-child',
    &handler?
  ) {
    my $hid;
    %!signals-window{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-pick-embedded-child($obj, $signal,
        -> $, $d1, $d2, $ud --> GdkWindow {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $d1, $d2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-window{$signal}[0].tap(&handler) with &handler;
    %!signals-window{$signal}[0];
  }

}

# GdkWindow, gint, gint, gpointer --> CairoSurface
sub g-connect-create-surface(
  Pointer $app,
  Str $name,
  &handler (Pointer, gint, gint, Pointer --> CairoSurface),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GdkWindow, gdouble, gdouble, gpointer, gpointer, gpointer --> void
sub g-connect-embedder(
  Pointer $app,
  Str $name,
  &handler (
    Pointer,
    gdouble,
    gdouble,
    gdouble is rw,
    gdouble is rw,
    Pointer
  ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# For now, use GdkRectangle instead of pointer.
# GdkWindow, gpointer, gpointer, gboolean, gboolean, gpointer --> void
sub g-connect-moved-to-rect(
  Pointer $app,
  Str $name,
  &handler (Pointer, GdkRectangle, GdkRectangle, gboolean, gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GdkWindow, gdouble, gdouble, gpointer --> GdkWindow
sub g-connect-pick-embedded-child(
  Pointer $app,
  Str $name,
  &handler (Pointer, gdouble, gdouble, Pointer --> GdkWindow),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
