use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModelFilter;
use GTK::Raw::Types;

use GTK::Roles::TreeModel;
use GTK::Roles::TreeDnD;
use GTK::Roles::Types;

class GTK::TreeModelFilter {
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeDragSource;

  has GtkTreeModelFilter $!tmf;

  submethod BUILD(:$treefilter) {
    $!tmf = $treefilter;
    $!tm = nativecast(GtkTreeModel, $!tmf);         # GTK::Roles::TreeModel
    $!ds = nativecast(GtkTreeDragSource, $!tmf);    # GTK::Roles::TreeDragSource
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkTreeModel
  method child-model is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!tmf, 'child-model', $gv); );
        $gv.object;
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        $gv.object = $val;
        self.prop_set($!tmf, 'child-model', $gv);
      }
    );
  }

  # Type: GtkTreePath
  method virtual-root is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!tmf, 'virtual-root', $gv); );
        $gv.object;
      },
      STORE => -> $, GtkTreePath() $val is copy {
        $gv.object = $val;
        self.prop_set($!tmf, 'virtual-root', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_cache {
    gtk_tree_model_filter_clear_cache($!tmf);
  }

  method convert_child_iter_to_iter (
    GtkTreeIter() $filter_iter,
    GtkTreeIter() $child_iter
  ) {
    gtk_tree_model_filter_convert_child_iter_to_iter(
      $!tmf,
      $filter_iter,
      $child_iter
    );
  }

  method convert_child_path_to_path (GtkTreePath() $child_path) {
    gtk_tree_model_filter_convert_child_path_to_path($!tmf, $child_path);
  }

  method convert_iter_to_child_iter (
    GtkTreeIter() $child_iter,
    GtkTreeIter() $filter_iter
  ) {
    gtk_tree_model_filter_convert_iter_to_child_iter(
      $!tmf,
      $child_iter,
      $filter_iter
    );
  }

  method convert_path_to_child_path (GtkTreePath() $filter_path) {
    gtk_tree_model_filter_convert_path_to_child_path($!tmf, $filter_path);
  }

  method get_model {
    gtk_tree_model_filter_get_model($!tmf);
  }

  method get_type {
    gtk_tree_model_filter_get_type();
  }

  method new (GtkTreeModel() $model, GtkTreePath() $root) {
    gtk_tree_model_filter_new($model, $root);
  }

  method refilter {
    gtk_tree_model_filter_refilter($!tmf);
  }

  method set_modify_func (
    Int() $n_columns,
    GType $types,
    GtkTreeModelFilterModifyFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    my gint $nc = self.RESOLVE-INT($n_columns);
    gtk_tree_model_filter_set_modify_func(
      $!tmf,
      $nc,
      $types,
      $func,
      $data,
      $destroy
    );
  }

  method set_visible_column (Int() $column) {
    my gint $c = self.RESOLVE-INT($column);
    gtk_tree_model_filter_set_visible_column($!tmf, $c);
  }

  method set_visible_func (
    GtkTreeModelFilterVisibleFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    gtk_tree_model_filter_set_visible_func($!tmf, $func, $data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
