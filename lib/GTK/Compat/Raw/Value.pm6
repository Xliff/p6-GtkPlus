use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Value;

sub g_value_dup_string (GValue $value)
  returns Str
  is native(gobject)
  is export
  { * }

sub g_value_dup_variant (GValue $value)
  returns GVariant
  is native(gobject)
  is export
  { * }

sub g_gtype_get_type ()
  returns GType
  is native(gobject)
  is export
  { * }

sub g_pointer_type_register_static (gchar $name)
  returns GType
  is native(gobject)
  is export
  { * }

sub g_strdup_value_contents (GValue $value)
  returns Str
  is native(gobject)
  is export
  { * }

sub g_value_set_static_string (GValue $value, gchar $v_string)
  is native(gobject)
  is export
  { * }

sub g_value_set_string_take_ownership (GValue $value, gchar $v_string)
  is native(gobject)
  is export
  { * }

sub g_value_take_string (GValue $value, gchar $v_string)
  is native(gobject)
  is export
  { * }

sub g_value_take_variant (GValue $value, GVariant $variant)
  is native(gobject)
  is export
  { * }

sub g_value_get_long (GValue $value)
  returns glong
  is native(gobject)
  is export
  { * }

sub g_value_get_double (GValue $value)
  returns gdouble
  is native(gobject)
  is export
  { * }

sub g_value_get_int (GValue $value)
  returns gint
  is native(gobject)
  is export
  { * }

sub g_value_get_schar (GValue $value)
  returns gint8
  is native(gobject)
  is export
  { * }

sub g_value_get_uchar (GValue $value)
  returns guchar
  is native(gobject)
  is export
  { * }

sub g_value_get_string (GValue $value)
  returns Str
  is native(gobject)
  is export
  { * }

sub g_value_get_uint (GValue $value)
  returns guint
  is native(gobject)
  is export
  { * }

sub g_value_get_gtype (GValue $value)
  returns GType
  is native(gobject)
  is export
  { * }

sub g_value_get_boolean (GValue $value)
  returns uint32
  is native(gobject)
  is export
  { * }

sub g_value_get_float (GValue $value)
  returns gfloat
  is native(gobject)
  is export
  { * }

sub g_value_get_char (GValue $value)
  returns Str
  is native(gobject)
  is export
  { * }

sub g_value_get_variant (GValue $value)
  returns GVariant
  is native(gobject)
  is export
  { * }

sub g_value_get_uint64 (GValue $value)
  returns guint64
  is native(gobject)
  is export
  { * }

sub g_value_get_int64 (GValue $value)
  returns gint64
  is native(gobject)
  is export
  { * }

sub g_value_get_object (GValue $value)
  returns Pointer
  is native(gobject)
  is export
  { * }

sub g_value_get_pointer (GValue $value)
  returns OpaquePointer
  is native(gobject)
  is export
  { * }

sub g_value_get_ulong (GValue $value)
  returns gulong
  is native(gobject)
  is export
  { * }

sub g_value_set_long (GValue $value, glong $v_long)
  is native(gobject)
  is export
  { * }

sub g_value_set_double (GValue $value, gdouble $v_double)
  is native(gobject)
  is export
  { * }

sub g_value_set_int (GValue $value, gint $v_int)
  is native(gobject)
  is export
  { * }

sub g_value_set_schar (GValue $value, gint8 $v_char)
  is native(gobject)
  is export
  { * }

sub g_value_set_uchar (GValue $value, guchar $v_uchar)
  is native(gobject)
  is export
  { * }

sub g_value_set_string (GValue $value, gchar $v_string)
  is native(gobject)
  is export
  { * }

sub g_value_set_uint (GValue $value, guint $v_uint)
  is native(gobject)
  is export
  { * }

sub g_value_set_gtype (GValue $value, GType $v_gtype)
  is native(gobject)
  is export
  { * }

sub g_value_set_boolean (GValue $value, gboolean $v_boolean)
  is native(gobject)
  is export
  { * }

sub g_value_set_float (GValue $value, gfloat $v_float)
  is native(gobject)
  is export
  { * }

sub g_value_set_char (GValue $value, gchar $v_char)
  is native(gobject)
  is export
  { * }

sub g_value_set_variant (GValue $value, GVariant $variant)
  is native(gobject)
  is export
  { * }

sub g_value_set_uint64 (GValue $value, guint64 $v_uint64)
  is native(gobject)
  is export
  { * }

sub g_value_set_int64 (GValue $value, gint64 $v_int64)
  is native(gobject)
  is export
  { * }

sub g_value_set_pointer (GValue $value, gpointer $v_pointer)
  is native(gobject)
  is export
  { * }

sub g_value_set_object (GValue $value, gpointer $v_pointer)
  is native(gobject)
  is export
  { * }

sub g_value_set_ulong (GValue $value, gulong $v_ulong)
  is native(gobject)
  is export
  { * }

sub g_value_init (GValue $value, uint64 $type)
  returns GValue
  is native(gobject)
  is export
  { * }

sub g_value_set_enum (GValue $value, gint $enum)
  is native(gobject)
  is export
  { * }

sub g_value_get_enum (GValue $value)
  returns gint
  is native(gobject)
  is export
  { * }
