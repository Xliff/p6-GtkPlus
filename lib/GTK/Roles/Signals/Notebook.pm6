use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::Notebook {
  has %!signals-n;

  # GtkNotebook, GtkWidget, guint, gpointer --> void
  method connect-notebook-widget (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-n{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-notebook-widget($obj, $signal,
        -> $, $w, $i, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $w, $i, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-n{$signal}[0].tap(&handler) with &handler;
    %!signals-n{$signal}[0];
  }

  # GtkNotebook, GtkWidget, gint, gint, gpointer --> GtkNotebook
  method connect-create-window (
    $obj,
    $signal = 'create-window',
    &handler?
  ) {
    my $hid;
    %!signals-n{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-notebook-widget($obj, $signal,
        -> $, $w, $i1, $i2, $ud --> GtkNotebook {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $w, $i1, $i2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-n{$signal}[0].tap(&handler) with &handler;
    %!signals-n{$signal}[0];
  }

  # GtkNotebook, uint32 (GtkDirectionType), gboolean, gpointer --> gboolean
  method connect-reorder-tab (
    $obj,
    $signal = 'reorder-tab',
    &handler?
  ) {
    my $hid;
    %!signals-n{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-notebook-widget($obj, $signal,
        -> $, $ui1, $ui2, $ud --> uint32 {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ui1, $ui2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-n{$signal}[0].tap(&handler) with &handler;
    %!signals-n{$signal}[0];
  }
}

# GtkNotebook, GtkWidget, guint, gpointer --> void
sub g-connect-notebook-widget (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkNotebook, GtkWidget, gint, gint, gpointer --> GtkNotebook
sub g-connect-create-window (
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, gint, gint, Pointer --> GtkNotebook),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkNotebook, uint32 (GtkDirectionType), gboolean, gpointer --> gboolean
sub g-connect-reorder-tab (
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, uint32, Pointer --> uint32),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
