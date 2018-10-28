use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Subs;
use GTK::Raw::ReturnedValue;

role GTK::Roles::Signals::PrintOperation {
  has %!signals-po;

  # GtkPrintOperation, GtkPrintContext, gpointer --> void
  method connect-printcontext (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-printcontext($obj, $signal,
        -> $, $pc, $ud {
          CATCH {
            default { note($_) }
          }
          $s.emit( [self, $pc, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

  # GtkPrintOperation, GtkPrintContext, gpointer --> boolean
  method connect-printcontext-rbool (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-printcontext-rbool($obj, $signal,
        -> $, $pc, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $pc, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

  # GtkPrintOperation, GtkPrintOperationPreview, GtkPrintContext, GtkWindow, gpointer --> gboolean
  method connect-preview (
    $obj,
    $signal = 'preview',
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-preview($obj, $signal,
        -> $, $pop, $pc, $w, $ud --> gboolean {
          CATCH {
            default { note($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $pop, $pc, $w, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

  # GtkPrintOperation, GtkPrintContext, gint, GtkPageSetup, gpointer --> void
  method connect-request-page-setup (
    $obj,
    $signal = 'request-page-setup',
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-request-page-setup($obj, $signal,
        -> $, $pc, $i, $ps, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $pc, $i, $ps, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

  # GtkPrintOperation, GtkWidget, GtkPageSetup, GtkPrintSettings, gpointer --> void
  method connect-update-custom-widget (
    $obj,
    $signal = 'update-custom-widget',
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-update-custom-widget($obj, $signal,
        -> $, $w, $pgs, $ps, $ud {
          CATCH {
            default { note($_) }
          }

          $s.emit( [self, $w, $pgs, $ps, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

  # GtkPrintOperationPreview, GtkPrintContext, GtkPageSetup, gpointer --> void
  method connect-got-page-size (
    $obj,
    $signal = 'got-page-size',
    &handler?
  ) {
    my $hid;
    %!signals-po{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-got-page-size($obj, $signal,
        -> $, $pc, $pgs, $ud {
          CATCH {
            default { note($_) }
          }
          $s.emit( [self, $pc, $pgs, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-po{$signal}[0].tap(&handler) with &handler;
    %!signals-po{$signal}[0];
  }

}

# GtkPrintOperation, GtkPrintContext, gpointer --> void
sub g-connect-printcontext(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkPrintContext, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
# GtkPrintOperation, GtkPrintContext, gpointer --> gboolean
sub g-connect-printcontext-rbool(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkPrintContext, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkPrintOperation,
# GtkPrintOperationPreview,
# GtkPrintContext,
# GtkWindow,
# gpointer --> gboolean
sub g-connect-preview(
  Pointer $app,
  Str $name,
  &handler (
    Pointer,
    GtkPrintOperation,
    GtkPrintContext,
    GtkWindow,
    Pointer --> gboolean
  ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkPrintOperation, GtkPrintContext, gint, GtkPageSetup, gpointer --> void
sub g-connect-request-page-setup(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkPrintContext, gint, GtkPageSetup, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkPrintOperation, GtkWidget, GtkPageSetup, GtkPrintSettings, gpointer --> void
sub g-connect-update-custom-widget(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkWidget, GtkPageSetup, GtkPrintSettings, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkPrintOperationPreview, GtkPrintContext, GtkPageSetup, gpointer --> void
sub g-connect-got-page-size(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkPrintContext, GtkPageSetup, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
