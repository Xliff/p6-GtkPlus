use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::VFS;

sub g_vfs_get_default ()
  returns GVfs
  is native(gio)
  is export
{ * }

sub g_vfs_get_file_for_path (GVfs $vfs, Str $path)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_vfs_get_file_for_uri (GVfs $vfs, Str $uri)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_vfs_get_local ()
  returns GVfs
  is native(gio)
  is export
{ * }

sub g_vfs_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_vfs_is_active (GVfs $vfs)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_vfs_parse_name (GVfs $vfs, Str $parse_name)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_vfs_register_uri_scheme (
  GVfs $vfs,
  Str $scheme,
  GVfsFileLookupFunc $uri_func,
  gpointer $uri_data,
  GDestroyNotify $uri_destroy,
  GVfsFileLookupFunc $parse_name_func,
  gpointer $parse_name_data,
  GDestroyNotify $parse_name_destroy
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_vfs_unregister_uri_scheme (GVfs $vfs, Str $scheme)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_vfs_get_supported_uri_schemes (GVfs $vfs)
  returns CArray[Str]
  is native(gio)
  is export
{ * }
