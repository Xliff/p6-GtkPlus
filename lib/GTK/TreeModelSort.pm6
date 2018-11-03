use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModelSort;
use GTK::Raw::Types;

use GTK::Roles::TreeDnD;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeSortable;

class GTK::TreeModelSort {
  also does GTK::Roles::TreeDragSource;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkTreeModelSort $!tms;

  submethod BUILD(:$treesort) {
    $!tms = $treesort;
    $!ds = nativecast(GtkTreeDragSource, $!tms);   # GTK::Roles::TreeDragSource
    $!ts = nativecast(GtkTreeSortable, $!tms);      # GTK::Roles::GtkTreeSortable
    $!tm = nativecast(GtkTreeModel, $!tms);         # GTK::Roles::TreeModel
  }

  method new (GtkTreeModel() $model) {
    my $treesort = gtk_tree_model_sort_new_with_model($model);
    self.bless(:$treesort);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_cache is also<clear-cache> {
    gtk_tree_model_sort_clear_cache($!tms);
  }

  method convert_child_iter_to_iter (
    GtkTreeIter() $sort_iter,
    GtkTreeIter() $child_iter
  ) is also<convert-child-iter-to-iter> {
    gtk_tree_model_sort_convert_child_iter_to_iter(
      $!tms,
      $sort_iter,
      $child_iter
    );
  }

  method convert_child_path_to_path (GtkTreePath() $child_path) is also<convert-child-path-to-path> {
    gtk_tree_model_sort_convert_child_path_to_path($!tms, $child_path);
  }

  method convert_iter_to_child_iter (
    GtkTreeIter() $child_iter,
    GtkTreeIter() $sorted_iter
  ) is also<convert-iter-to-child-iter> {
    gtk_tree_model_sort_convert_iter_to_child_iter(
      $!tms,
      $child_iter,
      $sorted_iter
    );
  }

  method convert_path_to_child_path (GtkTreePath() $sorted_path) is also<convert-path-to-child-path> {
    gtk_tree_model_sort_convert_path_to_child_path($!tms, $sorted_path);
  }

  method get_model is also<get-model> {
    gtk_tree_model_sort_get_model($!tms);
  }

  method get_type is also<get-type> {
    gtk_tree_model_sort_get_type();
  }

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    gtk_tree_model_sort_iter_is_valid($!tms, $iter);
  }

  method reset_default_sort_func is also<reset-default-sort-func> {
    gtk_tree_model_sort_reset_default_sort_func($!tms);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

