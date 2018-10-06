use v6.c;

use NativeCall;

use GTK::Raw::TreeModel;

class GTK::TreeIter  {
  has GtkTreeIter $!ti;

  submethod BUILD(:$iter) {
    $!ti = $iter;
  }

  method new (GtkTreeIter $iter) {
    self.bless(:$iter);
  }

  method GTK::Raw::Types::GtkTreeIter {
    $!ti;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method copy {
    my $iter = gtk_tree_iter_copy($!ti);
    self.bless(:$iter);
  }

  method free {
    gtk_tree_iter_free($!ti);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
