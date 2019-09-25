use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::UnixInputStream;

sub g_unix_input_stream_get_close_fd (GUnixInputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_input_stream_get_fd (GUnixInputStream $stream)
  returns gint
  is native(gio)
  is export
{ * }

sub g_unix_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_input_stream_new (gint $fd, gboolean $close_fd)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_unix_input_stream_set_close_fd (
  GUnixInputStream $stream,
  gboolean $close_fd
)
  is native(gio)
  is export
{ * }
