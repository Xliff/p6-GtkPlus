use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;
use GLib::Raw::ReturnedValue;

use GDK::Event;

role GTK::Roles::Signals::Widget:ver<3.0.1146> {
  has %!signals-widget;

  method connect-widget-event (
     $obj,
     $signal,
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-widget-event($obj, $signal,
        -> $, $e is copy, $ud --> uint32 {
          CATCH { default { note($_) } }

          $e = GDK::Event.new($e) unless $raw;

          my ReturnedValue $r .= new;
          my @valid-types = (Bool, Int);
          $s.emit( [self, $e, $ud, $r] );
          # die 'Invalid return type' if $r.r ~~ @valid-types.any;
          # $r.r = .Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkDragContext, gint, gint, guint, gpointer --> gboolean
  method connect-drag-action (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-action($obj, $signal,
        -> $, $dc, $i1, $i2, $ui, $ud --> uint32 {
          CATCH { default { note($_) } }

          my ReturnedValue $r .= new;
          my @valid-types = (Bool, Int);
          $s.emit( [self, $dc, $i1, $i2, $ui, $ud, $r] );
          # die 'Invalid return type' if $r.r ~~ @valid-types.any;
          # $r.r = .Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkDragContext, GtkDragResult, gpointer --> gboolean
  method connect-drag-failed (
    $obj,
    $signal = 'drag-failed',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-failed($obj, $signal,
        -> $, $dc, $dr, $ud --> uint32 {
          CATCH { default { note($_) } }

          my ReturnedValue $r .= new;
          my @valid-types = (Bool, Int);
          $s.emit( [self, $dc, $dr, $ud, $r] );
          # die 'Invalid return type' if $r.r ~~ @valid-types.any;
          # $r.r = .Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
  method connect-query-tooltip (
    $obj,
    $signal = 'query-tooltip',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-tooltip($obj, $signal,
        -> $, $i1, $i2, $ui, $tt, $ud --> uint32 {
          CATCH { default { note($_) } }

          my ReturnedValue $r .= new;
          my @valid-types = (Bool, Int);
          $s.emit( [self, $i1, $i2, $ui, $tt, $ud, $r] );
          # die 'Invalid return type' if $r.r ~~ @valid-types.any;
          # $r.r = .Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkScreen, gpointer --> void
  method connect-screen-changed (
    $obj,
    $signal = 'screen-changed',
    &handler?
  ) {
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      g-connect-screen-changed($obj, $signal,
        -> $, $scr, $ud {
          CATCH { default { note($_) } }

          my @valid-types = (Bool, Int);
          $s.emit( [self, $scr, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, cairo_t, gpointer --> gboolean
  method connect-draw (
     $obj,
     $signal     = 'draw',
     &handler?,
    :$raw        = False
  ) {
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      g-connect-draw($obj, $signal,
        -> $, $c is copy, $ud --> uint32 {
          CATCH { default { note($_) } }

          $c = Cairo::Context.new($c) unless $raw;

          my ReturnedValue $r .= new;
          my @valid-types = (Bool, Int);
          $s.emit( [self, $c, $ud, $r] );
          #die 'Invalid return type' if $r.r ~~ @valid-types.any;
          #$r.r = .Int if $r.r ~~ @valid-types.any;
          $r.r;
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkDragContext, GtkDragResult, gpointer
  method connect-drag-leave (
    $obj,
    $signal = 'drag-leave',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-leave($obj, $signal,
        -> $, $dc, $dr, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $dc, $dr, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GdkDragContext
  method connect-widget-drag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-widget-drag($obj, $signal,
        -> $, $dc, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $dc, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkDragContext, GtkSelectionData, guint, guint, gpointer --> void
  method connect-drag-data-get (
    $obj,
    $signal = 'drag-data-get',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-data-get($obj, $signal,
        -> $, $dc, $sd, $ui1, $ui2, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $dc, $sd, $ui1, $ui2, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkDragContext, gint, gint, GtkSelectionData, guint, guint, gpointer
  # --> void
  method connect-drag-data-received (
    $obj,
    $signal = 'drag-data-received',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-data-received($obj, $signal,
        -> $, $dc, $i1, $i2, $sd, $ui1, $ui2, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $dc, $i1, $i2, $sd, $ui1, $ui2, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GtkSelectionData, guint, guint, gpointer --> void
  method connect-selection-get (
    $obj,
    $signal = 'selection-get',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-selection-get($obj, $signal,
        -> $, $sd, $ui1, $ui2, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $sd, $ui1, $ui2, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GtkSelectionData, guint, gpointer --> void
  method connect-selection-received (
    $obj,
    $signal = 'selection-received',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-selection-received($obj, $signal,
        -> $, $sd, $ui, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $sd, $ui, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GdkRectangle, gpointer --> void
  method connect-size-allocate (
    $obj,
    $signal = 'size-allocate',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-size-allocate($obj, $signal,
        -> $, $rect, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $rect , $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

  # GtkWidget, GtkStyle, gpointer --> void
  method connect-style-set (
    $obj,
    $signal = 'style-set',
    &handler?
  ) {
    my $hid;
    %!signals-widget{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-style-set($obj, $signal,
        -> $, $style, $ud {
          CATCH { default { note($_) } }

          $s.emit( [self, $style, $ud] );
        },
        OpaquePointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-widget{$signal}[0].tap(&handler) with &handler;
    %!signals-widget{$signal}[0];
  }

}

sub g-connect-widget-event (
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkEvent, Pointer --> uint32),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkDragContext, gint, gint, guint, gpointer --> gboolean
sub g-connect-drag-action(
  Pointer $app,
  Str     $name,
          &handler (
            GtkWidget,
            GdkDragContext,
            gint,
            gint,
            guint,
            Pointer
            --> uint32
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkDragContext, GtkDragResult, gpointer --> gboolean
sub g-connect-drag-failed(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkDragContext, guint, Pointer --> uint32),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
sub g-connect-query-tooltip(
  Pointer $app,
  Str     $name,
          &handler (
            GtkWidget,
            gint,
            gint,
            gboolean,
            GtkTooltip,
            Pointer
            --> uint32
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkScreen, gpointer --> void
sub g-connect-screen-changed(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkScreen, Pointer --> uint32),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkDragContext, GtkDragResult, gpointer --> gboolean
sub g-connect-drag-leave(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkDragContext, guint, Pointer),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-widget-drag(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkDragContext, Pointer),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkWidget, GdkDragContext, GtkSelectionData, guint, guint, gpointer --> void
sub g-connect-drag-data-get(
  Pointer $app,
  Str     $name,
          &handler (
            GtkWidget,
            GdkDragContext,
            GtkSelectionData,
            guint,
            guint,
            Pointer
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkDragContext, gint, gint, GtkSelectionData, guint, guint, gpointer --> void
sub g-connect-drag-data-received(
  Pointer $app,
  Str     $name,
          &handler (
            GtkWidget,
            GdkDragContext,
            gint,
            gint,
            GtkSelectionData,
            guint,
            guint,
            Pointer
          ),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-draw(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, cairo_t, Pointer --> uint32),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GtkSelectionData, guint, guint, gpointer --> void
sub g-connect-selection-get(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GtkSelectionData, guint, guint, Pointer --> uint32),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GtkSelectionData, guint, gpointer --> void
sub g-connect-selection-received(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GtkSelectionData, guint, Pointer),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GdkRectangle, gpointer --> void
sub g-connect-size-allocate(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GdkRectangle, Pointer),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# GtkWidget, GtkStyle, gpointer --> void
sub g-connect-style-set(
  Pointer $app,
  Str     $name,
          &handler (GtkWidget, GtkStyle, Pointer),
  Pointer $data,
  uint32  $flags
)
  is export
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
