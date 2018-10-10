use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeSortable;
use GTK::Raw::Types;

role GTK::Roles::TreeSortable {
  has GtkTreeSortable $!ts;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_sort_column_id (
    Int() $sort_column_id,
    Int() $order               # GtkSortType $order
  ) {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    my uint32 $o = self.RESOLVE-UINT($order);
    so gtk_tree_sortable_get_sort_column_id($!ts, $s, $o);
  }

  method get_type {
    gtk_tree_sortable_get_type();
  }

  method has_default_sort_func {
    so gtk_tree_sortable_has_default_sort_func($!ts);
  }

  method set_default_sort_func (
    GtkTreeIterCompareFunc $sort_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_tree_sortable_set_default_sort_func(
      $!ts,
      $sort_func,
      $user_data,
      $destroy
    );
  }

  method set_sort_column_id (
    Int() $sort_column_id,
    Int() $order               # GtkSortType $order
  ) {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    my uint32 $o = self.RESOLVE-UINT($order);
    gtk_tree_sortable_set_sort_column_id($!ts, $s, $o);
  }

  method set_sort_func (
    Int() $sort_column_id,
    GtkTreeIterCompareFunc $sort_func,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    my gint $s = self.RESOLVE-INT($sort_column_id);
    gtk_tree_sortable_set_sort_func(
      $!ts,
      $s,
      $sort_func,
      $user_data,
      $destroy
    );
  }

  method sort_column_changed {
    gtk_tree_sortable_sort_column_changed($!ts);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
