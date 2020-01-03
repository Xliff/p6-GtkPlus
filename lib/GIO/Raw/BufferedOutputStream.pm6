use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::BufferedOutputStream;

sub g_buffered_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_new (GOutputStream $base_stream)
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_new_sized (
  GOutputStream $base_stream,
  gsize $size
)
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_get_auto_grow (GBufferedOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_get_buffer_size (GBufferedOutputStream $stream)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_set_auto_grow (
  GBufferedOutputStream $stream,
  gboolean $auto_grow
)
  is native(gio)
  is export
{ * }

sub g_buffered_output_stream_set_buffer_size (
  GBufferedOutputStream $stream,
  gsize $size
)
  is native(gio)
  is export
{ * }
