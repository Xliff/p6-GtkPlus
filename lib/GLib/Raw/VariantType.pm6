use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::VariantType;

sub g_variant_type_copy (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_dup_string (GVariantType $type)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_type_element (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_equal (GVariantType $type1, GVariantType $type2)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_first (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_free (GVariantType $type)
  is native(glib)
  is export
  { * }

sub g_variant_type_get_string_length (GVariantType $type)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_type_hash (GVariantType $type)
  returns guint
  is native(glib)
  is export
  { * }

sub g_variant_type_is_array (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_basic (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_container (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_definite (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_dict_entry (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_maybe (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_subtype_of (GVariantType $type, GVariantType $supertype)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_tuple (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_is_variant (GVariantType $type)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_key (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_n_items (GVariantType $type)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_type_new (Str $type_string)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_new_array (GVariantType $element)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_new_dict_entry (GVariantType $key, GVariantType $value)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_new_maybe (GVariantType $element)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_new_tuple (
  CArray[Pointer[GVariantType]] $items,
  gint $length
)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_next (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }

sub g_variant_type_peek_string (GVariantType $type)
  returns Str
  is native(glib)
  is export
  { * }

sub g_variant_type_string_get_depth_ (Str $type_string)
  returns gsize
  is native(glib)
  is export
  { * }

sub g_variant_type_string_is_valid (Str $type_string)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_string_scan (Str $string, Str $limit, Str $endptr)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_variant_type_value (GVariantType $type)
  returns GVariantType
  is native(glib)
  is export
  { * }
