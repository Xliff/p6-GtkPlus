use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::RAw::Resource;

sub g_resource_enumerate_children (
  GResource $resource,
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_resource_error_quark ()
  returns GQuark
  is native(gio)
  is export
{ * }

sub g_resources_enumerate_children (
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_resources_get_info (
  Str $path,
  GResourceLookupFlags $lookup_flags,
  gsize $size is rw,
  guint32 $flags is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_resources_lookup_data (
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
{ * }

sub g_resources_open_stream (
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_resources_register (GResource $resource)
  is native(gio)
  is export
{ * }

sub g_resources_unregister (GResource $resource)
  is native(gio)
  is export
{ * }

# sub g_static_resource_fini (GStaticResource $static_resource)
#   is native(gio)
#   is export
# { * }
#
# sub g_static_resource_get_resource (GStaticResource $static_resource)
#   returns GResource
#   is native(gio)
#   is export
# { * }
#
# sub g_static_resource_init (GStaticResource $static_resource)
#   is native(gio)
#   is export
# { * }

sub g_resource_get_info (
  GResource $resource,
  Str $path,
  GResourceLookupFlags $lookup_flags,
  gsize $size is rw,
  guint32 $flags is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_resource_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_resource_load (
  Str $filename,
  CArray[Pointer[GError]] $error
)
  returns GResource
  is native(gio)
  is export
{ * }

sub g_resource_lookup_data (
  GResource $resource,
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
{ * }

sub g_resource_new_from_data (GBytes $data, CArray[Pointer[GError]] $error)
  returns GResource
  is native(gio)
  is export
{ * }

sub g_resource_open_stream (
  GResource $resource,
  Str $path,
  GResourceLookupFlags $lookup_flags,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_resource_ref (GResource $resource)
  returns GResource
  is native(gio)
  is export
{ * }

sub g_resource_unref (GResource $resource)
  is native(gio)
  is export
{ * }
