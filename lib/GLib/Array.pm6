use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Raw::Array;

use GLib::Raw::Subs;

class GLib::Array {
  also does Positional;

  has GArray $!a;

  submethod BUILD(:$array) {
    $!a = $array;
  }

  submethod DESTROY {
    self.downref;
  }

  # The "garray" alias is legacy and can be removed if not in use.
  method GTK::Compat::Types::GArray
    is also<
      GArray
      garray
    >
  { $!a }

  multi method new (GArray :$array) {
    my $o = self.bless( :$array );
    $o.upref;
  }
  multi method new (
    Int() $zero_terminated,
    Int() $clear,
    Int() $element_size
  ) {
    my guint ($zt, $c, $es) = ($zero_terminated, $clear, $element_size);
    my $a = g_array_new($!a, $c, $es);

    $a ?? self.bless( array => $a ) !! Nil;
  }

  multi method new (
    Int() $zero_terminated,
    Int() $clear,
    Int() $element_size,
    Int() $reserved_size,
    :$sized is required
  ) {
    self.sized_new($zero_terminated, $clear, $element_size, $reserved_size);
  }
  method sized_new (
    Int() $zero_terminated,
    Int() $clear,
    Int() $element_size,
    Int() $reserved_size
  )
    is also<
      sized-new
      new_sized
      new-sized
    >
  {
    my guint ($zt, $c, $es, $rs) =
      ($zero_terminated, $clear, $element_size, $reserved_size);
    my $a =  g_array_sized_new($zt, $c, $es, $rs);

    $a ?? self.bless( array => $a ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_vals (gpointer $data, Int() $len) is also<append-vals> {
    my guint $l = $len;

    g_array_append_vals($!a, $data, $l);
    self;
  }

  method free (Int() $free_segment) {
    my gboolean $fs = $free_segment;

    g_array_free($!a, $fs);
  }

  method get_element_size
    is also<
      get-element-size
      element_size
      element-size
    >
  {
    g_array_get_element_size($!a);
  }

  method insert_vals (Int() $index, gpointer $data, Int() $len)
    is also<insert-vals>
  {
    my guint ($i, $l) = ($index, $len);

    g_array_insert_vals($!a, $i, $data, $l);
    self;
  }

  method prepend_vals (gpointer $data, Int() $len) is also<prepend-vals> {
    my guint $l = $len;

    g_array_prepend_vals($!a, $data, $l);
    self;
  }

  method ref is also<upref> {
    g_array_ref($!a);
    self;
  }

  method remove_index (Int() $index) is also<remove-index> {
    my guint $i = $index;

    g_array_remove_index($!a, $index);
    self;
  }

  method remove_index_fast (Int() $index) is also<remove-index-fast> {
    my guint $i = $index;

    g_array_remove_index_fast($!a, $i);
    self;
  }

  method remove_range (Int() $index, Int() $length) is also<remove-range> {
    my guint ($i, $l) = ($index, $length);

    g_array_remove_range($!a, $i, $l);
    self;
  }

  method set_clear_func (GDestroyNotify $clear_func) is also<set-clear-func> {
    g_array_set_clear_func($!a, $clear_func);
  }

  method sort (GCompareFunc $compare_func) {
    g_array_sort($!a, $compare_func);
  }

  method sort_with_data (
    GCompareDataFunc $compare_func,
    gpointer $user_data = gpointer
  )
    is also<sort-with-data>
  {
    g_array_sort_with_data($!a, $compare_func, $user_data);
  }

  method unref is also<downref> {
    g_array_unref($!a);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
