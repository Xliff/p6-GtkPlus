use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::CellEditable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;

role GTK::Roles::CellEditable:ver<3.0.1146> {
  also does GTK::Roles::Signals::Generic;

  has GtkCellEditable $!ce;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellEditable, gpointer --> void
  method editing-done is also<editing_done> {
    self.connect($!ce, 'editing-done');
  }

  # Is originally:
  # GtkCellEditable, gpointer --> void
  method remove-widget is also<remove_widget> {
    self.connect($!ce, 'remove-widget');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method editing-canceled is rw is also<editing_canceled> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('editing-canceled', $gv) );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editing-canceled', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method emit_editing_done is also<emit-editing-done> {
    gtk_cell_editable_editing_done($!ce);
  }

  method get_celleditable_type is also<get-celleditable-type> {
    gtk_cell_editable_get_type();
  }

  method emit_remove_widget is also<emit-remove-widget> {
    gtk_cell_editable_remove_widget($!ce);
  }

  method start_editing (GdkEvent $event) is also<start-editing> {
    gtk_cell_editable_start_editing($!ce, $event);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
