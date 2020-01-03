use v6.c;

use NativeCall;

use GLib::Raw::Types;

### /usr/include/glib-2.0/gio/gfileiostream.h

unit package GIO::Raw::FileIOStream;

sub g_file_io_stream_get_etag (GFileIOStream $stream)
  returns Str
  is native(gio)
  is export
{ * }

sub g_file_io_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_file_io_stream_query_info (
  GFileIOStream $stream,
  Str $attributes,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
{ * }

sub g_file_io_stream_query_info_async (
  GFileIOStream $stream,
  Str $attributes,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_file_io_stream_query_info_finish (
  GFileIOStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
{ * }
