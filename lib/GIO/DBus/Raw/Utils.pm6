use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::DBus::Raw::Utils;

sub g_dbus_generate_guid ()
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_gvalue_to_gvariant (GValue $gvalue, GVariantType $type)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_gvariant_to_gvalue (GVariant $value, GValue $out_gvalue)
  is native(gio)
  is export
{ * }

sub g_dbus_is_guid (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_interface_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_member_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_unique_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }
