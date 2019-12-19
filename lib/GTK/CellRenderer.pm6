use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::CellRenderer;
use GTK::Raw::Types;

use GTK::Roles::Data;
use GTK::Roles::Properties;
use GTK::Roles::Signals::CellRenderer;
use GTK::Roles::Types;

class GTK::CellRenderer {
  also does GTK::Roles::Data;
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::CellRenderer;
  also does GTK::Roles::Types;

  has GtkCellRenderer $!cr is implementor;

  method setCellRenderer(GtkCellRenderer $renderer) {
    self!setObject($!cr = $renderer);       # GTK::Roles::Properties
    $!data = $!cr;                          # GTK::Roles::Data
  }

  method GTK::Raw::Types::GtkCellRenderer
    is also<CellRenderer>
  { $!cr }

  method disconnect-cellrenderer-signals
    is also<disconnect_cellrenderer_signals>
  {
    self.disconnect-all for %!signals-cr;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRenderer, gpointer --> void
  method editing-canceled is also<editing_canceled> {
   self.connect($!cr, 'editing-canceled');
  }

  # Is originally:
  # void
  method editing-started is also<editing_started> {
   self.connect-editing-started($!cr);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_cell_renderer_get_sensitive($!cr);
      },
      STORE => sub ($, Int() $sensitive is copy) {
        my gboolean $s = (so $sensitive).Int;

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
        my gboolean $v = (so $visible).Int;

        gtk_cell_renderer_set_visible($!cr, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gchar
  method cell-background is rw is also<cell_background> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        warn "cell-background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('cell-background', $gv);
      }
    );
  }

  # Type: GdkColor
  # method cell-background-gdk is rw  is DEPRECATED( “cell-background-rgba” ) {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('cell-background-gdk', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('cell-background-gdk', $gv);
  #     }
  #   );
  # }

