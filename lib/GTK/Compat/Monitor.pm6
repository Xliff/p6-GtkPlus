use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Rectangle;
use GTK::Compat::Types;
use GTK::Compat::Raw::Monitor;

use GTK::Roles::Types;
use GTK::Roles::Signals::Generic;

class GTK::Compat::Monitor {
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals::Generic;

  has GdkMonitor $!mon is implementor;

  submethod BUILD(:$monitor) {
    $!mon = $monitor;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkMonitor, gpointer --> void
  method invalidate {
    self.connect($!mon, 'invalidate');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GdkDisplay
  method display is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('display', $gv)
        );
        GTK::Compat::Rectangle.new( cast(GdkRectangle, $gv.object) );
      },
      STORE => -> $, GdkRectangle() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: GdkRectangle
  method geometry is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('geometry', $gv)
        );
        GTK::Compat::Rectangle.new( cast(GdkRectangle, $gv.object) )
      },
      STORE => -> $, $val is copy {
        warn "geometry does not allow writing"
      }
    );
  }

  # Type: gint
  method height-mm is rw is also<height_mm> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('height-mm', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "height-mm does not allow writing"
      }
    );
  }

  # Type: gchar
  method manufacturer is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('manufacturer', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "manufacturer does not allow writing"
      }
    );
  }

  # Type: gchar
  method model is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('model', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "model does not allow writing"
      }
    );
  }

  # Type: gint
  method refresh-rate is rw is also<refresh_rate> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('refresh-rate', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "refresh-rate does not allow writing"
      }
    );
  }

  # Type: gint
  method scale-factor is rw is also<scale_factor> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-factor', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "scale-factor does not allow writing"
      }
    );
  }

  # Type: GdkSubpixelLayout
  method subpixel-layout is rw is also<subpixel_layout> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('subpixel-layout', $gv)
        );
        GdkSubpixelLayout( $gv.uint );
      },
      STORE => -> $, $val is copy {
        warn "subpixel-layout does not allow writing"
      }
    );
  }

  # Type: gint
  method width-mm is rw is also<width_mm> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('width-mm', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "width-mm does not allow writing"
      }
    );
  }

  # Type: GdkRectangle
  method workarea is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('workarea', $gv)
        );
        GTK::Compat::Rectangle.new( cast(GdkRectangle, $gv.object) );
      },
      STORE => -> $, $val is copy {
        warn "workarea does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_display is also<get-display> {
    gdk_monitor_get_display($!mon);
  }

  method get_geometry (GdkRectangle() $geometry) is also<get-geometry> {
    gdk_monitor_get_geometry($!mon, $geometry);
  }

  method get_height_mm is also<get-height-mm> {
    gdk_monitor_get_height_mm($!mon);
  }

  method get_manufacturer is also<get-manufacturer> {
    gdk_monitor_get_manufacturer($!mon);
  }

  method get_model is also<get-model> {
    gdk_monitor_get_model($!mon);
  }

  method get_refresh_rate is also<get-refresh-rate> {
    gdk_monitor_get_refresh_rate($!mon);
  }

  method get_scale_factor is also<get-scale-factor> {
    gdk_monitor_get_scale_factor($!mon);
  }

  method get_subpixel_layout is also<get-subpixel-layout> {
    gdk_monitor_get_subpixel_layout($!mon);
  }

  method get_type is also<get-type> {
    gdk_monitor_get_type();
  }

  method get_width_mm is also<get-width-mm> {
    gdk_monitor_get_width_mm($!mon);
  }

  method get_workarea (GdkRectangle() $workarea) is also<get-workarea> {
    gdk_monitor_get_workarea($!mon, $workarea);
  }

  method is_primary is also<is-primary> {
    gdk_monitor_is_primary($!mon);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
