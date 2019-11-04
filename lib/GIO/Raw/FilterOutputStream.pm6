use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::FilterOutputStream;

sub g_filter_output_stream_get_base_stream (GFilterOutputStream $stream)
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_filter_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_filter_output_stream_get_close_base_stream (GFilterOutputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_filter_output_stream_set_close_base_stream (
  GFilterOutputStream $stream,
  gboolean $close_base
)
  is native(gio)
  is export
{ * }
