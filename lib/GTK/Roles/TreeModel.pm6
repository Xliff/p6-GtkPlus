use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::TreeIter;
use GTK::TreePath;

use GTK::Roles::Types;

role GTK::Roles::TreeModel {
  also does GTK::Roles::Types;

  has GtkTreeModel $!tm;

  submethod BUILD(:$tree) {
    $!tm = $tree;
  }

  method GTK::Raw::Types::GtkTreeModel is also<TreeModel> { $!tm }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-changed is also<row_changed> {
    self.connect($!tm, 'row-changed');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, gpointer --> void
  method row-deleted is also<row_deleted> {
    self.connect($!tm, 'row-deleted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-has-child-toggled is also<row_has_child_toggled> {
    self.connect($!tm, 'row-has-child-toggled');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer --> void
  method row-inserted is also<row_inserted> {
    self.connect($!tm, 'row-inserted');
  }

  # Is originally:
  # GtkTreeModel, GtkTreePath, GtkTreeIter, gpointer, gpointer --> void
  method rows-reordered is also<rows_reordered> {
    self.connect($!tm, 'rows-reordered');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method foreach (GtkTreeModelForeachFunc $func, gpointer $user_data) {
    gtk_tree_model_foreach($!tm, $func, $user_data);
  }

  multi method get(GtkTreeIter() $iter, @types, @cols) {
    samewith($iter, @types, |@cols);
  }
  multi method get(GtkTreeIter() $iter, @types, *@cols) {
    my @r;
    my $t = 0;
    @r.push(
      do {
        my $v = GValue.new;
        self.get_value($iter, $_, $v);
        GTK::Compat::Value.new($v);
      }
    ) for @cols;
    @r;
  }

  method get_column_type (Int() $index) is also<get-column-type> {
    my gint $i = self.RESOLVE-INT($index);
    gtk_tree_model_get_column_type($!tm, $i);
  }

  method get_flags is also<get-flags> {
    GtkTreeModelFlags( gtk_tree_model_get_flags($!tm) );
  }

  proto method get_iter (|) is also<get-iter> { * }
  multi method get_iter (GtkTreePath() $path) {
    my $iter = GtkTreeIter.new;
    samewith($iter, $path) ?? GTK::TreeIter.new($iter) !! Nil;
  }
  multi method get_iter (GtkTreeIter() $iter, GtkTreePath() $path) {
    so gtk_tree_model_get_iter($!tm, $iter, $path);
  }

  proto method get_iter_first(|) is also<get-iter-first> { * }
  multi method get_iter_first {
    my $iter = GtkTreeIter.new;
    samewith($iter) ?? GTK::TreeIter.new($iter) !! Nil;
  }
  multi method get_iter_first (GtkTreeIter() $iter) {
    so gtk_tree_model_get_iter_first($!tm, $iter);
  }

  proto method get_iter_from_string(|) is also<get-iter-from-string> { * }
  multi method get_iter_from_string (Str() $path_string) {
    my $iter = GtkTreeIter.new;
    samewith($iter, $path_string) ?? GTK::TreeIter.new($iter) !! Nil;
  }
  multi method get_iter_from_string (
    GtkTreeIter() $iter,
    Str() $path_string
  ) {
    so gtk_tree_model_get_iter_from_string($!tm, $iter, $path_string);
  }

  method get_n_columns is also<get-n-columns> {
    gtk_tree_model_get_n_columns($!tm);
  }

  method get_path (GtkTreeIter() $iter) is also<get-path> {
    GTK::TreePath.new( gtk_tree_model_get_path($!tm, $iter) );
  }

  method get_string_from_iter (GtkTreeIter() $iter)
    is also<get-string-from-iter>
  {
    gtk_tree_model_get_string_from_iter($!tm, $iter);
  }

  method get_treemodel_type is also<get-treemodel-type> {
    gtk_tree_model_get_type();
  }

  # method get_valist (GtkTreeIter $iter, va_list $var_args) {
  #   gtk_tree_model_get_valist($!tm, $iter, $var_args);
  # }

  proto method get_value(|) is also<get-value> { * }

  multi method get_value(GtkTreeIter() $iter, Int() $column) {
    my gint $c = self.RESOLVE-INT($column);
    my $value = GValue.new;
    gtk_tree_model_get_value($!tm, $iter, $c, $value);
    GTK::Compat::Value.new($value);
  }
  multi method get_value (
    GtkTreeIter() $iter, Int() $column,
    GValue() $value
  )  {
    # TODO: Check iter for path.
    my gint $c = self.RESOLVE-INT($column);
    gtk_tree_model_get_value($!tm, $iter, $c, $value);
  }

  method iter_children (GtkTreeIter() $iter, GtkTreeIter() $parent)
    is also<iter-children>
  {
    so gtk_tree_model_iter_children($!tm, $iter, $parent);
  }

  method iter_has_child (GtkTreeIter() $iter) is also<iter-has-child> {
    so gtk_tree_model_iter_has_child($!tm, $iter);
  }

  method iter_n_children (GtkTreeIter() $iter) is also<iter-n-children> {
    gtk_tree_model_iter_n_children($!tm, $iter);
  }

  method iter_next (GtkTreeIter() $iter) is also<iter-next> {
    so gtk_tree_model_iter_next($!tm, $iter);
  }

  method iter_nth_child (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int() $n
  )
    is also<iter-nth-child>
  {
    my gint $nn = self.RESOLVE-INT($n);
    so gtk_tree_model_iter_nth_child($!tm, $iter, $parent, $nn);
  }

  method iter_parent (GtkTreeIter() $iter, GtkTreeIter() $child)
    is also<iter-parent>
  {
    so gtk_tree_model_iter_parent($!tm, $iter, $child);
  }

  method iter_previous (GtkTreeIter() $iter) is also<iter-previous> {
    so gtk_tree_model_iter_previous($!tm, $iter);
  }

  method ref_node (GtkTreeIter() $iter) is also<ref-node> {
    gtk_tree_model_ref_node($!tm, $iter);
  }

  method emit_row_changed (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-changed>
  {
    gtk_tree_model_row_changed($!tm, $path, $iter);
  }

  method emit_row_deleted (GtkTreePath() $path) is also<emit-row-deleted> {
    gtk_tree_model_row_deleted($!tm, $path);
  }

  method emit_row_has_child_toggled (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-has-child-toggled>
  {
    gtk_tree_model_row_has_child_toggled($!tm, $path, $iter);
  }

  method emit_row_inserted (GtkTreePath() $path, GtkTreeIter() $iter)
    is also<emit-row-inserted>
  {
    gtk_tree_model_row_inserted($!tm, $path, $iter);
  }

  method emit_rows_reordered (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    Int() $new_order
  )
    is also<emit-rows-reordered>
  {
    my gint $no = self.RESOLVE-INT($new_order);
    gtk_tree_model_rows_reordered($!tm, $path, $iter, $no);
  }

  method emit_rows_reordered_with_length (
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    Int() $new_order,
    Int() $length
  )
    is also<emit-rows-reordered-with-length>
  {
    my @i = ($new_order, $length);
    my gint ($no, $l) = self.RESOLVE-INT(@i);
    gtk_tree_model_rows_reordered_with_length($!tm, $path, $iter, $no, $l);
  }

  method unref_node (GtkTreeIter() $iter) is also<unref-node> {
    gtk_tree_model_unref_node($!tm, $iter);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
