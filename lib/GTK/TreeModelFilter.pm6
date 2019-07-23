use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModelFilter;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeDnD;
use GTK::Roles::Types;

class GTK::TreeModelFilter {
  also does GTK::Roles::Properties;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeDragSource;

  has GtkTreeModelFilter $!tmf;

  submethod BUILD(:$treefilter) {
    self!setObject($!tmf = $treefilter);            # GTK::Roles::Properties

    $!tm = nativecast(GtkTreeModel, $!tmf);         # GTK::Roles::TreeModel
    $!ds = nativecast(GtkTreeDragSource, $!tmf);    # GTK::Roles::TreeDragSource
  }
  
  method GTK::Raw::Types::GtkTreeModelFilter is also<TreeModelFilter> { $!tmf }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkTreeModel
  method child-model is rw is also<child_model> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('child-model', $gv);
        $gv.object;
      },
      STORE => -> $, GtkTreeModel() $val is copy {
        $gv.object = $val;
        self.prop_set('child-model', $gv)
      }
    );
  }

  # Type: GtkTreePath
  method virtual-root is rw is also<virtual_root> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('virtual-root', $gv) ;
        $gv.object;
      },
      STORE => -> $, GtkTreePath() $val is copy {
        $gv.object = $val;
        self.prop_set('virtual-root', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_cache is also<clear-cache> {
    gtk_tree_model_filter_clear_cache($!tmf);
  }

  method convert_child_iter_to_iter (
    GtkTreeIter() $filter_iter,
    GtkTreeIter() $child_iter
  ) 
    is also<convert-child-iter-to-iter> 
  {
    gtk_tree_model_filter_convert_child_iter_to_iter(
      $!tmf,
      $filter_iter,
      $child_iter
    );
  }

  method convert_child_path_to_path (GtkTreePath() $child_path) 
    is also<convert-child-path-to-path> 
  {
    gtk_tree_model_filter_convert_child_path_to_path($!tmf, $child_path);
  }

  method convert_iter_to_child_iter (
    GtkTreeIter() $child_iter,
    GtkTreeIter() $filter_iter
  ) 
    is also<convert-iter-to-child-iter> 
  {
    gtk_tree_model_filter_convert_iter_to_child_iter(
      $!tmf,
      $child_iter,
      $filter_iter
    );
  }

  method convert_path_to_child_path (GtkTreePath() $filter_path) 
    is also<convert-path-to-child-path> 
  {
    gtk_tree_model_filter_convert_path_to_child_path($!tmf, $filter_path);
  }

  method get_model is also<get-model> {
    gtk_tree_model_filter_get_model($!tmf);
  }

  method get_type is also<get-type> {
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
  ) 
    is also<set-modify-func> 
  {
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

  method set_visible_column (Int() $column) is also<set-visible-column> {
    my gint $c = self.RESOLVE-INT($column);
    gtk_tree_model_filter_set_visible_column($!tmf, $c);
  }

  method set_visible_func (
    GtkTreeModelFilterVisibleFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) 
    is also<set-visible-func> 
  {
    gtk_tree_model_filter_set_visible_func($!tmf, $func, $data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
