use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Array;
use GTK::Raw::Utils;

class GTK::Compat::Array {
  has GArray $!a;

  submethod BUILD(:$array) {
    $!a = $array;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_vals (Pointer $data, Int() $len) {
    my guint $l = resolve-uint($len);
    g_array_append_vals($!a, $data, $l);
  }

  method free (Int() $free_segment) {
    my gboolean $fs = resolve-bool($free_segment);
    g_array_free($!a, $fs);
  }

  method get_element_size {
    g_array_get_element_size($!a);
  }

  method insert_vals (Int() $index, Pointer $data, Int() $len) {
    my @u = ($index, $len);
    my guint ($i, $l) = resolve-uint(@u);
    g_array_insert_vals($!a, $i, $data, $l);
  }

  method new (gboolean $clear, guint $element_size) {
    my @u = ($clear, $element_size);
    my guint ($c, $es) = resolve-uint(@u);
    g_array_new($!a, $c, $es);
  }

  method prepend_vals (Pointer $data, Int() $len) {
    my guint $l = resolve-uint($len);
    g_array_prepend_vals($!a, $data, $l);
  }

  method ref is also<upref> {
    g_array_ref($!a);
  }

  method remove_index (guint $index) {
    g_array_remove_index($!a, $index);
  }

  method remove_index_fast (Int() $index) {
    my guint $i = resolve-int($index);
    g_array_remove_index_fast($!a, $i);
  }

  method remove_range (Int() $index, Int() $length) {
    my @u = ($index, $length);
    my guint ($i, $l) = resolve-uint(@u);
    g_array_remove_range($!a, $i, $l);
  }

  method set_clear_func (GDestroyNotify $clear_func) {
    g_array_set_clear_func($!a, $clear_func);
  }

  method sized_new (
    Int() $clear,
    Int() $element_size,
    Int() $reserved_size
  ) {
    my @u = ($clear, $element_size, $reserved_size);
    my guint ($c, $es, $rs) = resolve-int(@u);
    g_array_sized_new($!a, $c, $es, $rs);
  }

  method sort (GCompareFunc $compare_func) {
    g_array_sort($!a, $compare_func);
  }

  method sort_with_data (
    GCompareDataFunc $compare_func,
    gpointer $user_data
  ) {
    g_array_sort_with_data($!a, $compare_func, $user_data);
  }

  method unref is also<downref> {
    g_array_unref($!a);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
