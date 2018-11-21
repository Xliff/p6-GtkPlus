use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CellRendererCombo;
use GTK::Raw::Types;

use GTK::CellRendererText;
use GTK::ComboBox;

class GTK::CellRendererCombo is GTK::CellRendererText {
  has GtkCellRendererCombo $!crc;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CellRendererCombo');
    $o;
  }

  submethod BUILD(:$cellcombo) {
    my $to-parent;
    given $cellcombo {
      when GtkCellRendererCombo | GtkCellRenderer {
        $!crc = do {
          when GtkCellRenderer {
            $to-parent = $_;
            nativecast(GtkCellRendererCombo, $_);
          }
          when GtkCellRendererCombo  {
            $to-parent = nativecast(GtkCellRenderer, $_);
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

  method GTK::Raw::Types::GtkCellRendererCombo {
    $!crc;
  }

  method GTK::Raw::Types::GtkComboBox is also<combobox> {
    nativecast(GtkComboBox, $!crc);
  }

  method combobox_obj {
    GTK::ComboBox.new( self.combobox );
  }

  multi method new {
    my $cellcombo = gtk_cell_renderer_combo_new();
    self.bless(:$cellcombo);
  }
  multi method new (GtkCellRendererCombo $cellcombo) {
    self.bless(:$cellcombo);
  }
  multi method new (GtkCellRenderer $cellcombo) {
    self.bless(:$cellcombo);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method has-entry is rw is also<has_entry> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('has-entry', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('has-entry', $gv);
      }
    );
  }

  # Type: GtkTreeModel
  method model is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_OBJECT);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('model', $gv); );
        nativecast(GtkTreeModel, $gv.object);
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        # $gv.object = $val;
        # self.prop_set('model', $gv);
        raw_set_cellrenderercombo_model($!crc, 'model', $val, Str);
      }
    );
  }

  # Type: gint
  method text-column is rw is also<text_column> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('text-column', $gv); );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('text-column', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_cell_renderer_combo_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
