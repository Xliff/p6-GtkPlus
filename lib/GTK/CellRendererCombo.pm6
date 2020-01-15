use v6.c;

use Method::Also;

use GTK::Raw::CellRendererCombo;
use GTK::Raw::Types;

use GLib::Value;
use GTK::CellRendererText;
use GTK::ComboBox;
use GTK::Roles::TreeModel;

our subset CellRendererComboAncestry is export
  where GtkCellRendererCombo | CellRendererTextAncestry;

class GTK::CellRendererCombo is GTK::CellRendererText {
  has GtkCellRendererCombo $!crc is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$cellcombo) {
    my $to-parent;
    given $cellcombo {
      when GtkCellRendererCombo | GtkCellRenderer {
        $!crc = do {
          when GtkCellRenderer {
            $to-parent = $_;
            cast(GtkCellRendererCombo, $_);
          }
          when GtkCellRendererCombo  {
            $to-parent = cast(GtkCellRenderer, $_);
            $_;
          }
        }
        self.setCellRendererText($to-parent);
      }
      when GTK::CellRendererCombo {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkCellRendererCombo
    is also<
      CellRendererCombo
      GtkCellRendererCombo
    >
  { $!crc }

  multi method new (CellRendererComboAncestry $cellcombo) {
    self.bless(:$cellcombo);
  }
  multi method new {
    my $cellcombo = gtk_cell_renderer_combo_new();

    $cellcombo ?? self.bless(:$cellcombo) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method has-entry is rw is also<has_entry> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('has-entry', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-entry', $gv)
      }
    );
  }

  # Type: GtkTreeModel
  method model (:$raw = False) is rw {
    my GLib::Value $gv .= new(G_TYPE_OBJECT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('model', $gv);

        my $v = $gv.object;

        return Nil unless $v;
        $v = cast(GtkTreeModel, $v);
        $raw ?? $v !! GTK::Roles::TreeModel.new-treemodel-obj($v);
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        # $gv.object = $val;
        # self.prop_set('model', $gv)
        raw_set_cellrenderercombo_model($!crc, 'model', $val, Str);
      }
    );
  }

  # Type: gint
  method text-column is rw is also<text_column> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('text-column', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('text-column', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_combo_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
