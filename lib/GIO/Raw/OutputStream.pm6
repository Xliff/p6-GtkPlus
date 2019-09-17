use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::OutputStream;

sub g_output_stream_clear_pending (GOutputStream $stream)
  is native(gio)
  is export
{ * }

sub g_output_stream_close (
  GOutputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_close_async (
  GOutputStream $stream,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_close_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_flush (
  GOutputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_flush_async (
  GOutputStream $stream,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_flush_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_output_stream_has_pending (GOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_is_closed (GOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_is_closing (GOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_set_pending (
  GOutputStream $stream,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_splice (
  GOutputStream $stream,
  GInputStream $source,
  GOutputStreamSpliceFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_splice_async (
  GOutputStream $stream,
  GInputStream $source,
  GOutputStreamSpliceFlags $flags,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_splice_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_write (
  GOutputStream $stream,
  Pointer $buffer,
  gsize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_write_all (
  GOutputStream $stream,
  Pointer $buffer,
  gsize $count,
  gsize $bytes_written is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_write_all_async (
  GOutputStream $stream,
  Pointer $buffer,
  gsize $count,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_write_all_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  gsize $bytes_written is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_write_async (
  GOutputStream $stream,
  Pointer $buffer,
  gsize $count,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_write_bytes (
  GOutputStream $stream,
  GBytes $bytes,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_write_bytes_async (
  GOutputStream $stream,
  GBytes $bytes,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_write_bytes_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_write_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_output_stream_writev (
  GOutputStream $stream,
  GOutputVector $vectors,
  gsize $n_vectors,
  gsize $bytes_written is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_writev_all (
  GOutputStream $stream,
  GOutputVector $vectors,
  gsize $n_vectors,
  gsize $bytes_written is rw,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_writev_all_async (
  GOutputStream $stream,
  GOutputVector $vectors,
  gsize $n_vectors,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_writev_all_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  gsize $bytes_written is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_output_stream_writev_async (
  GOutputStream $stream,
  GOutputVector $vectors,
  gsize $n_vectors,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_output_stream_writev_finish (
  GOutputStream $stream,
  GAsyncResult $result,
  gsize $bytes_written is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
