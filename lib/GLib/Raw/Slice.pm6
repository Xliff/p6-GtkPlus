use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Slice;

### /usr/include/glib-2.0/glib/gslice.h

sub g_slice_alloc (gsize $block_size)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_slice_alloc0 (gsize $block_size)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_slice_copy (gsize $block_size, gconstpointer $mem_block)
  returns Pointer
  is native(glib)
  is export
{ * }


sub g_slice_debug_tree_statistics ()
  is native(glib)
  is export
{ * }

sub g_slice_free1 (gsize $block_size, gpointer $mem_block)
  is native(glib)
  is export
{ * }

sub g_slice_free_chain_with_offset (
  gsize $block_size,
  gpointer $mem_chain,
  gsize $next_offset
)
  is native(glib)
  is export
{ * }

sub g_slice_get_config_state (
  GSliceConfig $ckey,
  gint64 $address,
  guint $n_values
)
  returns gint64
  is native(glib)
  is export
{ * }

sub g_slice_get_config (GSliceConfig $ckey)
  returns gint64
  is native(glib)
  is export
{ * }

sub g_slice_set_config (GSliceConfig $ckey, gint64 $value)
  is native(glib)
  is export
{ * }

sub g_slice_alloc (gsize $block_size)
  returns gpointer
  is native(glib)
  is export
{ * }

sub g_slice_alloc0 (gsize $block_size)
  returns gpointer
  is native(glib)
  is export
{ * }

sub g_slice_copy (gsize $block_size, Pointer $mem_block)
  returns gpointer
  is native(glib)
  is export
{ * }
