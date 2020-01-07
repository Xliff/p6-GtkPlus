use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::Types;

# BOXED TYPE

class GTK::TreeRowReference {
  also does GTK::Roles::Types;

  has GtkTreeRowReference $!tr is implementor;

  submethod BUILD(:$row) {
    $!tr = $row
  }
  
  method GTK::Raw::Types::GtkTreeRowReference 
    is also<TreeRowReference>
    { $!tr }

  multi method new (GtkTreeModel() $model, GtkTreePath() $path) {
    my $row = gtk_tree_row_reference_new($model, $path);
    self.bless(:$row);
  }

  method new_proxy (
    GObject $proxy,
    GtkTreeModel() $model,
    GtkTreePath() $path
  ) is also<new-proxy> {
    my $row = gtk_tree_row_reference_new_proxy($proxy, $model, $path);
    self.bless(:$row)
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Begin Static
  method inserted (GObject $proxy, GtkTreePath() $path) {
    gtk_tree_row_reference_inserted($proxy, $path);
  }

  method deleted (GObject $proxy, GtkTreePath() $path) {
    gtk_tree_row_reference_deleted($proxy, $path);
  }

  method reordered (
    GObject $proxy,
    GtkTreePath() $path,
    GtkTreeIter() $iter,
    gint $new_order
  ) {
    my gint $no = self.RESOLVE-INT($new_order);
    gtk_tree_row_reference_reordered($proxy, $path, $iter, $no);
  }
  # End Static

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_tree_row_reference_copy($!tr);
  }

  method free {
    gtk_tree_row_reference_free($!tr);
  }

  method get_model is also<get-model> {
    gtk_tree_row_reference_get_model($!tr);
  }

  method valid {
    gtk_tree_row_reference_valid($!tr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
