use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scrollbar;
use GTK::Raw::Types;

use GTK::Range;

class GTK::Scrollbar is GTK::Range {
  has GtkScrollbar $!sb;

  submethod BUILD(:$scroll) {
    given $scroll {
      when GtkScrollbar | GtkWidget {
        $!sb = nativecast(GtkScrollbar, $scroll);
        self.setRange($scroll);
      }
      when GTK:: {
      }
      default {
      }
    }
  }

  method new (GtkOrientation $or, GtkAdjustment $adjustment) {
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
