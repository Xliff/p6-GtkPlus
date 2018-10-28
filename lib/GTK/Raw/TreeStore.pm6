use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TreeStore;

# GtkTreeStore *gtk_tree_store_new (
#   gint          n_columns,
#   ...
# );
#
# void          gtk_tree_store_set (
#   GtkTreeStore *tree_store,
#   GtkTreeIter  *iter,
#   ...
# );
#
# void          gtk_tree_store_insert_with_values (
#   GtkTreeStore *tree_store,
#   GtkTreeIter  *iter,
#   GtkTreeIter  *parent,
#   gint          position,
#   ...
# );

sub gtk_tree_store_append (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_clear (GtkTreeStore $tree_store)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_insert (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_insert_after (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent,
  GtkTreeIter $sibling
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_insert_before (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent,
  GtkTreeIter $sibling
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_insert_with_valuesv (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent,
  gint $position,
  CArray[int32] $columns,
  CArray[GValue] $values,
  gint $n_values
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_is_ancestor (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $descendant
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_iter_depth (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_iter_is_valid (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_move_after (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $position
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_move_before (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $position
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_newv (gint $n_columns, CArray[GType] $types)
  returns GtkTreeStore
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_prepend (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  GtkTreeIter $parent
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_remove (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_reorder (
  GtkTreeStore $tree_store,
  GtkTreeIter $parent,
  CArray[int32] $new_order
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_set_column_types (
  GtkTreeStore $tree_store,
  gint $n_columns,
  CArray[GType] $types
)
  is native(gtk)
  is export
  { * }

# sub gtk_tree_store_set_valist (
#   GtkTreeStore $tree_store,
#   GtkTreeIter $iter,
#   va_list $var_args
# )
#   is native(gtk)
#   is export
#   { * }

sub gtk_tree_store_set_value (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  gint $column,
  GValue $value
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_set_valuesv (
  GtkTreeStore $tree_store,
  GtkTreeIter $iter,
  CArray[int32] $columns,
  CArray[GValue] $values,
  gint $n_values
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_store_swap (
  GtkTreeStore $tree_store,
  GtkTreeIter $a,
  GtkTreeIter $b
)
  is native(gtk)
  is export
  { * }