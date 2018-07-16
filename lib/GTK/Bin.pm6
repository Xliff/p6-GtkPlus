use v6.c;

use NativeCall;

use GTK::Raw::Bin;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Bin is GTK::Container {
  has $!bin; # GtkBin

  submethod BUILD(:$bin) {
    $!bin = $bin;
  }

  method get_child (GtkBin $bin) {
    gtk_bin_get_child($bin);
  }

  method container {
    nativecast(GtkContainer, $!bin);
  }

}
