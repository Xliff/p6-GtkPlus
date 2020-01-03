use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::MemoryOutputStream;

sub g_memory_output_stream_get_data (GMemoryOutputStream $ostream)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_get_data_size (GMemoryOutputStream $ostream)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_get_size (GMemoryOutputStream $ostream)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_new (
  gpointer $data,
  gsize $size,
  GReallocFunc $realloc_function,
  GDestroyNotify $destroy_function
)
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_new_resizable ()
  returns GOutputStream
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_steal_as_bytes (GMemoryOutputStream $ostream)
  returns GBytes
  is native(gio)
  is export
{ * }

sub g_memory_output_stream_steal_data (GMemoryOutputStream $ostream)
  returns Pointer
  is native(gio)
  is export
{ * }
