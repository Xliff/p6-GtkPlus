use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::Types;

role GTK::Roles::TreeModel {
  also does GTK::Roles::Types;

  has GtkTreeModel $!tm;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-changed {
    self.connect($!tm, 'row-changed');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, gpointer --> void
  method row-deleted {
    self.connect($!tm, 'row-deleted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-has-child-toggled {
    self.connect($!tm, 'row-has-child-toggled');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-inserted {
    self.connect($!tm, 'row-inserted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer, gpointer --> void
  method rows-reordered {
    self.connect($!tm, 'rows-reordered');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method foreach (GtkTreeModelForeachFunc $func, gpointer $user_data) {
    gtk_tree_model_foreach($!tm, $func, $user_data);
  }

  method get_column_type (Int() $index) {
    my gint $i = self.RESOLVE-INT($index);
    gtk_tree_model_get_column_type($!tm, $index);
  }

  method get_flags {
    gtk_tree_model_get_flags($!tm);
  }

  method get_iter (GtkTreeIter() $iter, GtkTreePath() $path) {
    gtk_tree_model_get_iter($!tm, $iter, $path);
  }

  method get_iter_first (GtkTreeIter() $iter) {
    gtk_tree_model_get_iter_first($!tm, $iter);
  }

  method get_iter_from_string (GtkTreeIter() $iter, Str() $path_string) {
    gtk_tree_model_get_iter_from_string($!tm, $iter, $path_string);
  }

  method get_n_columns {
    gtk_tree_model_get_n_columns($!tm);
  }

  method get_path (GtkTreeIter() $iter) {
    gtk_tree_model_get_path($!tm, $iter);
  }

  method get_string_from_iter (GtkTreeIter() $iter) {
    gtk_tree_model_get_string_from_iter($!tm, $iter);
  }

  method get_role_type {
    gtk_tree_model_get_type();
  }

  # method get_valist (GtkTreeIter $iter, va_list $var_args) {
  #   gtk_tree_model_get_valist($!tm, $iter, $var_args);
  # }

  # XXX - With the advent of GTK::Compat::Value, the below comment may be
  #       incorrect. 8^)
  # This will need to turn into set of variants for:
  #     types: uint, int, uint64, int64, num, num64, string, object
  # shortcuts: boolean, flags(uint); enum(int)
  # See the below example:
  multi method get_value (
    GtkTreeIter() $iter,
    Int() $column,
    GValue() $value is rw
  ) {
    my gint $c = self.RESOLVE-INT($column);
    my $rc = gtk_tree_model_get_value($!tm, $iter, $c, $value);
    $rc;
  }
  multi method get_value (GtkTreeIter() $iter, Int() $column) {
    my GValue $v .= new;
    samewith($iter, $column, $v);
    my $vo = GTK::Compat::Value.new($v);
    $vo.value;
  }

  # method get_value_o (GtkTreeIter() $iter, Int() $column, Pointer $value is rw) {
  #   my gint $c = self.RESOLVE-INT($column);
  #   gtk_tree_model_get_value_obj($!tm, $iter, $c, $value);
  # }
  # method get_value_f (GtkTreeIter() $iter, Int() $column, Num() $value is rw) {
  #   my num32 $v = $value;
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_float($!tm, $iter, $c, $v);
  #   $value = $v;
  #   $rc;
  # }
  # method get_value_d (GtkTreeIter() $iter, Int() $column, Num() $value is rw) {
  #   my num64 $v = $value;
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_double($!tm, $iter, $c, $value);
  #   $value = $v;
  #   $rc;
  # }
  # method get_value_i (GtkTreeIter() $iter, Int() $column, int32 $value is rw) {
  #   my int32 $v = self.RESOLVE-INT($value);
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_int($!tm, $iter, $c, $value);
  #   $value = $v;
  #   $rc;
  # }
  # method get_value_ui (GtkTreeIter() $iter, Int() $column, uint32 $value is rw) {
  #   my uint32 $v = self.RESOLVE-UINT($value);
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_uint($!tm, $iter, $c, $value);
  #   $value = $v;
  #   $rc;
  # }
  # method get_value_l (GtkTreeIter() $iter, Int() $column, int64 $value is rw) {
  #   my int64 $v = self.RESOLVE-LINT($value);
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_long($!tm, $iter, $c, $value);
  #   $value = $v;
  #   $rc;
  # }
  # method get_value_ul (GtkTreeIter() $iter, Int() $column, uint64 $value is rw) {
  #   my int64 $v = self.RESOLVE-ULINT($value);
  #   my gint $c = self.RESOLVE-INT($column);
  #   my $rc = gtk_tree_model_get_value_ulong($!tm, $iter, $c, $value);
  #   $value = $v;
  #   $rc;
  # }

  method iter_children (GtkTreeIter() $iter, GtkTreeIter() $parent) {
    gtk_tree_model_iter_children($!tm, $iter, $parent);
  }

  method iter_has_child (GtkTreeIter() $iter) {
    gtk_tree_model_iter_has_child($!tm, $iter);
  }

  method iter_n_children (GtkTreeIter() $iter) {
    gtk_tree_model_iter_n_children($!tm, $iter);
  }

  method iter_next (GtkTreeIter() $iter) {
    gtk_tree_model_iter_next($!tm, $iter);
  }

  method iter_nth_child (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    gint $n
  ) {
    gtk_tree_model_iter_nth_child($!tm, $iter, $parent, $n);
  }

  method iter_parent (GtkTreeIter() $iter, GtkTreeIter() $child) {
    gtk_tree_model_iter_parent($!tm, $iter, $child);
  }

  method iter_previous (GtkTreeIter() $iter) {
    gtk_tree_model_iter_previous($!tm, $iter);
  }

  method ref_node (GtkTreeIter() $iter) {
    gtk_tree_model_ref_node($!tm, $iter);
  }

  multi method row_changed (GtkTreePath() $path, GtkTreeIter() $iter) {
    gtk_tree_model_row_changed($!tm, $path, $iter);
  }

  multi method row_deleted (GtkTreePath() $path) {
    gtk_tree_model_row_deleted($!tm, $path);
  }

  multi method row_has_child_toggled (
    GtkTreePath() $path,
    GtkTreeIter() $iter
  ) {
    gtk_tree_model_row_has_child_toggled($!tm, $path, $iter);
  }

  multi method row_inserted (GtkTreePath() $path, GtkTreeIter() $iter) {
    gtk_tree_model_row_inserted($!tm, $path, $iter);
  }

  multi method rows_reordered (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    gint $new_order
  ) {
    gtk_tree_model_rows_reordered($!tm, $path, $iter, $new_order);
  }

  multi method rows_reordered_with_length (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    gint $new_order,
    gint $length
  ) {
    gtk_tree_model_rows_reordered_with_length(
      $!tm,
      $path,
      $iter,
      $new_order,
      $length
    );
  }

  method unref_node (GtkTreeIter $iter) {
    gtk_tree_model_unref_node($!tm, $iter);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
