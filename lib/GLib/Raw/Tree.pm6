use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Tree;

sub g_tree_destroy (GTree $tree)
  is native(glib)
  is export
{ * }

# This may cause a difficult to trace error. To invoke either sub,
# the callback will, at minimum, need to be STRONGLY TYPED!
multi sub g_tree_foreach (
  GTree $tree,
  &traverse_func (Str, Pointer, Pointer --> gboolean),
  gpointer $user_data
)
  is native(glib)
  is export
{ * }
multi sub g_tree_foreach (
  GTree $tree,
  &traverse_func (Pointer, Pointer, Pointer --> gboolean),
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_tree_height (GTree $tree)
  returns gint
  is native(glib)
  is export
{ * }

multi sub g_tree_insert (GTree $tree, Str $key, gpointer $value)
  is native(glib)
  is export
{ * }
multi sub g_tree_insert (GTree $tree, gpointer $key, gpointer $value)
  is native(glib)
  is export
{ * }

multi sub g_tree_lookup (GTree $tree, Str $key)
  returns Pointer
  is native(glib)
  is export
{ * }
multi sub g_tree_lookup (GTree $tree, gconstpointer $key)
  returns Pointer
  is native(glib)
  is export
{ * }

multi sub g_tree_lookup_extended (
  GTree $tree,
  Str $lookup_key,
  CArray[Str] $orig_key,
  CArray[gpointer] $value
)
  returns uint32
  is native(glib)
  is export
{ * }
multi sub g_tree_lookup_extended (
  GTree $tree,
  gconstpointer $lookup_key,
  CArray[gpointer] $orig_key,
  CArray[gpointer] $value
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_tree_new (GCompareFunc $key_compare_func)
  returns GTree
  is native(glib)
  is export
{ * }

sub g_tree_new_full (
  GCompareDataFunc $key_compare_func,
  gpointer $key_compare_data,
  GDestroyNotify $key_destroy_func,
  GDestroyNotify $value_destroy_func
)
  returns GTree
  is native(glib)
  is export
{ * }

sub g_tree_new_with_data (
  GCompareDataFunc $key_compare_func,
  gpointer $key_compare_data
)
  returns GTree
  is native(glib)
  is export
{ * }

sub g_tree_nnodes (GTree $tree)
  returns gint
  is native(glib)
  is export
{ * }

sub g_tree_ref (GTree $tree)
  returns GTree
  is native(glib)
  is export
{ * }

multi sub g_tree_remove (
  GTree $tree,
  Str $key
)
  returns uint32
  is native(glib)
  is export
{ * }
multi sub g_tree_remove (
  GTree $tree,
  gpointer $key
)
  returns uint32
  is native(glib)
  is export
{ * }

multi sub g_tree_replace (
  GTree $tree,
  Str $key,
  gpointer $value
)
  is native(glib)
  is export
{ * }
multi sub g_tree_replace (
  GTree $tree,
  gpointer $key,
  gpointer $value
)
  is native(glib)
  is export
{ * }

sub g_tree_search (
  GTree $tree,
  GCompareFunc $search_func,
  gconstpointer $user_data
)
  returns Pointer
  is native(glib)
  is export
{ * }

multi sub g_tree_steal (
  GTree $tree,
  Str $key
)
  returns uint32
  is native(glib)
  is export
{ * }
multi sub g_tree_steal (
  GTree $tree,
  Pointer $key
)
  returns uint32
  is native(glib)
  is export
{ * }

# This may cause a difficult to trace error. To invoke either sub,
# the callback will, at minimum, need to be STRONGLY TYPED!
multi sub g_tree_traverse (
  GTree $tree,
  &traverse_func (Str, Pointer, Pointer --> gboolean),
  GTraverseType $traverse_type,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }
multi sub g_tree_traverse (
  GTree $tree,
  &traverse_func (Pointer, Pointer, Pointer --> gboolean),
  GTraverseType $traverse_type,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_tree_unref (GTree $tree)
  is native(glib)
  is export
{ * }
