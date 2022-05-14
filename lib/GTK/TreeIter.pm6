use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::TreeModel:ver<3.0.1146>;

# BOXED TYPE

class GTK::TreeIter:ver<3.0.1146> is export {
  also does GLib::Roles::Implementor;

  has GtkTreeIter $!ti is implementor;

  submethod BUILD(:$iter) {
    $!ti = $iter;
  }

  method new (GtkTreeIter $iter) {
    $iter ?? self.bless(:$iter) !! Nil;
  }

  method GTK::Raw::Structs::GtkTreeIter
    is also<
      GtkTreeIter
      TreeIter
    >
  { $!ti }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method copy ( :$raw = False ) {
    my $iter = gtk_tree_iter_copy($!ti);

    $iter ??
      ( $raw ?? $iter !! self.bless( :$iter ) )
      !!
      Nil;
  }

  method free {
    gtk_tree_iter_free($!ti);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
