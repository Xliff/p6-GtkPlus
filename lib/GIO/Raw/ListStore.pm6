use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::ListStore;

sub g_list_store_append (GListStore $store, gpointer $item)
  is native(gio)
  is export
{ * }

sub g_list_store_insert (GListStore $store, guint $position, gpointer $item)
  is native(gio)
  is export
{ * }

sub g_list_store_insert_sorted (
  GListStore $store,
  gpointer $item,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_list_store_new (GType $item_type)
  returns GListStore
  is native(gio)
  is export
{ * }

sub g_list_store_remove (GListStore $store, guint $position)
  is native(gio)
  is export
{ * }

sub g_list_store_remove_all (GListStore $store)
  is native(gio)
  is export
{ * }

sub g_list_store_sort (
  GListStore $store,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_list_store_splice (
  GListStore $store,
  guint $position,
  guint $n_removals,
  gpointer $additions,
  guint $n_additions
)
  is native(gio)
  is export
{ * }
