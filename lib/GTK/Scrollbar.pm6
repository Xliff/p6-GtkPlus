use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scrollbar;
use GTK::Raw::Types;

use GTK::Range;

class GTK::Scrollbar is GTK::Range {
  has GtkScrollbar $!sb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Scrollbar');
    $o;
  }

  submethod BUILD(:$scroll) {
    my $to-parent;
    given $scroll {
      when GtkScrollbar | GtkWidget {
        $!sb = do {
          when GtkWidget {
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

  multi method new (GtkWidget $scroll) {
    self.bless(:$scroll);
  }
  multi method new (Int() $orientation, GtkAdjustment() $adjustment) {
    my uint32 $or = self.RESOLVE-UINT($orientation);
    my $scroll = gtk_scrollbar_new($or, $adjustment);
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
