use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeSelection;
use GTK::Raw::Types;

use GTK::Roles::Signals;
use GTK::Roles::Types;

class GTK::TreeSelection {
  also does GTK::Roles::Signals;
  also does GTK::Roles::Types;

  has GtkTreeSelection $!ts;

  submethod BUILD(:$selection) {
    $!ts = $selection;
  }

  method new (GtkTreeSelection $selection) {
    self.bless(:$selection);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTreeSelection, gpointer --> void
  method changed {
    self.connect($!ts, 'changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSelectionMode( gtk_tree_selection_get_mode($!ts) );
      },
      STORE => sub ($, $type is copy) {
        my uint32 $t = self.RESOLVE-UINT($type);
        gtk_tree_selection_set_mode($!ts, $t);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method count_selected_rows {
    gtk_tree_selection_count_selected_rows($!ts);
  }

  method get_select_function {
    gtk_tree_selection_get_select_function($!ts);
  }

  multi method get_selected {
    my GtkTreeModel $model = GtkTreeModel.new;
    my GtkTreeIter $iter = GtkTreeIter.new;
    ($model, $iter) if samewith($model, $iter);
  }
  multi method get_selected (
    GtkTreeModel() $model is rw,
    GtkTreeIter() $iter
  ) {
    gtk_tree_selection_get_selected($!ts, $model, $iter);
  }

  method get_selected_rows (Pointer[GtkTreeModel] $model) {
    gtk_tree_selection_get_selected_rows($!ts, $model);
  }

  method get_tree_view {
    gtk_tree_selection_get_tree_view($!ts);
  }

  method get_type {
    gtk_tree_selection_get_type();
  }

  method get_user_data {
    gtk_tree_selection_get_user_data($!ts);
  }

  method iter_is_selected (GtkTreeIter() $iter) {
    gtk_tree_selection_iter_is_selected($!ts, $iter);
  }

  method path_is_selected (GtkTreePath() $path) {
    gtk_tree_selection_path_is_selected($!ts, $path);
  }

  method select_all {
    gtk_tree_selection_select_all($!ts);
  }

  method select_iter (GtkTreeIter() $iter) {
    gtk_tree_selection_select_iter($!ts, $iter);
  }

  method select_path (GtkTreePath() $path) {
    gtk_tree_selection_select_path($!ts, $path);
  }

  method select_range (GtkTreePath() $start_path, GtkTreePath() $end_path) {
    gtk_tree_selection_select_range($!ts, $start_path, $end_path);
  }

  method selected_foreach (
    GtkTreeSelectionForeachFunc $func,
    gpointer $data
  ) {
    gtk_tree_selection_selected_foreach($!ts, $func, $data);
  }

  method set_select_function (
    GtkTreeSelectionFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    gtk_tree_selection_set_select_function($!ts, $func, $data, $destroy);
  }

  method unselect_all {
    gtk_tree_selection_unselect_all($!ts);
  }

  method unselect_iter (GtkTreeIter() $iter) {
    gtk_tree_selection_unselect_iter($!ts, $iter);
  }

  method unselect_path (GtkTreePath() $path) {
    gtk_tree_selection_unselect_path($!ts, $path);
  }

  method unselect_range (
    GtkTreePath() $start_path,
    GtkTreePath() $end_path
  ) {
    gtk_tree_selection_unselect_range($!ts, $start_path, $end_path);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
