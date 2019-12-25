use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GIO::Raw::ListStore;

use GLib::Value;

use GTK::Roles::Properties;

class GIO::ListStore {
  also does GTK::Roles::Properties;

  has GListStore $!ls is implementor;

  submethod BUILD (:$store) {
    $!ls = $store;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GListStore
  { $!ls }

  method new (Int() $type) {
    my GType $t = $type;

    my $ls = g_list_store_new($t);
    $ls ?? self.bless( store => $ls ) !! Nil;
  }

  # Type: GType
  method item-type is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT64 );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('item-type', $gv)
        );
        # YYY -
        # cw: This is the proper way to handle GType in the future!
        # 11/11/2019
        $gv.uint64 ∈ GTypeEnum.pairs.map( *.value ) ??
          GTypeEnum( $gv.uint64 ) !! $gv.uint64;
      },
      STORE => -> $, $val is copy {
        warn 'item-type is a construct-only property and cannot be modified';
      }
    );
  }


  method append (gpointer $item) {
    g_list_store_append($!ls, $item);
  }

  method insert (Int() $position, gpointer $item) {
    my guint $p = $position;

    g_list_store_insert($!ls, $p, $item);
  }

  multi method insert_sorted (
    gpointer $item,
    GCompareDataFunc $compare_func,
    gpointer $user_data = gpointer;
  ) {
    g_list_store_insert_sorted($!ls, $item, $compare_func, $user_data);
  }

  method remove (Int() $position) {
    my guint $p = $position;

    g_list_store_remove($!ls, $p);
  }

  method remove_all {
    g_list_store_remove_all($!ls);
  }

  method sort (
    GCompareDataFunc $compare_func,
    gpointer $user_data = gpointer
  ) {
    g_list_store_sort($!ls, $compare_func, $user_data);
  }

  multi method splice (
    Int() $position,
    Int() $n_removals,
    @additions
  ) {
    die '@additions must only contain gpointers!'
      unless @additions.all ~~ gpointer;

    my $aa = CArray[gpointer].new;
    $aa[$_] = @additions[$_] for ^@additions.elems;

    samewith($position, $n_removals, $aa, @additions.elems);
  }
  multi method splice (
    Int() $position,
    Int() $n_removals,
    CArray[gpointer] $additions,
    Int() $n_additions
  ) {
    my guint ($p, $np, $na) = ($position, $n_removals, $n_additions);

    g_list_store_splice($!ls, $position, $n_removals, $additions, $n_additions);
  }

}
