use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GLib::Raw::Array;

class GLib::PtrArray {
  also does Positional;

  has GPtrArray $!pa;

  submethod BUILD(:$ptr-array) {
    $!pa = $ptr-array;
  }

  submethod DESTROY {
    self.downref;
  }

  method GTK::Compat::Types::GPtrArray
    is also<GPtrArray>
  { $!pa; }

  multi method new (GPtrArray $array) {
    my $o = self.bless(:$array);
    $o.upref;
  }
  multi method new {
    my $pa = g_ptr_array_new();

    $pa ?? self.bless( ptr-array => $pa ) !! Nil;
  }

  method new_full (
    Int() $reserved_size,
    GDestroyNotify $element_free_func
  )
    is also<new-full>
  {
    my guint $rs = $reserved_size;
    my $pa = g_ptr_array_new_full($rs, $element_free_func);

    $pa ?? self.bless( ptr-array => $pa) !! Nil;
  }

  method new_with_free_func (&free_func) is also<new-with-free-func> {
    my $pa = g_ptr_array_new_with_free_func(&free_func);

    $pa ?? self.bless( ptr-array => $pa) !! Nil;
  }

  method sized_new (Int() $reserved_size) is also<sized-new> {
    my guint $rs = $reserved_size;
    my $pa = g_ptr_array_sized_new($rs);

    $pa ?? self.bless( ptr-array => $pa) !! Nil;
  }



  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add (gpointer $data) {
    g_ptr_array_add($!pa, $data);
  }

  method find ($needle is copy, Int() $index) {
    die '$needle parameter must be of REPR "CStruct" or "CPointer"'
      unless $needle.REPR eq <CStruct CPointer>.any;
    $needle = nativecast(Pointer, $needle) unless $needle.REPR eq 'CPointer';
    my guint $i = $index;

    g_ptr_array_find($!pa, $needle, $i);
  }

  method find_with_equal_func (
    $needle is copy,
    &equal_func,
    Int() $index
  )
    is also<find-with-equal-func>
  {
    die '$needle parameter must be of REPR "CStruct" or "CPointer"'
      unless $needle.REPR eq <CStruct CPointer>.any;
    $needle = nativecast(Pointer, $needle) unless $needle.REPR eq 'CPointer';
    my guint $i = $index;

    g_ptr_array_find_with_equal_func($!pa, $needle, &equal_func, $i);
  }

  method foreach (&func, gpointer $user_data = Pointer) {
    g_ptr_array_foreach($!pa, &func, $user_data);
  }

  method free (Int() $free_seg) {
    my gboolean $fs = $free_seg;

    g_ptr_array_free($!pa, $fs);
  }

  method insert (Int() $index, gpointer $data = Pointer) {
    my guint $i = $index;

    g_ptr_array_insert($!pa, $i, $data);
  }

  method ref is also<upref> {
    g_ptr_array_ref($!pa);
    self;
  }

  method remove (gpointer $data) {
    g_ptr_array_remove($!pa, $data);
  }

  method remove_fast (gpointer $data) is also<remove-fast> {
    so g_ptr_array_remove_fast($!pa, $data);
  }

  method remove_index (Int() $index) is also<remove-index> {
    my guint $i = $index;

    g_ptr_array_remove_index($!pa, $i);
  }

  method remove_index_fast (Int() $index) is also<remove-index-fast> {
    my guint $i = $index;

    g_ptr_array_remove_index_fast($!pa, $i);
  }

  method remove_range (Int() $index, Int() $length) is also<remove-range> {
    my guint ($i, $l) = ($index, $length);
    my $pa = g_ptr_array_remove_range($!pa, $i, $l);

    self;
  }

  method set_free_func (GDestroyNotify $element_free_func)
    is also<set-free-func>
  {
    g_ptr_array_set_free_func($!pa, $element_free_func);
  }

  method sort (&compare_func) {
    g_ptr_array_sort($!pa, &compare_func);
  }

  method sort_with_data (
    &compare_func,
    gpointer $user_data = Pointer
  )
    is also<sort-with-data>
  {
    g_ptr_array_sort_with_data($!pa, &compare_func, $user_data);
  }

  method steal_index (Int() $index) is also<steal-index> {
    my guint $i = $index;

    g_ptr_array_steal_index($!pa, $i);
  }

  method steal_index_fast (Int() $index) is also<steal-index-fast> {
    my guint $i = $index;

    g_ptr_array_steal_index_fast($!pa, $i);
  }

  method unref is also<downref> {
    g_ptr_array_unref($!pa);
  }

  method elems {
    $!pa.len;
  }

  method index (Int() $index) is also<AT-POS> {
    my guint $i = $index;

    $!pa.data[$i];
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
