use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererAccel;
use GTK::Raw::Types;

use GTK::CellRendererText;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::CellRendererAccel;

class GTK::CellRendererAccel is GTK::CellRendererText {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::CellRendererAccel;

  has GtkCellRendererAccel $!cra;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererAccel');
    $o;
  }

  submethod BUILD(:$cellaccel) {
    my $to-parent;
    given $cellaccel {
      when GtkCellRendererAccel | GtkCellRenderer {
        $!cra = do {
          when GtkCellRenderer {
            $to-parent = $_;
            nativecast(GtkCellRendererAccel, $_);
          }
          when GtkCellRendererAccel  {
            $to-parent = nativecast(GtkCellRendererText, $_);
            $_;
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

  method new {
    my $cellaccel = gtk_cell_renderer_accel_new();
    self.bless(:$cellaccel);
  }

  method GTK::Raw::Types::GtkCelRendererAccel {
    $!cra;
  }

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
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-key', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!cra, 'accel-key', $gv);
      }
    );
  }

  # Type: GtkCellRendererAccelMode
  method accel-mode is rw is also<accel_mode> {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-mode', $gv);
        GtkCellRendererAccelMode( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!cra, 'accel-mode', $gv);
      }
    );
  }

  # Type: GdkModifierType
  method accel-mods is rw is also<accel_mods> {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-mods', $gv);
        GdkModifierType( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!cra, 'accel-mods', $gv);
      }
    );
  }

  # Type: guint
  method keycode is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'keycode', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!cra, 'keycode', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑


  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_renderer_accel_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

