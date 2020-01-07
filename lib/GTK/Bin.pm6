use v6.c;

use Method::Also;
use NativeCall;



use GTK::Raw::Bin;
use GTK::Raw::Types;

use GTK::Container;

our subset BinAncestry is export of Mu
  where GtkBin | ContainerAncestry;

class GTK::Bin is GTK::Container {
  has GtkBin $!bin;   # Implementor in GTK::Widget

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$bin) {
    given $bin {
      when BinAncestry {
        self.setBin($bin);
      }

      when GTK::Bin {
        my $c = ::?CLASS.^name;
        warn "To copy a { $c } object, use { $c }.clone.";
      }

      default {
        # DO NOT throw exception here due to BUILD path logic and descendant
        # creation!
      }
    }
  }

  method GTK::Raw::Types::GtkBin
    is also<
      GtkBin
      Bin
    >
  { $!bin }

  method setBin(BinAncestry $_) {
    return unless $_;

    my $to-parent;
    $!bin = do {
      when GtkBin {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }
      when ContainerAncestry {
        $to-parent = $_;
        cast(GtkBin, $_);
      }
    };
    self.setContainer($to-parent);
  }

  method new (BinAncestry $bin) {
    my $o = self.bless(:$bin);

    $o.upref;
    $o;
  }

  multi method add (GTK::Widget $widget) {
    self.set_end($widget);
    self.SET-LATCH;
    samewith($widget.Widget);
  }
  multi method add (GtkWidget $widget) {
    self.set_end($widget) unless self.IS-LATCHED;
    self.SET-LATCH;
    nextwith($widget);
  }

  multi method remove(GtkWidget() $widget) {
    self.clear_end if self.end[0].p != +$widget.p;
    nextwith($widget);
  }

  method get_child is also<get-child> {
    self.end[0] ~~ GTK::Widget ??
      self.end[0] !! gtk_bin_get_child($!bin);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_bin_get_type, $n, $t );
  }

  # XXX - Override add to take only one child?

}
