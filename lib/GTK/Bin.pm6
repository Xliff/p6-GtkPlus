use v6.c;

use GTK::Container;

use GTK::Raw::Bin;
use GTK::Raw::Pointers;

class GTK::Bin is GTK::Container {
  has $!bin;

  submethod BUILD(:$bin) {
    $!bin = $bin;
  }

  method get_child (GtkBin $bin) {
    gtk_bin_get_child($bin);
  }

}
