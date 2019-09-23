use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::FilterInputStream;

sub g_filter_input_stream_get_base_stream (GFilterInputStream $stream)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_filter_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_filter_input_stream_get_close_base_stream (GFilterInputStream $stream)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_filter_input_stream_set_close_base_stream (
  GFilterInputStream $stream,
  gboolean $close_base
)
  is native(gio)
  is export
{ * }
