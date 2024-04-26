use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TreeModelFilter:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;

use GLib::Roles::Object;
use GTK::Roles::TreeModel:ver<3.0.1146>;
use GTK::Roles::TreeDnD:ver<3.0.1146>;
use GTK::Roles::Types:ver<3.0.1146>;


our subset GtkTreeModelFilterAncestry is export of Mu
  where GtkTreeModelFilter | GtkTreeModel | GtkTreeDragSource | GObject;

class GTK::TreeModelFilter:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeDragSource;

  has GtkTreeModelFilter $!tmf is implementor;

  submethod BUILD ( :$gtk-tree-filter ) {
    self.setGtkTreeModelFilter($gtk-tree-filter) if $gtk-tree-filter
  }

  method setGtkTreeModelFilter (GtkTreeModelFilterAncestry $_) {
    my $to-parent;

    $!tmf = do {
      when GtkTreeModelFilter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkTreeModel {
        $to-parent = cast(GObject, $_);
        $!tm       = $_;
        cast(GtkTreeModelFilter, $_);
      }

      when GtkTreeDragSource {
        $to-parent = cast(GObject, $_);
        $!ds       = $_;
        cast(GtkTreeModelFilter, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkTreeModelFilter, $_);
      }
    }
    self!setObject($to-parent);
    # self.roleInit-GtkTreeModel;
    # self.roleInit-GtkTreeDragSource
  }

  method GTK::Raw::Definitions::GtkTreeModelFilter
    is also<
      TreeModelFilter
      GtkTreeModelFilter
    >
  { $!tmf }

  multi method new (
    $gtk-tree-filter where * ~~ GtkTreeModelFilterAncestry,

    :$ref = True
  ) {
    return unless $gtk-tree-filter;

    my $o = self.bless( :$gtk-tree-filter );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkTreeModel() $model, GtkTreePath() $root) {
    my $gtk-tree-filter = gtk_tree_model_filter_new($model, $root);

    $gtk-tree-filter ?? self.bless( :$gtk-tree-filter ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkTreeModel
  method child-model is rw is also<child_model> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
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
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
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

  method get_model (:$raw = False) is also<get-model> {
    my $tmf = gtk_tree_model_filter_get_model($!tmf);

    $tmf ??
      ( $raw ?? $tmf !! GTK::Roles::TreeModel.new-treemodel-obj($tmf) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_model_filter_get_type, $n, $t );
  }

  method refilter {
    gtk_tree_model_filter_refilter($!tmf);
  }

  proto method set_modify_func (|)
    is also<set-modify-func>
  { * }

  multi method set_modify_func (
    @types,
    &func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    samewith( ArrayToCArray(GType, @types), &func, $data, $destroy );
  }
  multi method set_modify_func (
    Int() $n_columns,
    CArray[GType] $types,
    &func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  ) {
    my gint $nc = $n_columns;

    gtk_tree_model_filter_set_modify_func(
      $!tmf,
      $nc,
      $types,
      &func,
      $data,
      $destroy
    );
  }

  method set_visible_column (Int() $column) is also<set-visible-column> {
    my gint $c = $column;

    gtk_tree_model_filter_set_visible_column($!tmf, $c);
  }

  method set_visible_func (
    &func,
    gpointer $data = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-visible-func>
  {
    gtk_tree_model_filter_set_visible_func($!tmf, &func, $data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
