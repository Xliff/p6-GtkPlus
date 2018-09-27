use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::GSList;

sub g_slist_alloc ()
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_append (GSList $list, gpointer $data)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_concat (GSList $list1, GSList $list2)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_copy (GSList $list)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_copy_deep (
  GSList $list,
  GCopyFunc $func,
  gpointer $user_data
)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_delete_link (GSList $list, GSList $link_)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_find (GSList $list, gpointer $data)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_find_custom (
  GSList $list,
  gpointer $data,
  GCompareFunc $func
)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_foreach (GSList $list, GFunc $func, gpointer $user_data)
  is native(glib)
  is export
  { * }

sub g_slist_free (GSList $list)
  is native(glib)
  is export
  { * }

sub g_slist_free_1 (GSList $list)
  is native(glib)
  is export
  { * }

sub g_slist_free_full (GSList $list, GDestroyNotify $free_func)
  is native(glib)
  is export
  { * }

sub g_slist_index (GSList $list, gconstpointer $data)
  returns gint
  is native(glib)
  is export
  { * }

sub g_slist_insert (GSList $list, gpointer $data, gint $position)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_insert_before (
  GSList $slist,
  GSList $sibling,
  gpointer $data
)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_insert_sorted (
  GSList $list,
  gpointer $data,
  GCompareFunc $func
)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_insert_sorted_with_data (
  GSList $list,
  gpointer $data,
  GCompareDataFunc $func,
  gpointer $user_data
)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_last (GSList $list)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_length (GSList $list)
  returns guint
  is native(glib)
  is export
  { * }

sub g_slist_nth (GSList $list, guint $n)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_nth_data (GSList $list, guint $n)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_slist_position (GSList $list, GSList $llink)
  returns gint
  is native(glib)
  is export
  { * }

sub g_slist_prepend (GSList $list, gpointer $data)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_remove (GSList $list, gpointer $data)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_remove_all (GSList $list, gpointer $data)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_remove_link (GSList $list, GSList $link_)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_reverse (GSList $list)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_sort (GSList $list, GCompareFunc $compare_func)
  returns GSList
  is native(glib)
  is export
  { * }

sub g_slist_sort_with_data (
  GSList $list,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  returns GSList
  is native(glib)
  is export
  { * }
