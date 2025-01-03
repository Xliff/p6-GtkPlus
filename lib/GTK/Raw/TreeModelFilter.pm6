use v6.c;

use NativeCall;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TreeModelFilter:ver<3.0.1146>;

sub gtk_tree_model_filter_clear_cache (GtkTreeModelFilter $filter)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_convert_child_iter_to_iter (
  GtkTreeModelFilter $filter,
  GtkTreeIter $filter_iter,
  GtkTreeIter $child_iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_convert_child_path_to_path (
  GtkTreeModelFilter $filter,
  GtkTreePath $child_path
)
  returns GtkTreePath
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_convert_iter_to_child_iter (
  GtkTreeModelFilter $filter,
  GtkTreeIter $child_iter,
  GtkTreeIter $filter_iter
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_convert_path_to_child_path (
  GtkTreeModelFilter $filter,
  GtkTreePath $filter_path
)
  returns GtkTreePath
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_get_model (GtkTreeModelFilter $filter)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_new (GtkTreeModel $child_model, GtkTreePath $root)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_refilter (GtkTreeModelFilter $filter)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_set_modify_func (
  GtkTreeModelFilter $filter,
  gint $n_columns,
  CArray[GType] $types,
  &func (GtkTreeModel, GtkTreeIter, GValue, gint, gpointer),
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_set_visible_column (
  GtkTreeModelFilter $filter,
  gint $column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_filter_set_visible_func (
  GtkTreeModelFilter $filter,
  &func (GtkTreeModel, GtkTreeIter, gpointer --> gboolean),
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }
