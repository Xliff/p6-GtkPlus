use v6.c;

use Method::Also;

use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::TreeModel;

# BOXED TYPE

class GTK::TreeRowReference {
  has GtkTreeRowReference $!tr is implementor;

  submethod BUILD(:$row) {
    $!tr = $row
  }

  method GTK::Raw::Definitions::GtkTreeRowReference
    is also<
      TreeRowReference
      GtkTreeRowReference
    >
  { $!tr }

  multi method new (GtkTreeRowReference $row) {
    $row ?? self.bless(:$row) !! Nil;
  }
  multi method new (GtkTreeModel() $model, GtkTreePath() $path) {
    my $row = gtk_tree_row_reference_new($model, $path);

    $row ?? self.bless(:$row) !! Nil;
  }

  method new_proxy (
    GObject $proxy,
    GtkTreeModel() $model,
    GtkTreePath() $path
  )
    is also<new-proxy>
  {
    my $row = gtk_tree_row_reference_new_proxy($proxy, $model, $path);

    $row ?? self.bless(:$row) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Begin Static
  method inserted (GObject() $proxy, GtkTreePath() $path) {
    gtk_tree_row_reference_inserted($proxy, $path);
  }

  method deleted (GObject() $proxy, GtkTreePath() $path) {
    gtk_tree_row_reference_deleted($proxy, $path);
  }

  method reordered (
    GObject() $proxy,
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    Int() $new_order
  ) {
    my gint $no = $new_order;

    gtk_tree_row_reference_reordered($proxy, $path, $iter, $no);
  }
  # End Static

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy (:$raw = False) {
    my $row = gtk_tree_row_reference_copy($!tr);

    $row ??
      ( $raw ?? $row !! GTK::TreeRowReference.new($row) )
      !!
      Nil;
  }

  method free {
    gtk_tree_row_reference_free($!tr);
  }

  method get_model (:$raw = False) is also<get-model> {
    my $tm = gtk_tree_row_reference_get_model($!tr);

    $tm ??
      ( $raw ?? $tm !! GTK::Roles::TreeModel.new-treemodel-obj($tm) )
      !!
      Nil;
  }

  method valid {
    so gtk_tree_row_reference_valid($!tr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
