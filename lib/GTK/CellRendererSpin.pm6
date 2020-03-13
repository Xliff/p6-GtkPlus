use v6.c;

use Method::Also;

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
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellspin) {
    my $to-parent;
    given $cellspin {
      when CellRendererSpinAncestry {
        $!crs = do {
          when GtkCellRendererSpin {
            $to-parent = cast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkCellRendererSpin, $_);
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

  method GTK::Raw::Definitions::GtkCellRendererSpin
    is also<
      CellRendererSpin
      GtkCellRendererspin
    >
  { $!crs }

  multi method new (CellRendererSpinAncestry $cellspin) {
    $cellspin ?? self.bless(:$cellspin) !! Nil
  }
  multi method new {
    my $cellspin = gtk_cell_renderer_spin_new();

    $cellspin ?? self.bless(:$cellspin) !! Nil
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
      FETCH => sub ($) {
        self.prop_get('adjustment', $gv);
        GTK::Adjustment.new( cast(GtkAdjustment, $gv.pointer ) );
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
        self.prop_get('digits', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('digits', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_spin_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
