use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scrollbar;
use GTK::Raw::Types;

use GTK::Range;

our subset ScrollbarAncestry is export
  where GtkScrollbar | RangeAncestry;

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
      when ScrollbarAncestry {
        $!sb = do {
          when GtkScrollbar {
            $to-parent = nativecast(GtkRange, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkScrollbar, $_);
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
  
  multi method GTK::Raw::Types::Scrollbar is also<Scrollbar> { $!sb }

  multi method new (ScrollbarAncestry $scroll) {
    my $o = self.bless(:$scroll);
    $o.upref;
    $o;
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


  method get_type is also<get-type> {
    gtk_scrollbar_get_type();
  }

}
