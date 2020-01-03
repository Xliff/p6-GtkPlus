use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::FileInfo;

sub g_file_info_clear_status (GFileInfo $info)
  is native(gio)
  is export
{ * }

sub g_file_info_copy_into (GFileInfo $src_info, GFileInfo $dest_info)
  is native(gio)
  is export
{ * }

sub g_file_info_dup (GFileInfo $other)
  returns GFileInfo
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_enumerate_namespace (
  GFileAttributeMatcher $matcher,
  Str $ns
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_enumerate_next (GFileAttributeMatcher $matcher)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_matches (
  GFileAttributeMatcher $matcher,
  Str $attribute
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_matches_only (
  GFileAttributeMatcher $matcher,
  Str $attribute
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_new (Str $attributes)
  returns GFileAttributeMatcher
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_ref (GFileAttributeMatcher $matcher)
  returns GFileAttributeMatcher
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_subtract (
  GFileAttributeMatcher $matcher,
  GFileAttributeMatcher $subtract
)
  returns GFileAttributeMatcher
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_to_string (GFileAttributeMatcher $matcher)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_attribute_matcher_unref (GFileAttributeMatcher $matcher)
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_as_string (GFileInfo $info, Str $attribute)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_boolean (GFileInfo $info, Str $attribute)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_byte_string (GFileInfo $info, Str $attribute)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_data (
  GFileInfo $info,
  Str $attribute,
  GFileAttributeType $type,
  gpointer $value_pp,
  GFileAttributeStatus $status
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_int32 (GFileInfo $info, Str $attribute)
  returns gint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_int64 (GFileInfo $info, Str $attribute)
  returns gint64
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_object (GFileInfo $info, Str $attribute)
  returns GObject
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_status (GFileInfo $info, Str $attribute)
  returns GFileAttributeStatus
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_string (GFileInfo $info, Str $attribute)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_stringv (GFileInfo $info, Str $attribute)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_type (GFileInfo $info, Str $attribute)
  returns GFileAttributeType
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_uint32 (GFileInfo $info, Str $attribute)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_attribute_uint64 (GFileInfo $info, Str $attribute)
  returns guint64
  is native(gio)
  is export
{ * }

sub g_file_info_get_deletion_date (GFileInfo $info)
  returns GDateTime
  is native(gio)
  is export
{ * }

sub g_file_info_get_etag (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_is_backup (GFileInfo $info)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_modification_time (GFileInfo $info, GTimeVal $result)
  is native(gio)
  is export
{ * }

sub g_file_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_file_info_has_attribute (GFileInfo $info, Str $attribute)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_has_namespace (GFileInfo $info, Str $name_space)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_list_attributes (GFileInfo $info, Str $name_space)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_file_info_new ()
  returns GFileInfo
  is native(gio)
  is export
{ * }

sub g_file_info_remove_attribute (GFileInfo $info, Str $attribute)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute (
  GFileInfo $info,
  Str $attribute,
  GFileAttributeType $type,
  gpointer $value_p
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_boolean (
  GFileInfo $info,
  Str $attribute,
  gboolean $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_byte_string (
  GFileInfo $info,
  Str $attribute,
  Str $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_int32 (
  GFileInfo $info,
  Str $attribute,
  gint32 $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_int64 (
  GFileInfo $info,
  Str $attribute,
  gint64 $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_mask (
  GFileInfo $info,
  GFileAttributeMatcher $mask
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_object (
  GFileInfo $info,
  Str $attribute,
  GObject $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_status (
  GFileInfo $info,
  Str $attribute,
  GFileAttributeStatus $status
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_string (
  GFileInfo $info,
  Str $attribute,
  Str $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_stringv (
  GFileInfo $info,
  Str $attribute,
  Str $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_uint32 (
  GFileInfo $info,
  Str $attribute,
  guint32 $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_attribute_uint64 (
  GFileInfo $info,
  Str $attribute,
  guint64 $attr_value
)
  is native(gio)
  is export
{ * }

sub g_file_info_set_modification_time (GFileInfo $info, GTimeVal $mtime)
  is native(gio)
  is export
{ * }

sub g_file_info_unset_attribute_mask (GFileInfo $info)
  is native(gio)
  is export
{ * }

sub g_file_info_get_content_type (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_display_name (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_edit_name (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_file_type (GFileInfo $info)
  returns GFileType
  is native(gio)
  is export
{ * }

sub g_file_info_get_icon (GFileInfo $info)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_file_info_get_is_hidden (GFileInfo $info)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_is_symlink (GFileInfo $info)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_name (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_get_size (GFileInfo $info)
  returns goffset
  is native(gio)
  is export
{ * }

sub g_file_info_get_sort_order (GFileInfo $info)
  returns gint32
  is native(gio)
  is export
{ * }

sub g_file_info_get_symbolic_icon (GFileInfo $info)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_file_info_get_symlink_target (GFileInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_info_set_content_type (GFileInfo $info, Str $content_type)
  is native(gio)
  is export
{ * }

sub g_file_info_set_display_name (GFileInfo $info, Str $display_name)
  is native(gio)
  is export
{ * }

sub g_file_info_set_edit_name (GFileInfo $info, Str $edit_name)
  is native(gio)
  is export
{ * }

sub g_file_info_set_file_type (GFileInfo $info, GFileType $type)
  is native(gio)
  is export
{ * }

sub g_file_info_set_icon (GFileInfo $info, GIcon $icon)
  is native(gio)
  is export
{ * }

sub g_file_info_set_is_hidden (GFileInfo $info, gboolean $is_hidden)
  is native(gio)
  is export
{ * }

sub g_file_info_set_is_symlink (GFileInfo $info, gboolean $is_symlink)
  is native(gio)
  is export
{ * }

sub g_file_info_set_name (GFileInfo $info, Str $name)
  is native(gio)
  is export
{ * }

sub g_file_info_set_size (GFileInfo $info, goffset $size)
  is native(gio)
  is export
{ * }

sub g_file_info_set_sort_order (GFileInfo $info, gint32 $sort_order)
  is native(gio)
  is export
{ * }

sub g_file_info_set_symbolic_icon (GFileInfo $info, GIcon $icon)
  is native(gio)
  is export
{ * }

sub g_file_info_set_symlink_target (GFileInfo $info, Str $symlink_target)
  is native(gio)
  is export
{ * }
