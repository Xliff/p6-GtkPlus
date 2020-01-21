use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TreeSelection;
use GTK::Raw::Types;

use GTK::TreeIter;
use GTK::TreePath;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;
use GLib::Roles::Object;
use GTK::Roles::TreeModel;

# BOXED TYPE

class GTK::TreeSelection {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;
  also does GLib::Roles::Object;

  has GtkTreeSelection $!ts is implementor;

  submethod BUILD(:$selection) {
    self!setObject($!ts = $selection);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::Definitions::GtkTreeSelection
    is also<
      TreeSelection
      GtkTreeSelection
    >
  { $!ts }

  method new (GtkTreeSelection $selection) {
    $selection ?? self.bless(:$selection) !! Nil;
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
        GtkSelectionModeEnum( gtk_tree_selection_get_mode($!ts) );
      },
      STORE => sub ($, $type is copy) {
        my uint32 $t = $type;

        gtk_tree_selection_set_mode($!ts, $t);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method count_selected_rows is also<count-selected-rows> {
    gtk_tree_selection_count_selected_rows($!ts);
  }

  method get_select_function is also<get-select-function> {
    gtk_tree_selection_get_select_function($!ts);
  }

  proto method get_selected(|)
    is also<get-selected selected>
  { * }

  multi method get_selected (:$raw = False) {
    my @r = callwith($model, $iter, :all, :$raw);

    @r[0] ?? @[1..*] !! Nil;
  }
  # Insure we have a proper r/w container by forcing the type.
  multi method get_selected (
    $model is rw,
    $iter is rw
  ) {
    my $m = CArray[Pointer[GtkTreeSelection]].new;
    my $i = GtkTreeIter.new;

    $m[0] = Pointer[GtkTreeSelection];
    my $rv = gtk_tree_selection_get_selected($!ts, $m, $iter);

    if $rv {
      $model = $m[0] ??
        ( $raw ?? $m[0] !! GTK::Roles::TreeModel.new-treemodel-obj($m[0]) )
        !!
        Nil;

      $iter = $i ??
        ($raw ?? $i !! GTK::TreeIter.new($i)
        !!
        Nil;
    } else {
      ($model, $iter) = Nil xx 2;
    }

    $all.not ?? $rv !! ($rv, $model, $iter);
  }

  proto method get_selected_rows
    is also<get-selected-rows>
  { * }

  method get_selected_rows (:$glist = False, :$raw = False) {
    samewith($model, :$glist, :$raw);
  }
  method get_selected_rows ($model is rw, :$glist = False, :$raw = False) {
    my $m = CArray[Pointer[GtkTreeModel]].new;

    $m[0] = Pointer[GtkTreeModel];
    my $srl = gtk_tree_selection_get_selected_rows($!ts, $m);

    $model = $m[0] ??
      ( $raw ?? $m[0] !! GTK::Roles::TreeModel.new($m[0]) )
      !!
      Nil;

    return Nil unless $srl;
    return $srl if $glist;

    $srl = GLib::GList.new($srl) but GLib::Roles::ListData[GtkTreePath];
    $raw ?? $srl.Array !! $srl.Array.map({ GTK::TreePath.new($srl) });
  }

  method get_tree_view (:$raw = False) is also<get-tree-view> {
    my $tv = gtk_tree_selection_get_tree_view($!ts);

    $tv ??
      ( $raw ?? $tv !! ::('GTK::TreeView').new($tv) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_selection_get_type, $n, $t );
  }

  method get_user_data is also<get-user-data> {
    gtk_tree_selection_get_user_data($!ts);
  }

  method iter_is_selected (GtkTreeIter() $iter)
    is also<iter-is-selected>
  {
    so gtk_tree_selection_iter_is_selected($!ts, $iter);
  }

  method path_is_selected (GtkTreePath() $path) is also<path-is-selected> {
    so gtk_tree_selection_path_is_selected($!ts, $path);
  }

  method select_all is also<select-all> {
    gtk_tree_selection_select_all($!ts);
  }

  method select_iter (GtkTreeIter() $iter) is also<select-iter> {
    gtk_tree_selection_select_iter($!ts, $iter);
  }

  method select_path (GtkTreePath() $path) is also<select-path> {
    gtk_tree_selection_select_path($!ts, $path);
  }

  method select_range (GtkTreePath() $start_path, GtkTreePath() $end_path)
    is also<select-range>
  {
    gtk_tree_selection_select_range($!ts, $start_path, $end_path);
  }

  method selected_foreach (
    &func,
    gpointer $data
  )
    is also<selected-foreach>
  {
    gtk_tree_selection_selected_foreach($!ts, &func, $data);
  }

  method set_select_function (
    &func,
    gpointer $data          = gpointer,
    GDestroyNotify $destroy = GDestroyNotify
  )
    is also<set-select-function>
  {
    gtk_tree_selection_set_select_function($!ts, &func, $data, $destroy);
  }

  method unselect_all is also<unselect-all> {
    gtk_tree_selection_unselect_all($!ts);
  }

  method unselect_iter (GtkTreeIter() $iter) is also<unselect-iter> {
    gtk_tree_selection_unselect_iter($!ts, $iter);
  }

  method unselect_path (GtkTreePath() $path) is also<unselect-path> {
    gtk_tree_selection_unselect_path($!ts, $path);
  }

  method unselect_range (
    GtkTreePath() $start_path,
    GtkTreePath() $end_path
  )
    is also<unselect-range>
  {
    gtk_tree_selection_unselect_range($!ts, $start_path, $end_path);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
