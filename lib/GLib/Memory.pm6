use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GLib::Raw::Memory;

use GLib::Roles::StaticClass;

class GLib::Memory {
  also does GLib::Roles::StaticClass;

  method clear_pointer (gpointer $pp, GDestroyNotify $destroy)
    is also<clear-pointer>
  {
    g_clear_pointer($pp, $destroy);
  }

  method free (gpointer $mem) {
    g_free($mem);
  }

  method malloc (Int() $n_bytes) {
    my gsize $n = $n_bytes;

    g_malloc($n);
  }

  method malloc0 (Int() $n_bytes) {
    my gsize $n = $n_bytes;

    g_malloc0($n);
  }

  method malloc0_n (Int() $n_blocks, Int() $n_blocks_bytes)
    is also<malloc0-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_malloc0_n($n, $nb);
  }

  method malloc_n (Int() $n_blocks, Int() $n_blocks_bytes)
    is also<malloc-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_malloc_n($n, $nb);
  }


  # Deprecated.
  #
  # method mem_is_system_malloc () {
  #   g_mem_is_system_malloc();
  # }
  #
  # method mem_profile () {
  #   g_mem_profile();
  # }
  #
  # method mem_set_vtable (GMemVTable $vtable) {
  #   g_mem_set_vtable($vtable);
  # }

  method realloc (gpointer $mem, Int() $n_bytes) {
    my gsize $n = $n_bytes;

    g_realloc($mem, $n);
  }

  method realloc_n (gpointer $mem, Int() $n_blocks, Int() $n_blocks_bytes)
    is also<realloc-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_realloc_n($mem, $n, $nb);
  }

  method try_malloc (Int() $n_bytes) is also<try-malloc> {
    my gsize $n = $n_bytes;

    g_try_malloc($n);
  }

  method try_malloc0 (Int() $n_bytes) is also<try-malloc0> {
    my gsize $n = $n_bytes;

    g_try_malloc0($n);
  }

  method try_malloc0_n (Int() $n_blocks, Int() $n_blocks_bytes)
    is also<try-malloc0-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_try_malloc0_n($n, $nb);
  }

  method try_malloc_n (Int() $n_blocks, Int() $n_blocks_bytes)
    is also<try-malloc-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_try_malloc_n($n, $nb);
  }

  method try_realloc (gpointer $mem, Int() $n_bytes) is also<try-realloc> {
    my gsize $n = $n_bytes;

    g_try_realloc($mem, $n);
  }

  method try_realloc_n (gpointer $mem, Int() $n_blocks, Int() $n_blocks_bytes)
    is also<try-realloc-n>
  {
    my gsize ($n, $nb) = ($n_blocks, $n_blocks_bytes);

    g_try_realloc_n($mem, $n, $nb);
  }

}
