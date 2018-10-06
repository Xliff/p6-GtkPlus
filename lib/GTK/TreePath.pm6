use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::TreePath {
  also does GTK::Roles::Types;

  has GtkTreePath $!tp;

  submethod BUILD(:$path) {
    $!tp = $path;
  }

  multi method new {
    my $path = gtk_tree_path_new();
    self.bless(:$path);
  }
  multi method new (GtkTreePath $path) {
    self.bless(:$path);
  }

  method new_first {
    my $path = gtk_tree_path_new_first();
    self.bless(:$path);
  }

  method new_from_indicesv (Int @indicies) {
    my CArray[gint] $i = CArray[gint].new;
    $i[$++] = self.RESOLVE-INT($_) for @indicies;
    my $path = gtk_tree_path_new_from_indicesv($i, $i.elems);
    self.bless(:$path);
  }

  method new_from_string ($path) {
    my $path = gtk_tree_path_new_from_string($path);
    self.bless(:$path);
  }

  method GTK::Raw::Types::GtkTreePath {
    $!tp;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_index (Int() $index) {
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

  method get_depth {
    gtk_tree_path_get_depth($!tp);
  }

  method get_indices {
    gtk_tree_path_get_indices($!tp);
  }

  method get_indices_with_depth (Int() $depth) {
    my gint $d = self.RESOLVE-INT($depth)
    gtk_tree_path_get_indices_with_depth($!tp, $depth);
  }

  method is_ancestor (GtkTreePath() $descendant) {
    gtk_tree_path_is_ancestor($!tp, $descendant);
  }

  method is_descendant (GtkTreePath() $ancestor) {
    gtk_tree_path_is_descendant($!tp, $ancestor);
  }

  method next {
    gtk_tree_path_next($!tp);
  }

  method prepend_index (Int() $index) {
    my gint $i = self.RESOLVE-INT($index);
    gtk_tree_path_prepend_index($!tp, $i);
  }

  method prev {
    gtk_tree_path_prev($!tp);
  }

  method to_string {
    gtk_tree_path_to_string($!tp);
  }

  method up {
    gtk_tree_path_up($!tp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
