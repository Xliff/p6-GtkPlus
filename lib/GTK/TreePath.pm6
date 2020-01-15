use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::Types;

# BOXED TYPE

class GTK::TreePath {
  also does GTK::Roles::Types;

  has GtkTreePath $!tp is implementor;

  submethod BUILD(:$path) {
    $!tp = $path;
  }
  
  method GTK::Raw::Definitions::GtkTreePath is also<TreePath> { $!tp }

  multi method new {
    my $path = gtk_tree_path_new();
    self.bless(:$path);
  }
  multi method new (GtkTreePath $path) {
    self.bless(:$path);
  }

  method new_first is also<new-first> {
    my $path = gtk_tree_path_new_first();
    self.bless(:$path);
  }

  method new_from_indicesv (Int @indicies) is also<new-from-indicesv> {
    my CArray[gint] $i = CArray[gint].new;
    my $ii = 0;
    $i[$ii++] = self.RESOLVE-INT($_) for @indicies;
    my $path = gtk_tree_path_new_from_indicesv($i, $i.elems);
    self.bless(:$path);
  }

  method new_from_string (Str() $newpath) is also<new-from-string> {
    my $path = gtk_tree_path_new_from_string($newpath);
    self.bless(:$path);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_index (Int() $index) is also<append-index> {
    my gint $i = self.RESOLVE-INT($index);
    gtk_tree_path_append_index($!tp, $i);
  }

  method compare (GtkTreePath() $b) {
    gtk_tree_path_compare($!tp, $b);
  }

  method copy {
    gtk_tree_path_copy($!tp);
  }

  method down {
    gtk_tree_path_down($!tp);
  }

  method free {
    gtk_tree_path_free($!tp);
  }

  method get_depth is also<get-depth> {
    gtk_tree_path_get_depth($!tp);
  }

  method get_indices is also<get-indices> {
    my CArray[gint] $r := gtk_tree_path_get_indices($!tp);
    my @r;
    my $i = 0;
    @r[$i] = $r[$i++] for ^self.get_depth;
    @r;
  }

  method get_indices_with_depth (Int() $depth)
    is also<get-indices-with-depth>
  {
    my gint $d = self.RESOLVE-INT($depth);
    my CArray[gint] $r := gtk_tree_path_get_indices_with_depth($!tp, $depth);
    my @r;
    my $i = 0;
    @r[$i] = $r[$i++] for (^self.get_depth);
  }

  method is_ancestor (GtkTreePath() $descendant) is also<is-ancestor> {
    gtk_tree_path_is_ancestor($!tp, $descendant);
  }

  method is_descendant (GtkTreePath() $ancestor) is also<is-descendant> {
    gtk_tree_path_is_descendant($!tp, $ancestor);
  }

  method next {
    gtk_tree_path_next($!tp);
  }

  method prepend_index (Int() $index) is also<prepend-index> {
    my gint $i = self.RESOLVE-INT($index);
    gtk_tree_path_prepend_index($!tp, $i);
  }

  method prev {
    gtk_tree_path_prev($!tp);
  }

  method to_string is also<to-string> {
    gtk_tree_path_to_string($!tp);
  }

  method up {
    gtk_tree_path_up($!tp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
