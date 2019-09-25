use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::MemoryInputStream;

sub g_memory_input_stream_add_bytes (
  GMemoryInputStream $stream,
  GBytes $bytes
)
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_add_data (
  GMemoryInputStream $stream,
  Pointer $data,
  gssize $len,
  GDestroyNotify $destroy
)
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_new ()
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_new_from_bytes (GBytes $bytes)
  returns GInputStream
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_new_from_data (
  Pointer $data,
  gssize $len,
  GDestroyNotify $destroy
)
  returns GInputStream
  is native(gio)
  is export
{ * }
