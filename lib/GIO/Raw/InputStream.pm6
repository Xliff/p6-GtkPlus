use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GTK::Compat::Raw::InputStream;

sub g_input_stream_clear_pending (GInputStream $stream)
  is native(gio)
  is export
  { * }

sub g_input_stream_close (
  GInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_close_async (
  GInputStream $stream,
  int32 $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_input_stream_close_finish (
  GInputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_input_stream_has_pending (GInputStream $stream)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_is_closed (GInputStream $stream)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_read (
  GInputStream $stream,
  Blob $buffer,
  gsize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
  { * }

sub g_input_stream_read_all (
  GInputStream $stream,
  Blob $buffer,
  gsize $count,
  gsize $bytes_read,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_read_all_async (
  GInputStream $stream,
  Blob $buffer,
  gsize $count,
  int32 $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_input_stream_read_all_finish (
  GInputStream $stream,
  GAsyncResult $result,
  gsize $bytes_read,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_read_async (
  GInputStream $stream,
  Blob $buffer,
  gsize $count,
  int32 $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_input_stream_read_bytes (
  GInputStream $stream,
  gsize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_input_stream_read_bytes_async (
  GInputStream $stream,
  gsize $count,
  int32 $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_input_stream_read_bytes_finish (
  GInputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_input_stream_read_finish (
  GInputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
  { * }

sub g_input_stream_set_pending (
  GInputStream $stream,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_input_stream_skip (
  GInputStream $stream,
  gsize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
  { * }

sub g_input_stream_skip_async (
  GInputStream $stream,
  gsize $count,
  int32 $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_input_stream_skip_finish (
  GInputStream $stream,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
  { * }
