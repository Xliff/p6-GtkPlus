use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Bin;
use GTK::Raw::Types;

use GTK::Container;

my subset Ancestry where GtkBin | GtkContainer | GtkBuildable | GtkWidget;

class GTK::Bin is GTK::Container {
  has GtkBin $!bin;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Bin');
    $o;
  }

  submethod BUILD(:$bin) {
    given $bin {
      when Ancestry {
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
  }

  method setBin($bin) {
    my $to-parent;
    $!bin = do given $bin {
      when GtkBin {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkBin, $_);
      }
    };
    self.setContainer($to-parent);
  }

  method new(Ancestry $bin) {
    my $o = self.bless(:$bin);
    $o.upref;
    $o;
  }

  multi method get_child is also<get-child> {
    gtk_bin_get_child($!bin);
  }

  method get_type is also<get-type> {
    gtk_bin_get_type();
  }

  # XXX - Override add to take only one child?

}
