use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ListStore;
use GTK::Raw::Types;

class GTK::ListStore {
  has GtkListStore $!ls;

  submethod BUILD(:$liststore) {
    $!ls = $liststore;
  }

  method new (gint $columns, GType @types) {
    my CArray[GType] $ctypes;
    $ctypes[$_] = @types[$_] for (^@types.elems);
    my $liststore = gtk_list_store_newv($columns, $ctypes);

    self.bless(:$liststore);
  }

  method append (GtkTreeIter $iter) {
    gtk_list_store_append($!ls, $iter);
  }

  method clear {
    gtk_list_store_clear($!ls);
  }

  method get_type {
    gtk_list_store_get_type();
  }

  method insert (GtkTreeIter $iter, gint $position) {
    gtk_list_store_insert($!ls, $iter, $position);
  }

  method insert_after (GtkTreeIter $iter, GtkTreeIter $sibling) {
    gtk_list_store_insert_after($!ls, $iter, $sibling);
  }

  method insert_before (GtkTreeIter $iter, GtkTreeIter $sibling) {
    gtk_list_store_insert_before($!ls, $iter, $sibling);
  }

  method insert_with_valuesv (
    GtkTreeIter $iter,
    gint $position,
    gint @columns,
    GValue @values,
    gint $n_values
  ) {
    # Throw exception if columns mismatch?
    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    $c_columns[$_] = @columns[$_] for (^$n_values);
    $c_values[$_] = @values[$_] for (^$n_values);
    gtk_list_store_insert_with_valuesv($!ls, $iter, $position, $c_columns, $c_values, $n_values);
  }

  method iter_is_valid (GtkTreeIter $iter) {
    gtk_list_store_iter_is_valid($!ls, $iter);
  }

  method move_after (GtkTreeIter $iter, GtkTreeIter $position) {
    gtk_list_store_move_after($!ls, $iter, $position);
  }

  method move_before (GtkTreeIter $iter, GtkTreeIter $position) {
    gtk_list_store_move_before($!ls, $iter, $position);
  }

  method prepend (GtkTreeIter $iter) {
    gtk_list_store_prepend($!ls, $iter);
  }

  method remove (GtkTreeIter $iter) {
    gtk_list_store_remove($!ls, $iter);
  }

  method reorder (CArray[gint] $new_order) {
    gtk_list_store_reorder($!ls, $new_order);
  }

  method set_column_types (gint $n_columns, GType $types) {
    gtk_list_store_set_column_types($!ls, $n_columns, $types);
  }

  #method set_valist (GtkTreeIter $iter, va_list $var_args) {
  #  gtk_list_store_set_valist($!ls, $iter, $var_args);
  #}

  method set_value (GtkTreeIter $iter, gint $column, GValue $value) {
    gtk_list_store_set_value($!ls, $iter, $column, $value);
  }

  method set_valuesv (
    GtkTreeIter $iter,
    gint @columns,
    GValue @values,
    gint $n_values
  ) {
    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    $c_columns[$_] = @columns[$_] for (^$n_values);
    $c_values[$_] = @values[$_] for (^$n_values);
    gtk_list_store_set_valuesv($!ls, $iter, $c_columns, $c_values, $n_values);
  }

  method swap (GtkTreeIter $a, GtkTreeIter $b) {
    gtk_list_store_swap($!ls, $a, $b);
  }

}
