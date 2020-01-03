use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GTK::Compat::Raw::Icon;

sub g_icon_deserialize (GVariant $value)
  returns GIcon
  is native(gio)
  is export
  { * }

sub g_icon_equal (GIcon $icon1, GIcon $icon2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_icon_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_icon_hash (GIcon $icon)
  returns guint
  is native(gio)
  is export
  { * }

sub g_icon_new_for_string (Str $str, CArray[Pointer[GError]] $error)
  returns GIcon
  is native(gio)
  is export
  { * }

sub g_icon_serialize (GIcon $icon)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_icon_to_string (GIcon $icon)
  returns Str
  is native(gio)
  is export
  { * }
