use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeSortable;
use GTK::Raw::Types;

role GTK::Roles::TreeSortable {
  has GtkTreeSortable $!ts;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeSortable, gpointer --> void
  method sort-column-changed is also<sort_column_changed> {
    self.connect($!ts, 'sort-column-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_sort_column_id (
    Int() $sort_column_id,
    Int() $order               # GtkSortType $order
  )
    is also<get-sort-column-id>
  {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    my uint32 $o = self.RESOLVE-UINT($order);
    so gtk_tree_sortable_get_sort_column_id($!ts, $s, $o);
  }

  method get_treesortable_type is also<get-treesortable-type> {
    gtk_tree_sortable_get_type();
  }

  method has_default_sort_func is also<has-default-sort-func> {
    so gtk_tree_sortable_has_default_sort_func($!ts);
  }

  method set_default_sort_func (
    &f,
    gpointer $user_data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-default-sort-func>
  {
    gtk_tree_sortable_set_default_sort_func($!ts, &f, $user_data, $destroy);
  }

  method set_sort_column_id (
    Int() $sort_column_id,
    Int() $order               # GtkSortType $order
  )
    is also<set-sort-column-id>
  {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    my uint32 $o = self.RESOLVE-UINT($order);
    gtk_tree_sortable_set_sort_column_id($!ts, $s, $o);
  }

  method set_sort_func (
    Int() $sort_column_id,
    GtkTreeIterCompareFunc $sort_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  )
    is also<set-sort-func>
  {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    gtk_tree_sortable_set_sort_func(
      $!ts,
      $s,
      $sort_func,
      $user_data,
      $destroy
    );
  }

  method emit_sort_column_changed is also<emit-sort-column-changed> {
    gtk_tree_sortable_sort_column_changed($!ts);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
