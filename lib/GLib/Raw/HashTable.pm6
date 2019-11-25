use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::HashTable;

# Oy-ya-mama, this had to be difficult!

sub g_hash_table_add (GHashTable $hash_table, gpointer $key)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_contains (GHashTable $hash_table, gpointer $key)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_destroy (GHashTable $hash_table)
  is native(gio)
  is export
  { * }

sub g_hash_table_find (
  GHashTable $hash_table,
  &func (Pointer $a, Pointer $b),
  gpointer $user_data
)
  returns Pointer
  is native(gio)
  is export
  { * }

sub g_hash_table_foreach (
  GHashTable $hash_table,
  &func (Pointer $a, Pointer $b),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_hash_table_foreach_remove (
  GHashTable $hash_table,
  &func (Pointer $a, Pointer $b),
  gpointer $user_data
)
  returns guint
  is native(gio)
  is export
  { * }

sub g_hash_table_foreach_steal (
  GHashTable $hash_table,
  &func (Pointer $a, Pointer $b),
  gpointer $user_data
)
  returns guint
  is native(gio)
  is export
  { * }

sub g_direct_equal (gpointer $v1, gpointer $v2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_direct_hash (gpointer $v)
  returns guint
  is native(gio)
  is export
  { * }

sub g_double_equal (CArray[num64] $v1, CArray[num64] $v2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_double_hash (CArray[num64] $v)
  returns guint
  is native(gio)
  is export
  { * }

sub g_int64_equal (CArray[gint64] $v1, CArray[gint64] $v2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_int64_hash (CArray[int64] $v)
  returns guint
  is native(gio)
  is export
  { * }

sub g_int_equal (CArray[gint] $v1, CArray[gint] $v2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_int_hash (CArray[gint] $v)
  returns guint
  is native(gio)
  is export
  { * }

sub g_str_equal (Str $v1, Str $v2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_str_hash (Str $v)
  returns guint
  is native(gio)
  is export
  { * }

sub g_hash_table_get_keys (GHashTable $hash_table)
  returns GList
  is native(gio)
  is export
  { * }

sub g_hash_table_get_keys_as_array (
  GHashTable $hash_table,
  guint $length is rw
)
  returns Pointer
  is native(gio)
  is export
  { * }

sub g_hash_table_get_values (GHashTable $hash_table)
  returns GList
  is native(gio)
  is export
  { * }

sub g_hash_table_insert_str (
  GHashTable $hash_table,
  Str $key,
  Str $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_insert_int (
  GHashTable $hash_table,
  Str $key,
  CArray[uint32] $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_insert_int64 (
  GHashTable $hash_table,
  Str $key,
  CArray[uint64] $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_insert_double (
  GHashTable $hash_table,
  Str $key,
  CArray[num64] $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_insert_pointer (
  GHashTable $hash_table,
  Str $key,
  gpointer $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_insert (
  GHashTable $hash_table,
  gpointer $key,
  gpointer $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_get_hash_table (GHashTableIter $iter)
  returns GHashTable
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_init (
  GHashTableIter $iter,
  GHashTable $hash_table
)
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_next (
  GHashTableIter $iter,
  gpointer $key,
  gpointer $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_remove (GHashTableIter $iter)
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_replace (GHashTableIter $iter, gpointer $value)
  is native(gio)
  is export
  { * }

sub g_hash_table_iter_steal (GHashTableIter $iter)
  is native(gio)
  is export
  { * }

# Will need to be typed!
sub g_hash_table_lookup (GHashTable $hash_table, gpointer $key)
  returns Pointer
  is native(gio)
  is export
  { * }

# Also...
sub g_hash_table_lookup_extended (
  GHashTable $hash_table,
  gpointer $lookup_key,
  gpointer $orig_key,
  gpointer $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_new (
  &hash_func  (Pointer --> guint),
  &equal_func (Pointer $a, Pointer $b --> gboolean)
)
  returns GHashTable
  is native(gio)
  is export
  { * }

sub g_hash_table_new_full (
  &hash_func  (Pointer --> guint),
  &equal_func (Pointer $a, Pointer $b --> gboolean),
  GDestroyNotify $key_destroy_func,
  GDestroyNotify $value_destroy_func
)
  returns GHashTable
  is native(gio)
  is export
  { * }

sub g_hash_table_ref (GHashTable $hash_table)
  returns GHashTable
  is native(gio)
  is export
  { * }

sub g_hash_table_remove (
  GHashTable $hash_table,
  gpointer $key
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_remove_all (GHashTable $hash_table)
  is native(gio)
  is export
  { * }

sub g_hash_table_replace (
  GHashTable $hash_table,
  gpointer $key,
  gpointer $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_size (GHashTable $hash_table)
  returns guint
  is native(gio)
  is export
  { * }

sub g_hash_table_steal (GHashTable $hash_table, gpointer $key)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_steal_all (GHashTable $hash_table)
  is native(gio)
  is export
  { * }

sub g_hash_table_steal_extended (
  GHashTable $hash_table,
  gpointer $lookup_key,
  gpointer $stolen_key,
  gpointer $stolen_value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_hash_table_unref (GHashTable $hash_table)
  is native(gio)
  is export
  { * }
