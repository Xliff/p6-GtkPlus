use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererAccel;
use GTK::Raw::Types;

use GTK::CellRendererText;

class GTK::CellRendererAccel is GTK::CellRendererText {
  has GtkCellRendererAccel $!cra;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererAccel');
    $o;
  }

  submethod BUILD(:$cellaccel) {
    my $to-parent;
    given $cellaccel {
      when GtkCellRendererAccel | GtkWidget {
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

  method new {
    my $cellaccel = gtk_cell_renderer_accel_new();
    self.bless(:$cellaccel);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRendererAccel, gchar, gpointer --> void
  method accel-cleared {
    self.connect($!cra, 'accel-cleared');
  }

  # Is originally:
  # GtkCellRendererAccel, gchar, guint, GdkModifierType, guint, gpointer --> void
  method accel-edited {
    self.connect($!cra, 'accel-edited');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: guint
  method accel-key is rw {
    my GValue $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-key', $gv);
  #        $gv.get_TYPE;
      },
      STORE => -> $, $val is copy {
  #        $gv.set_TYPE($val);
        self.prop_set($!cra, 'accel-key', $gv);
      }
    );
  }

  # Type: GtkCellRendererAccelMode
  method accel-mode is rw {
    my GValue $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-mode', $gv);
  #        $gv.get_TYPE;
      },
      STORE => -> $, $val is copy {
  #        $gv.set_TYPE($val);
        self.prop_set($!cra, 'accel-mode', $gv);
      }
    );
  }

  # Type: GdkModifierType
  method accel-mods is rw {
    my GValue $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'accel-mods', $gv);
  #        $gv.get_TYPE;
      },
      STORE => -> $, $val is copy {
  #        $gv.set_TYPE($val);
        self.prop_set($!cra, 'accel-mods', $gv);
      }
    );
  }

  # Type: guint
  method keycode is rw {
    my GValue $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!cra, 'keycode', $gv);
  #        $gv.get_TYPE;
      },
      STORE => -> $, $val is copy {
  #        $gv.set_TYPE($val);
        self.prop_set($!cra, 'keycode', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑


  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_cell_renderer_accel_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
