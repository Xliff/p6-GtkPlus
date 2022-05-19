use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::TreeDnD:ver<3.0.1146>;

sub gtk_tree_drag_source_drag_data_delete (
  GtkTreeDragSource $drag_source,
  GtkTreePath $path
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_drag_source_drag_data_get (
  GtkTreeDragSource $drag_source,
  GtkTreePath $path,
  GtkSelectionData $selection_data
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_drag_dest_drag_data_received (
  GtkTreeDragDest $drag_dest,
  GtkTreePath $dest,
  GtkSelectionData $selection_data
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_drag_dest_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_drag_dest_row_drop_possible (
  GtkTreeDragDest $drag_dest,
  GtkTreePath $dest_path,
  GtkSelectionData $selection_data
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_get_row_drag_data (
  GtkSelectionData $selection_data,
  GtkTreeModel $tree_model,
  GtkTreePath $path
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_set_row_drag_data (
  GtkSelectionData $selection_data,
  GtkTreeModel $tree_model,
  GtkTreePath $path
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_drag_source_row_draggable (
  GtkTreeDragSource $drag_source,
  GtkTreePath $path
)
  returns uint32
  is native(gtk)
  is export
  { * }