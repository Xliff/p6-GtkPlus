use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererSpinner;
use GTK::Raw::Types;

use GTK::CellRenderer;

our subset CellRendererSpinnerAncestry is export 
  where GtkCellRendererSpinner | GtkCellRenderer;

class GTK::CellRendererSpinner is GTK::CellRenderer {
  has GtkCellRendererSpinner $!crs is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererSpinner');
    $o;
  }

  submethod BUILD(:$cellspin) {
    my $to-parent;
    given $cellspin {
      when CellRendererSpinnerAncestry {
        $!crs = do {
          when GtkCellRendererSpinner {
            $to-parent = nativecast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkCellRendererSpinner, $_);
          }
        }
        self.setCellRenderer($to-parent);
      }
      when GTK::CellRendererSpinner {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::CellRendererSpinner 
    is also<CellRendererSpinner>
  { $!crs }

  multi method new {
    my $cellspin = gtk_cell_renderer_spinner_new();
    self.bless(:$cellspin);
  }
  multi method new (CellRendererSpinnerAncestry $cellspin) {
    self.bless(:$cellspin);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method active is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('active', $gv)
      }
    );
  }

  # Type: guint
  method pulse is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('pulse', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE.UINT($val);
        self.prop_set('pulse', $gv)
      }
    );
  }

  # Type: GtkIconSize
  method size is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('size', $gv);
        GtkIconSize( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set('size', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_renderer_spinner_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
