use v6.c;

use NativeCall;

use GTK::Raw::Bin;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Bin is GTK::Container {
  has GtkBin $!bin;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Bin');
    $o;
  }

  submethod BUILD(:$bin) {
    when GtkBin | GtkWidget {
      self.setBin($bin);
    }
    when GTK::Bin {
      my $c = ::?CLASS.^name;
      warn "To copy a { $c } object, use { $c }.clone.";
    }
    default {
      # Throw exception
    }
  }

  method setBin($bin) {
#    "setBin".say;
    my $to-parent;
    $!bin = do given $bin {
      when GtkBin {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkBin, $_);
      }
    };
    self.setContainer($to-parent);
  }

  multi method get_child {
    gtk_bin_get_child($!bin);
  }

  method get_type {
    gtk_bin_get_type();
  }

  # XXX - Override add to take only one child?

}
