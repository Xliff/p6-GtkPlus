use v6.c;

use Method::Also;

use GTK::Raw::CellRendererAccel;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellRendererText;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::CellRendererAccel;

our subset CellRendererAccelAncestry is export
  where GtkCellRendererAccel | CellRendererTextAncestry;

class GTK::CellRendererAccel is GTK::CellRendererText {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::CellRendererAccel;

  has GtkCellRendererAccel $!cra is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellaccel) {
    my $to-parent;
    given $cellaccel {
      when CellRendererAccelAncestry {
        $!cra = do {
          when GtkCellRendererAccel  {
            $to-parent = cast(GtkCellRendererText, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkCellRendererAccel, $_);
          }
        }
        self.setCellRendererText($to-parent);
      }
      when GTK::CellRendererAccel {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all(%!signals-cra);
  }

  multi method new (CellRendererAccelAncestry $cellaccel) {
    $cellaccel ?? self.bless(:$cellaccel) !! Nil;
  }
  multi method new {
    my $cellaccel = gtk_cell_renderer_accel_new();

    $cellaccel ?? self.bless(:$cellaccel) !! Nil;
  }


  method GTK::Raw::Definitions::GtkCellRendererAccel
    is also<GtkCellRendererAccel>
  { $!cra }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRendererAccel, gchar, gpointer --> void
  method accel-cleared is also<accel_cleared> {
    self.connect-string($!cra, 'accel-cleared');
  }

  # Is originally:
  # GtkCellRendererAccel, gchar, guint, GdkModifierType, guint, gpointer --> void
  method accel-edited is also<accel_edited> {
    self.connect-accel-edited($!cra);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: guint
  method accel-key is rw is also<accel_key> {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('accel-key', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('accel-key', $gv);
      }
    );
  }

  # Type: GtkCellRendererAccelMode
  method accel-mode is rw is also<accel_mode> {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('accel-mode', $gv);
        GtkCellRendererAccelModeEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('accel-mode', $gv);
      }
    );
  }

  # Type: GdkModifierType
  method accel-mods is rw is also<accel_mods> {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('accel-mods', $gv);
        GdkModifierTypeEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('accel-mods', $gv);
      }
    );
  }

  # Type: guint
  method keycode is rw {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('keycode', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('keycode', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑


  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_accel_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
