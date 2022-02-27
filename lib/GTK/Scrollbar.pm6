use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Scrollbar:ver<3.0.1146>;

use GTK::Range:ver<3.0.1146>;

our subset ScrollbarAncestry is export
  where GtkScrollbar | RangeAncestry;

class GTK::Scrollbar:ver<3.0.1146> is GTK::Range {
  has GtkScrollbar $!sb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$scroll) {
    self.setGtkScrollBar($scroll) if $scroll;
  }

  method setGtkScrollBar (ScrollbarAncestry $_) {
    my $to-parent;

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

  multi method GTK::Raw::Definitions::Scrollbar
    is also<
      Scrollbar
      GtkScrollbar
    >
  { $!sb }

  multi method new (ScrollbarAncestry $scroll, :$ref = True) {
    return Nil unless $scroll;

    my $o = self.bless( :$scroll );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation, GtkAdjustment() $adjustment) {
    my uint32 $or     = $orientation;
    my        $scroll = gtk_scrollbar_new($or, $adjustment);

    $scroll ?? self.bless(:$scroll) !! Nil;
  }

  method new-vbar (GtkAdjustment() $adj = GtkAdjustment) {
    self.new(GTK_ORIENTATION_VERTICAL, $adj);
  }

  method new-hbar (GtkAdjustment() $adj = GtkAdjustment) {
    self.new(GTK_ORIENTATION_HORIZONTAL, $adj);
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
