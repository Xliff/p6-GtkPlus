use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::TreeModelSort;

sub gtk_tree_model_sort_clear_cache (GtkTreeModelSort $tree_model_sort)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_convert_child_iter_to_iter (
  GtkTreeModelSort $tree_model_sort,
  GtkTreeIter $sort_iter,
  GtkTreeIter $child_iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_convert_child_path_to_path (
  GtkTreeModelSort $tree_model_sort,
  GtkTreePath $child_path
)
  returns GtkTreePath
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_convert_iter_to_child_iter (
  GtkTreeModelSort $tree_model_sort,
  GtkTreeIter $child_iter,
  GtkTreeIter $sorted_iter
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_convert_path_to_child_path (
  GtkTreeModelSort $tree_model_sort,
  GtkTreePath $sorted_path
)
  returns GtkTreePath
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_get_model (GtkTreeModelSort $tree_model)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_iter_is_valid (
  GtkTreeModelSort $tree_model_sort,
  GtkTreeIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_new_with_model (GtkTreeModel $child_model)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_tree_model_sort_reset_default_sort_func (
  GtkTreeModelSort $tree_model_sort
)
  is native(gtk)
  is export
  { * }