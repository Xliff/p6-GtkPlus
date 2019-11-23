use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GLib::Raw::Slice;

use GLib::Roles::StaticClass;

class GLib::Slice {
  also does GLib::Roles::StaticClass;

  #
  # Deprecated
  #
  # method get_config (Int() $ckey) {
  #   my GSliceConfig $c = $ckey;
  #
  #   g_slice_get_config($c);
  # }
  #
  # method set_config (Int() $ckey, Int() $value) {
  #   my glong $v = $value;
  #   my GSliceConfig $c = $ckey;
  #
  #   g_slice_set_config($c, $v);
  # }

  method alloc (Int() $block_size) {
    my gsize $b = $block_size;

    g_slice_alloc($b);
  }

  method alloc0 (Int() $block_size) {
    my gsize $b = $block_size;

    g_slice_alloc0($b);
  }

  method copy (Int() $block_size, gpointer $mem_block) {
    my gsize $b = $block_size;

    g_slice_copy($b, $mem_block);
  }

  # This is NOT a class constructor.
  multi method new ($t) {
    die '$t Must be a CStruct!' unless $t.repr eq 'CStruct';

    self.alloc( nativesizeof($t) );
  }

  # This is NOT a class constructor.
  method new0 ($t) {
    die '$t must be a CStruct!' unless $t.repr eq 'CStruct';

    self.alloc0( nativesizeof($t) );
  }

  method dup ($t, $m) {
    die '$t must be a CStruct!' unless $t.repr eq 'CStruct';

    self.copy(nativesizeof($t), $m);
  }

  method free ($t, $m) {
    die '$t must be a CStruct!' unless $t.repr eq 'CStruct';

    self.free1(nativesizeof($t), $m);
  }

  # g_slice_free_chain is NYI!

  method debug_tree_statistics is also<debug-tree-statistics> {
    g_slice_debug_tree_statistics();
  }

  method free1 (Int() $block_size, gpointer $mem_block) {
    my gsize $b = $block_size;

    g_slice_free1($b, $mem_block);
  }

  method free_chain_with_offset (
    Int() $block_size,
    gpointer $mem_chain,
    Int() $next_offset
  )
    is also<free-chain-with-offset>
  {
    my gsize ($b, $n) = ($block_size, $next_offset);

    g_slice_free_chain_with_offset($b, $mem_chain, $n);
  }

  # Deprecated
  # method get_config_state (Int() $ckey, gint64 $address, guint $n_values) {
  #   my GSliceConfig $c = $ckey;
  #   my gint64 $a = $address;
  #
  #   g_slice_get_config_state($c, $a, $n_values);
  # }

}
