use v6.c;

use NativeCall;

use GTK::Compat::Types;

class GLib::Tree {
  has GTree $!t;

  submethod BUILD (:$tree) {
    $!t = $tree;
  }

  submethod DESTROY {
    self.unref;
  }

  method new (GTree $tree) {
    my $o = self.bless( :$tree );
    $o.ref;
  }

  # Make multis with default comparison functions. Should handle at least
  # Str, Int and Num
  method new (&compare_func) {
    g_tree_new(&compare_func);
  }

  method new_full (
    &compare_func,
    gpointer $key_compare_data,
    GDestroyNotify $key_destroy_func   = gpointer,
    GDestroyNotify $value_destroy_func = gpointer
  ) {
    g_tree_new_full(
      &compare_func,
      $key_compare_data,
      $key_destroy_func,
      $value_destroy_func
    );
  }

  method new_with_data (&compare_func, gpointer $key_compare_data) {
    g_tree_new_with_data(&compare_func, $key_compare_data);
  }

  method destroy {
    g_tree_destroy($!t);
  }

  method foreach (&func, gpointer $user_data = gpointer) {
    g_tree_foreach($!t, &func, $user_data);
  }

  method height {
    g_tree_height($!t);
  }

  method insert ($key, gpointer $value) {
    g_tree_insert($!t, $key, $value);
  }

  method lookup ($key) {
    g_tree_lookup($!t, $key);
  }

  method lookup_extended (
    gconstpointer $lookup_key,
    $orig_key is rw,
    $value    is rw,
    :$all = False
  ) {
    my ($ka, $va) = CArray[Pointer].new xx 2;
    ($ok[0], $va[0]) = Pointer xx 2;

    my $rv = g_tree_lookup_extended($!t, $lookup_key, $orig_key, $value);
    ($orig_key, $value) = ($ka[0], $va[0]);
    $all.not ?? $rv !! ($rv, $orig_key, $value);
  }

  method nnodes {
    g_tree_nnodes($!t);
  }

  method ref {
    g_tree_ref($!t);
    self;
  }

  method remove (gconstpointer $key) {
    g_tree_remove($!t, $key);
  }

  method replace (gpointer $key, gpointer $value) {
    g_tree_replace($!t, $key, $value);
  }

  method search (GCompareFunc $search_func, gconstpointer $user_data) {
    g_tree_search($!t, $search_func, $user_data);
  }

  method steal (gconstpointer $key) {
    g_tree_steal($!t, $key);
  }

  method traverse (
                  &traverse_func,
    GTraverseType $traverse_type,
    gpointer      $user_data = gpointer
  ) {
    my GTraverseType $tt = $traverse_type;

    g_tree_traverse($!t, &traverse_func, $tt, $user_data);
  }

  method unref {
    g_tree_unref($!t);
  }

}
