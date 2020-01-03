use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::PollableOutputStream;

sub g_pollable_output_stream_can_poll (GPollableOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_pollable_output_stream_create_source (
  GPollableOutputStream $stream,
  GCancellable $cancellable
)
  returns GSource
  is native(gio)
  is export
{ * }

sub g_pollable_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_pollable_output_stream_is_writable (GPollableOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_pollable_output_stream_write_nonblocking (
  GPollableOutputStream $stream,
  Pointer $buffer,
  gsize $count,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_pollable_output_stream_writev_nonblocking (
  GPollableOutputStream $stream,
  GOutputVector $vectors,
  gsize $n_vectors,
  gsize $bytes_written,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GPollableReturn
  is native(gio)
  is export
{ * }
