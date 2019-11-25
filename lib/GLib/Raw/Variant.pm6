use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Variant;

sub g_variant_builder_add_value (GVariantBuilder $builder, GVariant $value)
  is native(glib)
  is export
  { * }

sub g_variant_builder_clear (GVariantBuilder $builder)
  is native(glib)
  is export
  { * }

sub g_variant_builder_close (GVariantBuilder $builder)
  is native(glib)
  is export
  { * }

sub g_variant_builder_end (GVariantBuilder $builder)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_builder_init (GVariantBuilder $builder, GVariantType $type)
  is native(glib)
  is export
  { * }

sub g_variant_builder_new (GVariantType $type)
  returns GVariantBuilder
  is native(glib)
  is export
  { * }

sub g_variant_builder_open (GVariantBuilder $builder, GVariantType $type)
  is native(glib)
  is export
  { * }

sub g_variant_builder_ref (GVariantBuilder $builder)
  returns GVariantBuilder
  is native(glib)
  is export
  { * }

sub g_variant_builder_unref (GVariantBuilder $builder)
  is native(glib)
  is export
  { * }

sub g_variant_byteswap (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_check_format_string (
  GVariant $value,
  Str $format_string,
  gboolean $copy_only
)
  returns uint32
  is native(glib)
  is export
  { * }

# sub g_variant_classify (GVariant $value)
#   returns GVariantClass
#   is native(glib)
#   is export
#   { * }

sub g_variant_compare (GVariant $one, GVariant $two)
  returns gint
  is native(glib)
  is export
  { * }

sub g_variant_dict_clear (GVariantDict $dict)
  is native(glib)
  is export
  { * }

sub g_variant_dict_contains (GVariantDict $dict, Str $key)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_dict_end (GVariantDict $dict)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_dict_init (GVariantDict $dict, GVariant $from_asv)
  is native(glib)
  is export
  { * }

sub g_variant_dict_insert_value (
  GVariantDict $dict,
  Str $key,
  GVariant $value
)
  is native(glib)
  is export
  { * }

sub g_variant_dict_lookup_value (
  GVariantDict $dict,
  Str $key,
  GVariantType $expected_type
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_dict_new (GVariant $from_asv)
  returns GVariantDict
  is native(glib)
  is export
  { * }

sub g_variant_dict_ref (GVariantDict $dict)
  returns GVariantDict
  is native(glib)
  is export
  { * }

sub g_variant_dict_remove (GVariantDict $dict, Str $key)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_dict_unref (GVariantDict $dict)
  is native(glib)
  is export
  { * }

sub g_variant_dup_bytestring (GVariant $value, gsize $length)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_dup_bytestring_array (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_dup_objv (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_dup_string (GVariant $value, gsize $length)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_dup_strv (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_equal (GVariant $one, GVariant $two)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_get_boolean (GVariant $value)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_get_byte (GVariant $value)
  returns guint8
  is native(glib)
  is export
  { * }

sub g_variant_get_bytestring (GVariant $value)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_get_bytestring_array (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_get_child_value (GVariant $value, gsize $index_)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_get_data (GVariant $value)
  returns gconstpointer
  is native(glib)
  is export
  { * }

sub g_variant_get_data_as_bytes (GVariant $value)
  returns GBytes
  is native(glib)
  is export
  { * }

sub g_variant_get_double (GVariant $value)
  returns gdouble
  is native(glib)
  is export
  { * }

sub g_variant_get_fixed_array (
  GVariant $value,
  gsize $n_elements,
  gsize $element_size
)
  returns Pointer
  is native(glib)
  is export
  { * }

sub g_variant_get_handle (GVariant $value)
  returns gint32
  is native(glib)
  is export
  { * }

sub g_variant_get_int16 (GVariant $value)
  returns gint16
  is native(glib)
  is export
  { * }

sub g_variant_get_int32 (GVariant $value)
  returns gint32
  is native(glib)
  is export
  { * }

sub g_variant_get_int64 (GVariant $value)
  returns gint64
  is native(glib)
  is export
  { * }

sub g_variant_get_maybe (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_get_normal_form (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_get_objv (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_get_size (GVariant $value)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_get_string (GVariant $value, gsize $length)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_get_strv (GVariant $value, gsize $length)
  returns CArray[Str]
  is native(glib)
  is export
  { * }

sub g_variant_get_type (GVariant $value)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_get_type_string (GVariant $value)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_get_uint16 (GVariant $value)
  returns guint16
  is native(glib)
  is export
  { * }

sub g_variant_get_uint32 (GVariant $value)
  returns guint32
  is native(glib)
  is export
  { * }

sub g_variant_get_uint64 (GVariant $value)
  returns guint64
  is native(glib)
  is export
  { * }

# sub g_variant_get_va (
#   GVariant $value,
#   Str $format_string,
#   Str $endptr,
#   va_list $app
# )
#   is native(glib)
#   is export
#   { * }

sub g_variant_get_variant (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_hash (GVariant $value)
  returns guint
  is native(glib)
  is export
  { * }

sub g_variant_is_container (GVariant $value)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_is_floating (GVariant $value)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_is_normal_form (GVariant $value)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_is_object_path (Str $string)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_is_of_type (GVariant $value, GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_is_signature (Str $string)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_iter_copy (GVariantIter $iter)
  returns GVariantIter
  is native(glib)
  is export
  { * }

sub g_variant_iter_free (GVariantIter $iter)
  is native(glib)
  is export
  { * }

sub g_variant_iter_init (GVariantIter $iter, GVariant $value)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_iter_n_children (GVariantIter $iter)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_iter_new (GVariant $value)
  returns GVariantIter
  is native(glib)
  is export
  { * }

sub g_variant_iter_next_value (GVariantIter $iter)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_lookup_value (
  GVariant $dictionary,
  Str $key,
  GVariantType $expected_type
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_n_children (GVariant $value)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_new_boolean (gboolean $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_byte (guint8 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_bytestring (Str $string)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_dict_entry (GVariant $key, GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_double (gdouble $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_fixed_array (
  GVariantType $element_type,
  gconstpointer $elements,
  gsize $n_elements,
  gsize $element_size
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_from_bytes (
  GVariantType $type,
  GBytes $bytes,
  gboolean $trusted
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_from_data (
  GVariantType $type,
  gconstpointer $data,
  gsize $size,
  gboolean $trusted,
  GDestroyNotify $notify,
  gpointer $user_data
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_handle (gint32 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_int16 (gint16 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_int32 (gint32 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_int64 (gint64 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_maybe (GVariantType $child_type, GVariant $child)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_object_path (Str $object_path)
  returns GVariant
  is native(glib)
  is export
  { * }

# sub g_variant_new_parsed_va (Str $format, va_list $app)
#   returns GVariant
#   is native(glib)
#   is export
#   { * }

sub g_variant_new_signature (Str $signature)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_string (Str $string)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_take_string (Str $string)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_uint16 (guint16 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_uint32 (guint32 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_new_uint64 (guint64 $value)
  returns GVariant
  is native(glib)
  is export
  { * }

# sub g_variant_new_va (Str $format_string, Str $endptr, va_list $app)
#   returns GVariant
#   is native(glib)
#   is export
#   { * }

sub g_variant_new_variant (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_parse (
  GVariantType $type,
  Str $text,
  Str $limit,
  Str $endptr,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_parse_error_print_context (
  GError $error,  # NOT **GError!
  Str $source_str
)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_parse_error_quark ()
  returns GQuark
  is native(glib)
  is export
  { * }

sub g_variant_print (GVariant $value, gboolean $type_annotate)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_print_string (
  GVariant $value,
  GString $string,
  gboolean $type_annotate
)
  returns GString
  is native(glib)
  is export
  { * }

sub g_variant_ref (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_ref_sink (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_store (GVariant $value, gpointer $data)
  is native(glib)
  is export
  { * }

sub g_variant_take_ref (GVariant $value)
  returns GVariant
  is native(glib)
  is export
  { * }

sub g_variant_unref (GVariant $value)
  is native(glib)
  is export
  { * }
