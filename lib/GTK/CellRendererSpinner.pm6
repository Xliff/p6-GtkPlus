use v6.c;

use Method::Also;

use GTK::Raw::CellRendererSpinner;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellRenderer;

our subset CellRendererSpinnerAncestry is export
  where GtkCellRendererSpinner | GtkCellRenderer;

class GTK::CellRendererSpinner is GTK::CellRenderer {
  has GtkCellRendererSpinner $!crs is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellspin) {
    my $to-parent;
    given $cellspin {
      when CellRendererSpinnerAncestry {
        $!crs = do {
          when GtkCellRendererSpinner {
            $to-parent = cast(GtkCellRenderer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkCellRendererSpinner, $_);
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

  method GTK::Raw::Definitions::CellRendererSpinner
    is also<
      CellRendererSpinner
      GtkCellRendererSpinner
    >
  { $!crs }

  multi method new (CellRendererSpinnerAncestry $cellspin) {
    $cellspin ?? self.bless(:$cellspin) !! Nil;
  }
  multi method new {
    my $cellspin = gtk_cell_renderer_spinner_new();

    $cellspin ?? self.bless(:$cellspin) !! Nil;
  }



  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method active is rw {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv)
      }
    );
  }

  # Type: guint
  method pulse is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pulse', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('pulse', $gv)
      }
    );
  }

  # Type: GtkIconSize
  method size is rw {
    my GLib::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size', $gv);
        GtkIconSizeEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('size', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_cell_renderer_spinner_get_type,
      $n,
      $t
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
