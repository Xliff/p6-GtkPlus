use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Slice;

class GTK::Compat::Slice {
  
  method new (|) {
    warn 'GTK::Compat::Slice is a static class and does not need to be instantiated!'
      if $DEBUG;
      
    GTK::Compat::Slice;
  }
  
  method get_config (GSliceConfig $ckey) {
    g_slice_get_config($ckey);
  }
  
  method set_config (GSliceConfig $ckey, Int() $value) {
    my glong $v = resolve-long($value);
    g_slice_set_config($ckey, $v);
  }
  
  method debug_tree_statistics {
    g_slice_debug_tree_statistics();
  }

  method free1 (gsize $block_size, gpointer $mem_block) {
    g_slice_free1($block_size, $mem_block);
  }

  method free_chain_with_offset (gsize $block_size, gpointer $mem_chain, gsize $next_offset) {
    g_slice_free_chain_with_offset($block_size, $mem_chain, $next_offset);
  }

  method get_config_state (GSliceConfig $ckey, gint64 $address, guint $n_values) {
    g_slice_get_config_state($ckey, $address, $n_values);
  }
    
}
