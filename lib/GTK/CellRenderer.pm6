use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::CellRenderer;
use GTK::Raw::Types;

use GTK::Roles::Properties;

class GTK::CellRenderer {
  also does GTK::Roles::Properties;

  has GtkCellRenderer $!cr;

  method setCellRenderer($renderer) {
    $!cr = $renderer;
    $!prop = nativecast(GObject, $!cr);
  }

  method GTK::Raw::Types::GtkCellRenderer {
    $!cr;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRenderer, gpointer --> void
  method editing-canceled {
   self.connect($!cr, 'editing-canceled');
  }

  # Is originally:
  # void
  method editing-started {
   self.connect($!cr, 'editing-started');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_get_sensitive($!cr);
      },
      STORE => sub ($, Int() $sensitive is copy) {
        my gboolean $s = self.RESOLVE-BOOL($sensitive);
        gtk_cell_renderer_set_sensitive($!cr, $s);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_get_visible($!cr);
      },
      STORE => sub ($, Int() $visible is copy) {
        my gboolean $v = self.RESOLVE-BOOL($visible);
        gtk_cell_renderer_set_visible($!cr, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gchar
  method cell-background is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        warn "cell-background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!cr, 'cell-background', $gv);
      }
    );
  }

  # Type: GdkColor
  method cell-background-gdk is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'cell-background-gdk', $gv);
        nativecast(GdkColor, $gv.pointer);
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set($!cr, 'cell-background-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method cell-background-rgba is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'cell-background-rgba', $gv);
        nativecast(GTK::Compat::RGBA, $gv.pointer);
      },
      STORE => -> $, GTK::Compat::RGBA() $val is copy {
        $gv.pointer = nativecast(Pointer, $val);
        self.prop_set($!cr, 'cell-background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method cell-background-set is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'cell-background-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!cr, 'cell-background-set', $gv);
      }
    );
  }

  # Type: gboolean
  method editing is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'editing', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "editing does not allow writing"
      }
    );
  }

  # Type: gint
  method height is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!cr, 'height', $gv);
      }
    );
  }

  # Type: gboolean
  method is-expanded is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'is-expanded', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!cr, 'is-expanded', $gv);
      }
    );
  }

  # Type: gboolean
  method is-expander is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'is-expander', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!cr, 'is-expander', $gv);
      }
    );
  }

  # Type: GtkCellRendererMode
  method mode is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'mode', $gv);
        GtkCellRendererMode($gv.enum);
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!cr, 'mode', $gv);
      }
    );
  }

  # Type: gboolean
  # method sensitive is rw {
  #   my GValue $gv .= new;
  #   Proxy.new(
  #     FETCH => -> $ {
  #       self.prop_get($!cr, 'sensitive', $gv);
  # #        $gv.get_TYPE;
  #     },
  #     STORE => -> $, $val is copy {
  # #        $gv.set_TYPE($val);
  #       self.prop_set($!cr, 'sensitive', $gv);
  #     }
  #   );
  # }

  # Type: gboolean
  # method visible is rw {
  #   my GValue $gv .= new;
  #   Proxy.new(
  #     FETCH => -> $ {
  #       self.prop_get($!cr, 'visible', $gv);
  # #        $gv.get_TYPE;
  #     },
  #     STORE => -> $, $val is copy {
  # #        $gv.set_TYPE($val);
  #       self.prop_set($!cr, 'visible', $gv);
  #     }
  #   );
  # }

  # Type: gint
  method width is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!cr, 'width', $gv);
      }
    );
  }

  # Type: gfloat
  method xalign is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set($!cr, 'xalign', $gv);
      }
    );
  }

  # Type: guint
  method xpad is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'xpad', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set($!cr, 'xpad', $gv);
      }
    );
  }

  # Type: gfloat
  method yalign is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set($!cr, 'yalign', $gv);
      }
    );
  }

  # Type: guint
  method ypad is rw {
    my GValue $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cr, 'ypad', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set($!cr, 'ypad', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GdkEvent() $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_activate(
      $!cr,
      $event,
      $widget,
      $path,
      $background_area,
      $cell_area,
      $f
    );
  }

  # method class_set_accessible_type (GType $type) {
  #   gtk_cell_renderer_class_set_accessible_type($!cr, $type);
  # }

  method get_aligned_area (
    GtkWidget() $widget,
    Int() $flags,               # GtkCellRendererState $flags,
    GdkRectangle() $cell_area,
    GdkRectangle() $aligned_area
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_get_aligned_area(
      $!cr,
      $widget,
      $f,
      $cell_area,
      $aligned_area
    );
  }

  method get_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_cell_renderer_get_alignment($!cr, $xa, $ya);
  }

  method get_fixed_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_fixed_size($!cr, $w, $h);
  }

  method get_padding (Int() $xpad, Int() $ypad) {
    my @i = ($xpad, $ypad);
    my gint ($x, $y) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_padding($!cr, $x, $y);
  }

  method get_preferred_height (
    GtkWidget() $widget,
    Int() $minimum_size,
    Int() $natural_size
  ) {
    my @i = ($minimum_size, $natural_size);
    my ($ms, $ns) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_height(
      $!cr,
      $widget,
      $ms,
      $ns
    );
  }

  method get_preferred_height_for_width (
    GtkWidget $widget,
    Int() $width,
    Int() $minimum_height,
    Int() $natural_height
  ) {
    my @i = ($width, $minimum_height, $natural_height);
    my gint ($w, $mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_height_for_width(
      $!cr,
      $widget,
      $w,
      $mh,
      $nh
    );
  }

  method get_preferred_size (
    GtkWidget() $widget,
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_cell_renderer_get_preferred_size(
      $!cr,
      $widget,
      $minimum_size,
      $natural_size
    );
  }

  method get_preferred_width (
    GtkWidget() $widget,
    Int() $minimum_size,
    Int() $natural_size
  ) {
    my @i = ($minimum_size, $natural_size);
    my ($ms, $ns) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_width($!cr, $widget, $ms, $ns);
  }

  method get_preferred_width_for_height (
    GtkWidget() $widget,
    Int() $height,
    Int() $minimum_width,
    Int() $natural_width
  ) {
    my @i = ($height, $minimum_width, $natural_width);
    my gint ($h, $mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_preferred_width_for_height(
      $!cr,
      $widget,
      $h,
      $mw,
      $nw
    );
  }

  method get_request_mode {
    gtk_cell_renderer_get_request_mode($!cr);
  }

  method get_size (
    GtkWidget() $widget,
    GdkRectangle() $cell_area,
    Int() $x_offset,
    Int() $y_offset,
    Int() $width,
    Int() $height
  ) {
    my @i = ($x_offset, $y_offset, $width, $height);
    my gint ($xo, $yo, $w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_get_size($!cr, $widget, $cell_area, $xo, $yo, $w, $h);
  }

  method get_state (
    GtkWidget() $widget,
    Int() $cell_state           # GtkCellRendererState $cell_state
  ) {
    my guint $cs = self.RESOLVE-UINT($cell_state);
    gtk_cell_renderer_get_state($!cr, $widget, $cs);
  }

  method get_type {
    gtk_cell_renderer_get_type();
  }

  method is_activatable {
    gtk_cell_renderer_is_activatable($!cr);
  }

  method render (
    cairo_t $cr,
    GtkWidget() $widget,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_render(
      $!cr,
      $cr,
      $widget,
      $background_area,
      $cell_area,
      $f
    );
  }

  method set_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_cell_renderer_set_alignment($!cr, $xa, $ya);
  }

  method set_fixed_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_set_fixed_size($!cr, $w, $h);
  }

  method set_padding (Int() $xpad, Int() $ypad) {
    my @i = ($xpad, $ypad);
    my gint ($x, $y) = self.RESOLVE-INT(@i);
    gtk_cell_renderer_set_padding($!cr, $x, $y);
  }

  method start_editing (
    GdkEvent $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    guint $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = self.RESOLVE-UINT($flags);
    gtk_cell_renderer_start_editing(
      $!cr,
      $event,
      $widget,
      $path,
      $background_area,
      $cell_area,
      $f
    );
  }

  method stop_editing (Int() $canceled) {
    my gboolean $c = self.RESOLVE-BOOL($canceled);
    gtk_cell_renderer_stop_editing($!cr, $c);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
