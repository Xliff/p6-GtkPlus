use v6.c;

use NativeCall;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::CellEditable;
use GTK::Raw::Types;

use GTK::Roles::Signals;
use GTK::Roles::Types;

role GTK::Roles::CellEditable {
  also does GTK::Roles::Signals;
  also does GTK::Roles::Types;

  has GtkCellEditable $!ce;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellEditable, gpointer --> void
  method editing-done {
    self.connect($!ce, 'editing-done');
  }

  # Is originally:
  # GtkCellEditable, gpointer --> void
  method remove-widget {
    self.connect($!ce, 'remove-widget');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method editing-canceled is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!ce, 'editing-canceled', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!ce, 'editing-canceled', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method editing_done {
    gtk_cell_editable_editing_done($!ce);
  }

  method role_editable_get_type  {
    gtk_cell_editable_get_type();
  }

  method remove_widget {
    gtk_cell_editable_remove_widget($!ce);
  }

  method start_editing (GdkEvent $event) {
    gtk_cell_editable_start_editing($!ce, $event);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
