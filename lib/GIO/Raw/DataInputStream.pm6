use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::DataInputStream;

sub g_data_input_stream_get_byte_order (GDataInputStream $stream)
  returns GDataStreamByteOrder
  is native(gio)
  is export
{ * }

sub g_data_input_stream_get_newline_type (GDataInputStream $stream)
  returns GDataStreamNewlineType
  is native(gio)
  is export
{ * }

sub g_data_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_data_input_stream_new (GInputStream $base_stream)
  returns GDataInputStream
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_byte (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint8
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_int16 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint16
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_int32 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint32
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_int64 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint64
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_line (
  GDataInputStream $stream,
  gsize $length is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_line_async (
  GDataInputStream $stream,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_line_finish (
  GDataInputStream $stream,
  GAsyncResult $result,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_line_finish_utf8 (
  GDataInputStream $stream,
  GAsyncResult $result,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_line_utf8 (
  GDataInputStream $stream,
  gsize $length,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_uint16 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns guint16
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_uint32 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_uint64 (
  GDataInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns guint64
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_upto (
  GDataInputStream $stream,
  Str $stop_chars,
  gssize $stop_chars_len,
  gsize $length is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_upto_async (
  GDataInputStream $stream,
  Str $stop_chars,
  gssize $stop_chars_len,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_upto_finish (
  GDataInputStream $stream,
  GAsyncResult $result,
  gsize $length is rw,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_until (
  GDataInputStream $stream,
  Str $stop_chars,
  gsize $length is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_until_async (
  GDataInputStream $stream,
  Str $stop_chars,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_data_input_stream_read_until_finish (
  GDataInputStream $stream,
  GAsyncResult $result,
  gsize $length is rw,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_set_byte_order (
  GDataInputStream $stream,
  GDataStreamByteOrder $order
)
  is native(gio)
  is export
{ * }

sub g_data_input_stream_set_newline_type (
  GDataInputStream $stream,
  GDataStreamNewlineType $type
)
  is native(gio)
  is export
{ * }
