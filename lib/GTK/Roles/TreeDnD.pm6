use v6.c;

use NativeCall;


use GTK::Raw::TreeDnD:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

role GTK::Roles::TreeDragSource:ver<3.0.1146>  {
  has GtkTreeDragSource $!ds;

  method roleInit-GtkTreeDragSource {
    return if $!ds;

    my \i = findProperImplementor(self.^attributes);
    $!ds  = cast( GtkTreeDragSource, i.get_value(self) );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method drag_data_delete (GtkTreePath() $path) {
   gtk_tree_drag_source_drag_data_delete($!ds, $path);
  }

  method drag_data_get (
    GtkTreePath() $path,
    GtkSelectionData() $selection_data
  ) {
   gtk_tree_drag_source_drag_data_get($!ds, $path, $selection_data);
  }

  method row_draggable (GtkTreePath() $path) {
   gtk_tree_drag_source_row_draggable($!ds, $path);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

role GTK::Roles::TreeDragDest:ver<3.0.1146>  {
  has GtkTreeDragDest $!dd;

  method !roleInit-GtkTreeDragDest {
    return if $!dd;

    my \i = findProperImplementor(self.^attributes);
    $!dd  = cast( GtkTreeDragDest, i.get_value(self) );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method drag_data_received (
    GtkTreePath() $dest,
    GtkSelectionData() $selection_data
  ) {
   gtk_tree_drag_dest_drag_data_received($!dd, $dest, $selection_data);
  }

  method dragdest_role_get_type {
   gtk_tree_drag_dest_get_type();
  }

  method row_drop_possible (
    GtkTreePath() $dest_path,
    GtkSelectionData() $selection_data
  ) {
   gtk_tree_drag_dest_row_drop_possible($!dd, $dest_path, $selection_data);
 }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
