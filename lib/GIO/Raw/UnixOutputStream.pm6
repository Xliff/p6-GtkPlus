use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::UnixOutputStream;

sub g_unix_output_stream_get_fd (GUnixOutputStream $stream)
  returns gint
  is native(gio)
  is export
{ * }

sub g_unix_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_output_stream_new (gint $fd, gboolean $close_fd)
  returns GUnixOutputStream
  is native(gio)
  is export
{ * }

sub g_unix_output_stream_get_close_fd (GUnixOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_output_stream_set_close_fd (
  GUnixOutputStream $stream,
  gboolean $close_fd
)
  is native(gio)
  is export
{ * }
