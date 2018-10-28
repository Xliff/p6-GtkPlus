use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TreeModelFilter;

sub gtk_tree_model_filter_clear_cache (GtkTreeModelFilter $filter)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_convert_child_iter_to_iter (
  GtkTreeModelFilter $filter,
  GtkTreeIter $filter_iter,
  GtkTreeIter $child_iter
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_convert_child_path_to_path (
  GtkTreeModelFilter $filter,
  GtkTreePath $child_path
)
  returns GtkTreePath
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_convert_iter_to_child_iter (
  GtkTreeModelFilter $filter,
  GtkTreeIter $child_iter,
  GtkTreeIter $filter_iter
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_convert_path_to_child_path (
  GtkTreeModelFilter $filter,
  GtkTreePath $filter_path
)
  returns GtkTreePath
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_get_model (GtkTreeModelFilter $filter)
  returns GtkTreeModel
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_new (GtkTreeModel $child_model, GtkTreePath $root)
  returns GtkTreeModel
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_refilter (GtkTreeModelFilter $filter)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_set_modify_func (
  GtkTreeModelFilter $filter,
  gint $n_columns,
  GType $types,
  GtkTreeModelFilterModifyFunc $func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_set_visible_column (
  GtkTreeModelFilter $filter,
  gint $column
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tree_model_filter_set_visible_func (
  GtkTreeModelFilter $filter,
  GtkTreeModelFilterVisibleFunc $func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native($LIBGTK)
  is export
  { * }