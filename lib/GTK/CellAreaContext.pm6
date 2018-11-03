use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::CellAreaContext;
use GTK::Raw::Types;

class GTK::CellAreaContext {
  has GtkCellAreaContext $!cac;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkCellArea
  method area is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cac, 'area', $gv); );
        GTK::CellArea.new( nativecast(GtkCellArea, $gv.pointer) );
      },
      STORE => -> $, GtkCellArea() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!cac, 'area', $gv);
      }
    );
  }

  # Type: gint
  method minimum-height is rw is also<minimum_height> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cac, 'minimum-height', $gv); );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "minimum-height does not allow writing"
      }
    );
  }

  # Type: gint
  method minimum-width is rw is also<minimum_width> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cac, 'minimum-width', $gv); );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "minimum-width does not allow writing"
      }
    );
  }

  # Type: gint
  method natural-height is rw is also<natural_height> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cac, 'natural-height', $gv); );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "natural-height does not allow writing"
      }
    );
  }

  # Type: gint
  method natural-width is rw is also<natural_width> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!cac, 'natural-width', $gv); );
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
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_allocate($!cac, $w, $h);
  }

  method get_allocation (Int() $width, Int() $height) is also<get-allocation> {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_get_allocation($!cac, $w, $h);
  }

  method get_area is also<get-area> {
    gtk_cell_area_context_get_area($!cac);
  }

  method get_preferred_height (Int() $minimum_height, Int() $natural_height) is also<get-preferred-height> {
    my @i = ($minimum_height, $natural_height);
    my gint ($mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_get_preferred_height($!cac, $mh, $nh);
  }

  method get_preferred_height_for_width (
    Int() $width,
    Int() $minimum_height,
    Int() $natural_height
  ) is also<get-preferred-height-for-width> {
    my @i = ($width, $minimum_height, $natural_height);
    my gint ($w, $mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_get_preferred_height_for_width($!cac, $w, $mh, $nh);
  }

  method get_preferred_width (Int() $minimum_width, Int() $natural_width) is also<get-preferred-width> {
    my @i = ($minimum_width, $natural_width);
    my gint ($mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_get_preferred_width($!cac, $mw, $nw);
  }

  method get_preferred_width_for_height (
    Int() $height,
    Int() $minimum_width,
    Int() $natural_width
  ) is also<get-preferred-width-for-height> {
    my @i = ($height, $minimum_width, $natural_width);
    my gint ($h, $mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_get_preferred_width_for_height($!cac, $h, $mw, $nw);
  }

  method get_type is also<get-type> {
    gtk_cell_area_context_get_type();
  }

  method push_preferred_height (Int() $minimum_height, Int() $natural_height) is also<push-preferred-height> {
    my @i = ($minimum_height, $natural_height);
    my gint ($mh, $nh) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_push_preferred_height($!cac, $mh, $nh);
  }

  method push_preferred_width (Int() $minimum_width, Int() $natural_width) is also<push-preferred-width> {
    my @i = ($minimum_width, $natural_width);
    my gint ($mw, $nw) = self.RESOLVE-INT(@i);
    gtk_cell_area_context_push_preferred_width($!cac, $mw, $nw);
  }

  method reset {
    gtk_cell_area_context_reset($!cac);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

