use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::AsyncResult;

sub g_async_result_get_source_object (GAsyncResult $res)
  returns GObject
  is native(gio)
  is export
{ * }

sub g_async_result_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_async_result_get_user_data (GAsyncResult $res)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_async_result_is_tagged (GAsyncResult $res, gpointer $source_tag)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_async_result_legacy_propagate_error (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
