use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Stream;

sub g_io_stream_clear_pending (GIOStream $stream)
  is native(gio)
  is export
{ * }

sub g_io_stream_close (
  GIOStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_io_stream_close_async (
  GIOStream $stream,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_io_stream_close_finish (
  GIOStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_io_stream_get_input_stream (GIOStream $stream)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_io_stream_get_output_stream (GIOStream $stream)
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_io_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_io_stream_has_pending (GIOStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_io_stream_is_closed (GIOStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_io_stream_set_pending (GIOStream $stream, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_io_stream_splice_async (
  GIOStream $stream1,
  GIOStream $stream2,
  GIOStreamSpliceFlags $flags,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_io_stream_splice_finish (
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
