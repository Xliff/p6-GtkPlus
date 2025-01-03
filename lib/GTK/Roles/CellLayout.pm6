use v6.c;

use NativeCall;

use GTK::Raw::CellLayout:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::LatchedContents:ver<3.0.1146>;

use GTK::CellRenderer:ver<3.0.1146>;

role GTK::Roles::CellLayout:ver<3.0.1146> {
  also does GTK::Roles::LatchedContents;

  has GtkCellLayout $!cl;

  method roleInit-GtkCellLayout {
    return if $!cl;

    my \i = findProperImplementor(self.^attributes);
    $!cl  = cast( GtkCellLayout, i.get_value(self) );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_attribute (
    GtkCellRenderer() $cell,
    Str()             $attribute,
    Int()             $column
  ) {
    my gint $c = $column;

    gtk_cell_layout_add_attribute($!cl, $cell, $attribute, $c);
  }

  method clear {
    gtk_cell_layout_clear($!cl);
  }

  method clear_layout_attributes (GtkCellRenderer() $cell) {
    gtk_cell_layout_clear_attributes($!cl, $cell);
  }

  method get_area {
    gtk_cell_layout_get_area($!cl);
  }

  method get_cells {
    gtk_cell_layout_get_cells($!cl);
  }

  method get_celllayout_type {
    gtk_cell_layout_get_type();
  }

  multi method layout_pack_end (
    GTK::CellRenderer $cell,
    Int()             $expand = 0
  ) {
    self.unshift-end: $cell;
    self.SET-LATCH;
    samewith($cell.cellrenderer, $expand);
  }
  multi method layout_pack_end (
    GtkCellRenderer $cell,
    Int()           $expand = 0
  ) {
    self.unshift-end: $cell unless self.IS-LATCHED;
    self.UNSET-LATCH;

    my gboolean $e = $expand.so.Int;

    gtk_cell_layout_pack_end($!cl, $cell, $e);
  }

  multi method layout_pack_start (
    GTK::CellRenderer $cell,
    Int()             $expand = 0
  ) {
    self.push-start: $cell;
    self.SET-LATCH;
    samewith($cell.CellRenderer, $expand);
  }
  multi method layout_pack_start (
    GtkCellRenderer $cell,
    Int()           $expand = 0
  ) {
    self.push-start: $cell unless self.IS-LATCHED;
    self.UNSET-LATCH;

    my gboolean $e = $expand.so.Int;

    gtk_cell_layout_pack_start($!cl, $cell, $e);
  }

  method reorder (GtkCellRenderer() $cell, Int() $position) {
    my gint $p = $position;

    gtk_cell_layout_reorder($!cl, $cell, $p);
  }

  method set_attribute (
    GtkCellRenderer() $cell,
    Str()             $attribute,
    Int()             $column
  ) {
    my gint $c = $column;

    gtk_cell_layout_set_attributes($!cl, $cell, $attribute, $c, Str);
  }

  my constant DC := %DEFAULT-CALLBACKS;

  method set_cell_data_func (
    GtkCellRenderer()     $cell,
    GtkCellLayoutDataFunc $func,
    gpointer              $func_data = gpointer,
                          &destroy   = DC<GDestroyNotify>
  ) {
    gtk_cell_layout_set_cell_data_func(
      $!cl,
      $cell,
      $func,
      $func_data,
      &destroy
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
