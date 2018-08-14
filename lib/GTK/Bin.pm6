use v6.c;

use NativeCall;

use GTK::Raw::Bin;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Bin is GTK::Container {
  has $!bin; # GtkBin

  submethod BUILD(:$bin) {
    when GtkBin | GtkWidget {
      $!bin = $bin;
    }
    when GTK::Bin {
      warn "To copy a { ::?CLASS }, use { ::?CLASS }.clone.";
    }
    default {
      # Throw exception
    }
  }

  method setBin($bin) {
    self.setContainer( $!bin = nativecast(GtkBin, $bin) );
  }

  multi method get_child {
    gtk_bin_get_child($!bin);
  }

  method get_type {
    gtk_bin_get_type();
  }

  # XXX - Override pack_start and pack_end to take only one child?

}
