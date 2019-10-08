use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::ContentType;

sub g_content_type_can_be_executable (Str $type)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_content_type_equals (Str $type1, Str $type2)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_content_type_from_mime_type (Str $mime_type)
  returns Str
  is native(gtk)
  is export
  { * }

sub g_content_types_get_registered ()
  returns GList
  is native(gtk)
  is export
  { * }

sub g_content_type_get_description (Str $type)
  returns Str
  is native(gtk)
  is export
  { * }

sub g_content_type_get_generic_icon_name (Str $type)
  returns Str
  is native(gtk)
  is export
  { * }

sub g_content_type_get_icon (Str $type)
  returns GIcon
  is native(gtk)
  is export
  { * }

# PRIVATE.
# sub g_content_type_get_mime_dirs ()
#   returns const
#   is native(gtk)
#   is export
#   { * }

sub g_content_type_get_mime_type (Str $type)
  returns Str
  is native(gtk)
  is export
  { * }

sub g_content_type_get_symbolic_icon (Str $type)
  returns GIcon
  is native(gtk)
  is export
  { * }

sub g_content_type_guess (
  Str $filename,
  Str $data,
  gsize $data_size,
  gboolean $result_uncertain is rw
)
  returns Str
  is native(gtk)
  is export
  { * }

sub g_content_type_guess_for_tree (GFile $root)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub g_content_type_is_a (Str $type, Str $supertype)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_content_type_is_mime_type (Str $type, Str $mime_type)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_content_type_is_unknown (Str $type)
  returns uint32
  is native(gtk)
  is export
  { * }
