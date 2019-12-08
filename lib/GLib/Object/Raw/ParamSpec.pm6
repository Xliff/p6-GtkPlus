use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Object::Raw::ParamSpec;

### /usr/include/glib-2.0/gobject/gparamspecs.h

sub g_param_spec_boolean (
  Str $name,
  Str $nick,
  Str $blurb,
  gboolean $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_boxed (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $boxed_type,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_char (
  Str $name,
  Str $nick,
  Str $blurb,
  gint8 $minimum,
  gint8 $maximum,
  gint8 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_double (
  Str $name,
  Str $nick,
  Str $blurb,
  gdouble $minimum,
  gdouble $maximum,
  gdouble $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_enum (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $enum_type,
  gint $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_flags (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $flags_type,
  guint $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_float (
  Str $name,
  Str $nick,
  Str $blurb,
  gfloat $minimum,
  gfloat $maximum,
  gfloat $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_gtype (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $is_a_type,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_int (
  Str $name,
  Str $nick,
  Str $blurb,
  gint $minimum,
  gint $maximum,
  gint $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_int64 (
  Str $name,
  Str $nick,
  Str $blurb,
  gint64 $minimum,
  gint64 $maximum,
  gint64 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_long (
  Str $name,
  Str $nick,
  Str $blurb,
  glong $minimum,
  glong $maximum,
  glong $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_object (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $object_type,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_override (Str $name, GParamSpec $overridden)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_param (
  Str $name,
  Str $nick,
  Str $blurb,
  GType $param_type,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_pointer (
  Str $name,
  Str $nick,
  Str $blurb,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_string (
  Str $name,
  Str $nick,
  Str $blurb,
  Str $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_uchar (
  Str $name,
  Str $nick,
  Str $blurb,
  guint8 $minimum,
  guint8 $maximum,
  guint8 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_uint (
  Str $name,
  Str $nick,
  Str $blurb,
  guint $minimum,
  guint $maximum,
  guint $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_uint64 (
  Str $name,
  Str $nick,
  Str $blurb,
  guint64 $minimum,
  guint64 $maximum,
  guint64 $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_ulong (
  Str $name,
  Str $nick,
  Str $blurb,
  gulong $minimum,
  gulong $maximum,
  gulong $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_unichar (
  Str $name,
  Str $nick,
  Str $blurb,
  gunichar $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_value_array (
  Str $name,
  Str $nick,
  Str $blurb,
  GParamSpec $element_spec,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_variant (
  Str $name,
  Str $nick,
  Str $blurb,
  GVariantType $type,
  GVariant $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

### /usr/include/glib-2.0/gobject/gparam.h

sub g_param_spec_get_blurb (GParamSpec $pspec)
  returns Str
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_default_value (GParamSpec $pspec)
  returns GValue
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_name (GParamSpec $pspec)
  returns Str
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_name_quark (GParamSpec $pspec)
  returns GQuark
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_nick (GParamSpec $pspec)
  returns Str
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_qdata (GParamSpec $pspec, GQuark $quark)
  returns Pointer
  is native(gobject)
  is export
{ * }

sub g_param_spec_get_redirect_target (GParamSpec $pspec)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_internal (
  GType $param_type,
  Str $name,
  Str $nick,
  Str $blurb,
  GParamFlags $flags
)
  returns Pointer
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_insert (
  GParamSpecPool $pool,
  GParamSpec $pspec,
  GType $owner_type
)
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_list (
  GParamSpecPool $pool,
  GType $owner_type,
  guint $n_pspecs_p
)
  returns CArray[GParamSpec]
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_list_owned (GParamSpecPool $pool, GType $owner_type)
  returns GList
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_lookup (
  GParamSpecPool $pool,
  Str $param_name,
  GType $owner_type,
  gboolean $walk_ancestors
)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_new (gboolean $type_prefixing)
  returns GParamSpecPool
  is native(gobject)
  is export
{ * }

sub g_param_spec_pool_remove (GParamSpecPool $pool, GParamSpec $pspec)
  is native(gobject)
  is export
{ * }

sub g_param_spec_ref (GParamSpec $pspec)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_ref_sink (GParamSpec $pspec)
  returns GParamSpec
  is native(gobject)
  is export
{ * }

sub g_param_spec_set_qdata (GParamSpec $pspec, GQuark $quark, gpointer $data)
  is native(gobject)
  is export
{ * }

sub g_param_spec_set_qdata_full (
  GParamSpec $pspec,
  GQuark $quark,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gobject)
  is export
{ * }

sub g_param_spec_sink (GParamSpec $pspec)
  is native(gobject)
  is export
{ * }

sub g_param_spec_steal_qdata (GParamSpec $pspec, GQuark $quark)
  returns Pointer
  is native(gobject)
  is export
{ * }

sub g_param_spec_unref (GParamSpec $pspec)
  is native(gobject)
  is export
{ * }

sub g_param_type_register_static (Str $name, GParamSpecTypeInfo $pspec_info)
  returns GType
  is native(gobject)
  is export
{ * }

sub g_param_value_convert (
  GParamSpec $pspec,
  GValue $src_value,
  GValue $dest_value,
  gboolean $strict_validation
)
  returns uint32
  is native(gobject)
  is export
{ * }

sub g_param_value_defaults (GParamSpec $pspec, GValue $value)
  returns uint32
  is native(gobject)
  is export
{ * }

sub g_param_value_set_default (GParamSpec $pspec, GValue $value)
  is native(gobject)
  is export
{ * }

sub g_param_value_validate (GParamSpec $pspec, GValue $value)
  returns uint32
  is native(gobject)
  is export
{ * }

sub g_param_values_cmp (GParamSpec $pspec, GValue $value1, GValue $value2)
  returns gint
  is native(gobject)
  is export
{ * }
