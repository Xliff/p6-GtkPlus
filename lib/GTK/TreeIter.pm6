use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::TreeModel;

# BOXED TYPE

class GTK::TreeIter is export {
  has GtkTreeIter $!ti;

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
