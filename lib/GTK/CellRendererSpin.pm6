use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererSpin;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Adjustment;
use GTK::CellRendererText;

our subset CellRendererSpinAncestry is export
  where GtkCellRendererSpin | CellRendererTextAncestry;

class GTK::CellRendererSpin is GTK::CellRendererText {
  has GtkCellRendererSpin $!crs is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererSpin');
    $o;
  }

  submethod BUILD(:$cellspin) {
    my $to-parent;
    given $cellspin {
      when CellRendererSpinAncestry {
        $!crs = do {
          when GtkCellRendererSpin {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkCellRendererSpin, $_);
          }
        }
        self.setCellRendererText($to-parent);
      }
      when GTK::CellRendererSpin {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkCellRendererSpin
    is also<CellRendererSpin>
  { $!crs }

  multi method new {
    my $cellspin = gtk_cell_renderer_spin_new();
    self.bless(:$cellspin);
  }
  multi method new (CellRendererSpinAncestry $cellspin) {
    self.bless(:$cellspin);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkAdjustment
  method adjustment is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('adjustment', $gv);
        GTK::Adjustment.new( nativecast(GtkAdjustment, $gv.pointer ) );
      },
      STORE => -> $, GtkAdjustment() $val is copy {
        $gv.pointer = $val;
        self.prop_set('adjustment', $gv)
      }
    );
  }

  # Type: gdouble
  method climb-rate is rw is also<climb_rate> {
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('climb-rate', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('climb-rate', $gv)
      }
    );
  }

  # Type: guint
  method digits is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('digits', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set('digits', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_renderer_spin_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
