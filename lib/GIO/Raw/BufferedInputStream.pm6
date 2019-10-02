use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::BufferedInputStream;

sub g_buffered_input_stream_fill (
  GBufferedInputStream $stream,
  gssize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_fill_async (
  GBufferedInputStream $stream,
  gssize $count,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_fill_finish (
  GBufferedInputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_get_available (GBufferedInputStream $stream)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_new (GInputStream $base_stream)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_new_sized (GInputStream $base_stream, gsize $size)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_peek (
  GBufferedInputStream $stream,
  Blob $buffer,
  gsize $offset,
  gsize $count
)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_peek_buffer (
  GBufferedInputStream $stream,
  gsize $count is rw
)
  returns CArray[uint8]
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_read_byte (
  GBufferedInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_get_buffer_size (GBufferedInputStream $stream)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_buffered_input_stream_set_buffer_size (
  GBufferedInputStream $stream,
  gsize $size
)
  is native(gio)
  is export
{ * }
