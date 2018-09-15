use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GTK::Compat::Types;

my constant lib = 'glib-2.0',v0;

unit package GTK::Compat::Raw::GList;

sub g_list_alloc ()
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_append (GList $list, gpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_concat (GList $list1, GList $list2)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_copy (GList $list)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_copy_deep (GList $list, GCopyFunc $func, gpointer $user_data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_delete_link (GList $list, GList $link_)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_find (GList $list, gconstpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_find_custom (GList $list, gconstpointer $data, GCompareFunc $func)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_first (GList $list)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_foreach (GList $list, GFunc $func, gpointer $user_data)
  is native(lib)
  is export
  { * }

sub g_list_free (GList $list)
  is native(lib)
  is export
  { * }

sub g_list_free_1 (GList $list)
  is native(lib)
  is export
  { * }

sub g_list_free_full (GList $list, GDestroyNotify $free_func)
  is native(lib)
  is export
  { * }

sub g_list_index (GList $list, gconstpointer $data)
  returns gint
  is native(lib)
  is export
  { * }

sub g_list_insert (GList $list, gpointer $data, gint $position)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_insert_before (GList $list, GList $sibling, gpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_insert_sorted (GList $list, gpointer $data, GCompareFunc $func)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_insert_sorted_with_data (
  GList $list,
  gpointer $data,
  GCompareDataFunc $func,
  gpointer $user_data
)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_last (GList $list)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_length (GList $list)
  returns guint
  is native(lib)
  is export
  { * }

sub g_list_nth (GList $list, guint $n)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_nth_data (GList $list, guint $n)
  returns OpaquePointer
  is native(lib)
  is export
  { * }

sub g_list_nth_prev (GList $list, guint $n)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_position (GList $list, GList $llink)
  returns gint
  is native(lib)
  is export
  { * }

sub g_list_prepend (GList $list, gpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_remove (GList $list, gconstpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_remove_all (GList $list, gconstpointer $data)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_remove_link (GList $list, GList $llink)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_reverse (GList $list)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_sort (GList $list, GCompareFunc $compare_func)
  returns GList
  is native(lib)
  is export
  { * }

sub g_list_sort_with_data (
  GList $list,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  returns GList
  is native(lib)
  is export
  { * }
