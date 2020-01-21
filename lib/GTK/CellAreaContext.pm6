use v6.c;

use Method::Also;

use GTK::Raw::CellAreaContext;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellArea;

use GLib::Roles::Properties;

class GTK::CellAreaContext {
  also does GLib::Roles::Properties;

  has GtkCellAreaContext $!cac is implementor;

  submethod BUILD (:$context) {
    self.setCellAreaContext($context);
  }

  method setCellAreaContext(GtkCellAreaContext $context) {
    self!setObject($!cac = $context);
  }

  method GTK::Raw::Definitions::GtkCellAreaContext
    is also<
      CellAreaContext
      GtkCellAreaContext
    >
  { $!cac }

  method new (GtkCellAreaContext $context) {
    $context ?? self.bless(:$context) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkCellArea
  method area is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('area', $gv);
        GTK::CellArea.new( cast(GtkCellArea, $gv.pointer) );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.pointer = $val;
        self.prop_set('area', $gv)
      }
    );
  }

  # Type: gint
  method minimum-height is rw is also<minimum_height> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('minimum-height', $gv);
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "minimum-height does not allow writing"
      }
    );
  }

  # Type: gint
  method minimum-width is rw is also<minimum_width> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('minimum-width', $gv);
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "minimum-width does not allow writing"
      }
    );
  }

  # Type: gint
  method natural-height is rw is also<natural_height> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('natural-height', $gv);
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "natural-height does not allow writing"
      }
    );
  }

  # Type: gint
  method natural-width is rw is also<natural_width> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('natural-width', $gv);
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "natural-width does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method allocate (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_cell_area_context_allocate($!cac, $w, $h);
  }

  proto method get_allocation (|)
    is also<get-allocation>
  { * }

  multi method get_allocation {
    samewith($, $);
  }
  multi method get_allocation ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;
    gtk_cell_area_context_get_allocation($!cac, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_area (:$raw = False) is also<get-area> {
    my $a = gtk_cell_area_context_get_area($!cac);

    $a ??
      ( $raw ?? $a !! GTK::CellArea.new($a) )
      !!
      Nil;
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height {
    samewith($, $);
  }
  multi method get_preferred_height (
    $minimum_height is rw,
    $natural_height is rw
  ) {
    my gint ($mh, $nh) = 0 xx 2;

    gtk_cell_area_context_get_preferred_height($!cac, $mh, $nh);
    ($minimum_height, $natural_height) = ($mh, $nh);
  }

  proto method get_preferred_height_for_width (|)
    is also<get-preferred-height-for-width>
  { * }

  multi method get_preferred_height_for_width (
    Int() $width
  ) {
    samewith($width, $, $);
  }
  multi method get_preferred_height_for_width (
    Int() $width,
    $minimum_height is rw,
    $natural_height is rw
  ) {
    my gint ($w, $mh, $nh) = ($w, 0, 0);

    gtk_cell_area_context_get_preferred_height_for_width($!cac, $w, $mh, $nh);
    ($minimum_height, $natural_height) = ($mh, $nh);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width {
    samewith($, $);
  }
  multi method get_preferred_width ($minimum_width is rw, $natural_width is rw) {
    my gint ($mw, $nw) = 0 xx 2;

    gtk_cell_area_context_get_preferred_width($!cac, $mw, $nw);
    ($minimum_width, $natural_width) = ($mw, $nw);
  }

  proto method get_preferred_width_for_height (|)
    is also<get-preferred-width-for-height>
  { * }

  multi method get_preferred_width_for_height (Int() $height) {
    samewith($height, $, $);
  }
  multi method get_preferred_width_for_height (
    Int() $height,
    $minimum_width is rw,
    $natural_width is rw
  ) {
    my gint ($h, $mw, $nw) = ($height, 0, 0);

    gtk_cell_area_context_get_preferred_width_for_height($!cac, $h, $mw, $nw);
    ($minimum_width, $natural_width) = ($mw, $nw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_area_context_get_type, $n, $t );
  }

  method push_preferred_height (Int() $minimum_height, Int() $natural_height)
    is also<push-preferred-height>
  {
    my gint ($mh, $nh) = ($minimum_height, $natural_height);

    gtk_cell_area_context_push_preferred_height($!cac, $mh, $nh);
  }

  method push_preferred_width (Int() $minimum_width, Int() $natural_width)
    is also<push-preferred-width>
  {
    my gint ($mw, $nw) = ($minimum_width, $natural_width);

    gtk_cell_area_context_push_preferred_width($!cac, $mw, $nw);
  }

  method reset {
    gtk_cell_area_context_reset($!cac);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
