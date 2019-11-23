use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Memory;

### /usr/include/glib-2.0/glib/gmem.h

sub g_clear_pointer (gpointer $pp, GDestroyNotify $destroy)
  is native(glib)
  is export
{ * }

sub g_free (gpointer $mem)
  is native(glib)
  is export
{ * }

sub g_malloc (gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_malloc0 (gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_malloc0_n (gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_malloc_n (gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

# Deprecated.
#
# sub g_mem_is_system_malloc ()
#   returns uint32
#   is native(glib)
#   is export
# { * }
#
# sub g_mem_profile ()
#   is native(glib)
#   is export
# { * }
#
# sub g_mem_set_vtable (GMemVTable $vtable)
#   is native(glib)
#   is export
# { * }

sub g_realloc (gpointer $mem, gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_realloc_n (gpointer $mem, gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_malloc (gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_malloc0 (gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_malloc0_n (gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_malloc_n (gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_realloc (gpointer $mem, gsize $n_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_try_realloc_n (gpointer $mem, gsize $n_blocks, gsize $n_block_bytes)
  returns Pointer
  is native(glib)
  is export
{ * }
