use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Array;

sub g_array_append_vals (GArray $array, Pointer $data, guint $len)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_free (GArray $array, gboolean $free_segment)
  returns Str
  is native(glib)
  is export
  { * }

sub g_byte_array_append (GByteArray $array, guint8 $data, guint $len)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_free (GByteArray $array, gboolean $free_segment)
  returns guint8
  is native(glib)
  is export
  { * }

sub g_byte_array_free_to_bytes (GByteArray $array)
  returns GBytes
  is native(glib)
  is export
  { * }

sub g_byte_array_new ()
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_new_take (guint8 $data, gsize $len)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_prepend (GByteArray $array, guint8 $data, guint $len)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_ref (GByteArray $array)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_remove_index (GByteArray $array, guint $index_)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_remove_index_fast (GByteArray $array, guint $index_)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_remove_range (
  GByteArray $array,
  guint $index_,
  guint $length
)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_set_size (GByteArray $array, guint $length)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_sized_new (guint $reserved_size)
  returns GByteArray
  is native(glib)
  is export
  { * }

sub g_byte_array_sort (GByteArray $array, GCompareFunc $compare_func)
  is native(glib)
  is export
  { * }

sub g_byte_array_sort_with_data (
  GByteArray $array,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  is native(glib)
  is export
  { * }

sub g_byte_array_unref (GByteArray $array)
  is native(glib)
  is export
  { * }

sub g_ptr_array_add (GPtrArray $array, gpointer $data)
  is native(glib)
  is export
  { * }

sub g_ptr_array_find (
  GPtrArray $haystack,
  Pointer $needle,
  guint $index_
)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_ptr_array_find_with_equal_func (
  GPtrArray $haystack,
  Pointer $needle,
  GEqualFunc $equal_func,
  guint $index
)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_ptr_array_foreach (GPtrArray $array, GFunc $func, gpointer $user_data)
  is native(glib)
  is export
  { * }

sub g_ptr_array_free (GPtrArray $array, gboolean $free_seg)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_ptr_array_insert (GPtrArray $array, gint $index_, gpointer $data)
  is native(glib)
  is export
  { * }

sub g_ptr_array_new ()
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_new_full (
  guint $reserved_size,
  GDestroyNotify $element_free_func
)
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_new_with_free_func (GDestroyNotify $element_free_func)
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_ref (GPtrArray $array)
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_remove (GPtrArray $array, gpointer $data)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_ptr_array_remove_fast (GPtrArray $array, gpointer $data)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_ptr_array_remove_index (GPtrArray $array, guint $index_)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_ptr_array_remove_index_fast (GPtrArray $array, guint $index_)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_ptr_array_remove_range (GPtrArray $array, guint $index_, guint $length)
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_set_free_func (
  GPtrArray $array,
  GDestroyNotify $element_free_func
)
  is native(glib)
  is export
  { * }

sub g_ptr_array_sized_new (guint $reserved_size)
  returns GPtrArray
  is native(glib)
  is export
  { * }

sub g_ptr_array_sort (GPtrArray $array, GCompareFunc $compare_func)
  is native(glib)
  is export
  { * }

sub g_ptr_array_sort_with_data (
  GPtrArray $array,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  is native(glib)
  is export
  { * }

sub g_ptr_array_steal_index (GPtrArray $array, guint $index)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_ptr_array_steal_index_fast (GPtrArray $array, guint $index)
  returns OpaquePointer
  is native(glib)
  is export
  { * }

sub g_ptr_array_unref (GPtrArray $array)
  is native(glib)
  is export
  { * }

sub g_array_get_element_size (GArray $array)
  returns guint
  is native(glib)
  is export
  { * }

sub g_array_insert_vals (
  GArray $array, guint $index,
  Pointer $data,
  guint $len
)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_new (
  gboolean $zero_terminated,
  gboolean $clear,
  guint $element_size
)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_prepend_vals (GArray $array, Pointer $data, guint $len)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_ref (GArray $array)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_remove_index (GArray $array, guint $index_)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_remove_index_fast (GArray $array, guint $index_)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_remove_range (GArray $array, guint $index_, guint $length)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_set_clear_func (GArray $array, GDestroyNotify $clear_func)
  is native(glib)
  is export
  { * }

sub g_array_sized_new (
  gboolean $zero_terminated,
  gboolean $clear,
  guint $element_size,
  guint $reserved_size
)
  returns GArray
  is native(glib)
  is export
  { * }

sub g_array_sort (GArray $array, GCompareFunc $compare_func)
  is native(glib)
  is export
  { * }

sub g_array_sort_with_data (
  GArray $array,
  GCompareDataFunc $compare_func,
  gpointer $user_data
)
  is native(glib)
  is export
  { * }

sub g_array_unref (GArray $array)
  is native(glib)
  is export
  { * }