  # Type: GdkRGBA
  method cell-background-rgba is rw is also<cell_background_rgba> {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cell-background-rgba', $gv)
        );
        nativecast(GdkRGBA, $gv.pointer);
      },
      STORE => -> $, $val is copy {
        $gv.pointer = $val;
        self.prop_set('cell-background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method cell-background-set is rw is also<cell_background_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cell-background-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = (so $val).Int;
        self.prop_set('cell-background-set', $gv);
      }
    );
  }

  # Type: gboolean
  method editing is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('editing', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "editing does not allow writing"
      }
    );
  }

  # Type: gint
  method height is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('height', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: gboolean
  method is-expanded is rw is also<is_expanded> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('is-expanded', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = (so $val).Int;

        self.prop_set('is-expanded', $gv);
      }
    );
  }

  # Type: gboolean
  method is-expander is rw is also<is_expander> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('is-expander', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = (so $val).Int;

        self.prop_set('is-expander', $gv);
      }
    );
  }

  # Type: GtkCellRendererMode
  method mode is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('mode', $gv)
        );
        GtkCellRendererMode( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  # # Type: gboolean
  # method sensitive is rw  {
  #   my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('sensitive', $gv)
  #       );
  #       $gv.boolean;
  #     },
  #     STORE => -> $, Int() $val is copy {
  #       $gv.boolean = $val;
  #       self.prop_set('sensitive', $gv);
  #     }
  #   );
  # }
  #
  # # Type: gboolean
  # method visible is rw  {
  #   my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('visible', $gv)
  #       );
  #       $gv.boolean;
  #     },
  #     STORE => -> $, Int() $val is copy {
  #       $gv.boolean = $val;
  #       self.prop_set('visible', $gv);
  #     }
  #   );
  # }

  # Type: gint
  method width is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('width', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # Type: gfloat
  method xalign is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('xalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: guint
  method xpad is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('xpad', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('xpad', $gv);
      }
    );
  }

  # Type: gfloat
  method yalign is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('yalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  # Type: guint
  method ypad is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('ypad', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('ypad', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GdkEvent() $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle $background_area,
    GdkRectangle $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = $flags;

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
    GdkRectangle $cell_area,
    GdkRectangle $aligned_area
  )
    is also<get-aligned-area>
  {
    my uint32 $f = $flags;

    gtk_cell_renderer_get_aligned_area(
      $!cr,
      $widget,
      $f,
      $cell_area,
      $aligned_area
    );
  }

  method get_alignment (Num() $xalign, Num() $yalign)
    is also<get-alignment>
  {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_cell_renderer_get_alignment($!cr, $xa, $ya);
  }

  method get_fixed_size (Int() $width, Int() $height)
    is also<get-fixed-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_cell_renderer_get_fixed_size($!cr, $w, $h);
  }

  method get_padding (Int() $xpad, Int() $ypad) is also<get-padding> {
    my gint ($x, $y) = ($xpad, $ypad);

    gtk_cell_renderer_get_padding($!cr, $x, $y);
  }

  method get_preferred_height (
    GtkWidget() $widget,
    Int() $minimum_size,
    Int() $natural_size
  )
    is also<get-preferred-height>
  {
    my gint ($ms, $ns) = ($minimum_size, $natural_size);

    gtk_cell_renderer_get_preferred_height(
      $!cr,
      $widget,
      $ms,
      $ns
    );
  }

  method get_preferred_height_for_width (
    GtkWidget() $widget,
    Int() $width,
    Int() $minimum_height,
    Int() $natural_height
  )
    is also<get-preferred-height-for-width>
  {
    my gint ($w, $mh, $nh) = ($width, $minimum_height, $natural_height);

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
  )

    is also<get-preferred-size>
  {
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
  )
    is also<get-preferred-width>
  {
    my gint ($ms, $ns) = ($minimum_size, $natural_size);

    gtk_cell_renderer_get_preferred_width($!cr, $widget, $ms, $ns);
  }

  method get_preferred_width_for_height (
    GtkWidget() $widget,
    Int() $height,
    Int() $minimum_width,
    Int() $natural_width
  )
    is also<get-preferred-width-for-height>
  {
    my gint ($h, $mw, $nw) = ($height, $minimum_width, $natural_width);

    gtk_cell_renderer_get_preferred_width_for_height(
      $!cr,
      $widget,
      $h,
      $mw,
      $nw
    );
  }

  method get_request_mode is also<get-request-mode> {
    gtk_cell_renderer_get_request_mode($!cr);
  }

  method get_size (
    GtkWidget() $widget,
    GdkRectangle $cell_area,
    Int() $x_offset,
    Int() $y_offset,
    Int() $width,
    Int() $height
  )
    is also<get-size>
  {
    my gint ($xo, $yo, $w, $h) = ($x_offset, $y_offset, $width, $height);

    gtk_cell_renderer_get_size($!cr, $widget, $cell_area, $xo, $yo, $w, $h);
  }

  method get_state (
    GtkWidget() $widget,
    Int() $cell_state           # GtkCellRendererState $cell_state
  )
    is also<get-state>
  {
    my guint $cs = $cell_state;

    gtk_cell_renderer_get_state($!cr, $widget, $cs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_get_type, $n, $t );
  }

  method is_activatable is also<is-activatable> {
    so gtk_cell_renderer_is_activatable($!cr);
  }

  method render (
    cairo_t $cr,
    GtkWidget() $widget,
    GdkRectangle $background_area,
    GdkRectangle $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  ) {
    my uint32 $f = $flags;

    gtk_cell_renderer_render(
      $!cr,
      $cr,
      $widget,
      $background_area,
      $cell_area,
      $f
    );
  }

  method set_alignment (Num() $xalign, Num() $yalign)
    is also<set-alignment>
  {
    my gfloat ($xa, $ya) = ($xalign, $yalign);

    gtk_cell_renderer_set_alignment($!cr, $xa, $ya);
  }

  method set_fixed_size (Int() $width, Int() $height)
    is also<set-fixed-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_cell_renderer_set_fixed_size($!cr, $w, $h);
  }

  method set_padding (Int() $xpad, Int() $ypad) is also<set-padding> {
    my gint ($x, $y) = ($xpad, $ypad);

    gtk_cell_renderer_set_padding($!cr, $x, $y);
  }

  method start_editing (
    GdkEvent() $event,
    GtkWidget() $widget,
    Str() $path,
    GdkRectangle $background_area,
    GdkRectangle $cell_area,
    Int() $flags                # GtkCellRendererState $flags
  )
    is also<start-editing>
  {
    my uint32 $f = $flags;

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

  method stop_editing (Int() $canceled) is also<stop-editing> {
    my gboolean $c = (so $canceled).Int;

    gtk_cell_renderer_stop_editing($!cr, $c);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
