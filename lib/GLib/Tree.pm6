use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GLib::Raw::Tree;

# Propose GLib::Roles::TreeData[::T] to allow accessor methods
# to properly type VALUES! TreeData COULD do Associative, but
# then need to worry about implicit stringification of keys.
# Key types should be checked against the backing object, so
# object will need to store key type and include mechanism
# to allow consuming code to retrieve it.

class GLib::Tree {
  has GTree $!t;
  has $.type;

  submethod BUILD (:$tree, :$type) {
    $!t    = $tree;
    $!type = $type;
  }

  submethod DESTROY {
    self.unref;
  }

  method GTK::Compat::Types::GTree
    is also<GTree>
  { $!t }

  multi method new (GTree $tree, :$type) {
    my $o = self.bless( :$tree, :$type );
    $o.ref;
  }

  # Make multis with default comparison functions. Should handle at least
  # Str, Int and Num
  multi method new (:$str!) {
    self.new(&string_compare, type => Str)
  }
  multi method new (:$int!) {
    self.new(&int_compare, type => Int);
  }
  multi method new (&compare_func, :$type) {
    my $t = g_tree_new(&compare_func);
    $t ?? self.bless( tree => $t, :$type ) !! Nil;
  }

  multi method new (
    &compare_func,
    gpointer $key_compare_data,
    GDestroyNotify $key_destroy_func   = gpointer,
    GDestroyNotify $value_destroy_func = gpointer,
    :$full is required
  ) {
    self.new_full(
      &compare_func,
      $key_compare_data,
      $key_destroy_func,
      $value_destroy_func
    );
  }
  method new_full (
    &compare_func,
    gpointer $key_compare_data,
    GDestroyNotify $key_destroy_func   = gpointer,
    GDestroyNotify $value_destroy_func = gpointer
  )
    is also<new-full>
  {
    my $t = g_tree_new_full(
      &compare_func,
      $key_compare_data,
      $key_destroy_func,
      $value_destroy_func
    );
    $t ?? self.bless( tree => $t ) !! Nil;
  }

  multi method new (
    &compare_func,
    gpointer $key_compare_data,
    :$data is required
  ) {
    self.new_with_data(&compare_func, $key_compare_data);
  }
  method new_with_data (&compare_func, gpointer $key_compare_data)
    is also<new-with-data>
  {
    my $t = g_tree_new_with_data(&compare_func, $key_compare_data);
    $t ?? self.bless( tree => $t ) !! Nil;
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
  )
    is also<lookup-extended>
  {
    my ($ka, $va) = CArray[Pointer].new xx 2;
    ($ka[0], $va[0]) = Pointer xx 2;

    my $rv = g_tree_lookup_extended($!t, $lookup_key, $orig_key, $value);
    ($orig_key, $value) = ($ka[0], $va[0]);
    $all.not ?? $rv !! ($rv, $orig_key, $value);
  }

  method nnodes is also<elems> {
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
