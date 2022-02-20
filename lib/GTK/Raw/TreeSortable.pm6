use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::TreeSortable:ver<3.0.1146>;

sub gtk_tree_sortable_get_sort_column_id (
  GtkTreeSortable $sortable,
  gint $sort_column_id is rw,
  guint $order                  # GtkSortType $order
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_has_default_sort_func (GtkTreeSortable $sortable)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_set_default_sort_func (
  GtkTreeSortable $sortable,
  &function (GtkTreeModel, GtkTreeIter, GtkTreeIter, gpointer --> gint),
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_set_sort_column_id (
  GtkTreeSortable $sortable,
  gint $sort_column_id,
  uint32 $order                 # GtkSortType $order
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_set_sort_func (
  GtkTreeSortable $sortable,
  gint $sort_column_id,
  GtkTreeIterCompareFunc $sort_func,
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_sortable_sort_column_changed (GtkTreeSortable $sortable)
  is native(gtk)
  is export
  { * }
