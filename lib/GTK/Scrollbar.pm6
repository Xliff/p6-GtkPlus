use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scrollbar;
use GTK::Raw::Types;

use GTK::Range;

class GTK::Scrollbar is GTK::Range {
  has GtkScrollbar $!sb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Scrollbar');
    $o;
  }

  submethod BUILD(:$scroll) {
    my $to-parent;
    given $scroll {
      when GtkScrollbar | GtkWidget {
        $!sb = do {
          when GtkWidget    {
            $to-parent = $_;
            nativecast(GtkScrollbar, $_);
          }
          when GtkScrollbar {
            $to-parent = nativecast(GtkRange, $_);
            $_;
          }
        };
        self.setRange($to-parent);
      }
      when GTK::Scrollbar {
      }
      default {
      }
    }
  }

  method new (Int() $orientation, Int() $adjustment) {
    my @u = ($orientation, $adjustment);
    my uint32 ($or, $ad) = self.RESOLVE-UINT(@u);
    my $scroll = gtk_scrollbar_new($or, $ad);
    self.bless(:$scroll);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑


  method get_type {
    gtk_scrollbar_get_type();
  }

}
