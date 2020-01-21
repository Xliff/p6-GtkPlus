use v6.c;

use Method::Also;

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

  method GTK::Raw::Definitions::GtkTreePath
    is also<
      TreePath
      GtkTreePath
    >
  { $!tp }

  multi method new (GtkTreePath $path) {
    $path ?? self.bless(:$path) !! Nil;
  }
  multi method new {
    my $path = gtk_tree_path_new();

    $path ?? self.bless(:$path) !! Nil;
  }

  method new_first is also<new-first> {
    my $path = gtk_tree_path_new_first();

    $path ?? self.bless(:$path) !! Nil;
  }

  method new_from_indicesv (Int @indicies) is also<new-from-indicesv> {
    my $path = gtk_tree_path_new_from_indicesv(
      ArrayToCArray(gint, @indicies),
      @indicies.elems
    );

    $path ?? self.bless(:$path) !! Nil;
  }

  method new_from_string (Str() $newpath) is also<new-from-string> {
    my $path = gtk_tree_path_new_from_string($newpath);

    $path ?? self.bless(:$path) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append_index (Int() $index) is also<append-index> {
    my gint $i = $index;

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
    CArrayToArray( gtk_tree_path_get_indices($!tp), self.get_depth );
  }

  method get_indices_with_depth (Int() $depth)
    is also<get-indices-with-depth>
  {
    CArrayToArray(
      gtk_tree_path_get_indices_with_depth($!tp, $depth),
      self.get_depth
    );
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
    my gint $i = $index;

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
