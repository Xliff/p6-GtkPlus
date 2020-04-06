use v6.c;

use Method::Also;

use GTK::Raw::Scrollbar;
use GTK::Raw::Types;

use GTK::Range;

our subset ScrollbarAncestry is export
  where GtkScrollbar | RangeAncestry;

class GTK::Scrollbar is GTK::Range {
  has GtkScrollbar $!sb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$scroll) {
    my $to-parent;
    given $scroll {
      when ScrollbarAncestry {
        $!sb = do {
          when GtkScrollbar {
            $to-parent = cast(GtkRange, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkScrollbar, $_);
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

  multi method GTK::Raw::Definitions::Scrollbar
    is also<
      Scrollbar
      GtkScrollbar
    >
  { $!sb }

  multi method new (ScrollbarAncestry $scroll, :$ref = True) {
    return Nil unless $scroll;

    my $o = self.bless(:$scroll);
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation, GtkAdjustment() $adjustment) {
    my uint32 $or = $orientation;
    my $scroll = gtk_scrollbar_new($or, $adjustment);

    $scroll ?? self.bless(:$scroll) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑


  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_scrollbar_get_type, $n, $t);
  }

}
