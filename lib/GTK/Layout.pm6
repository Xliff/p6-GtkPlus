use v6.c;

use Method::Also;

use GTK::Raw::Layout;
use GTK::Raw::Types;

use GLib::Value;
use GDK::Window;
use GTK::Container;

use GTK::Roles::Scrollable;

our subset LayoutAncestry is export
  where GtkLayout | GtkScrollable | ContainerAncestry;

class GTK::Layout is GTK::Container {
  also does GTK::Roles::Scrollable;

  has GtkLayout $!l is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$layout) {
    given $layout {
      when LayoutAncestry { self.setLayout($layout) }
      when GTK::Layout    { }
      default             { }
    }
  }

  method GTK::Raw::Definitions::GtkLayout
    is also<
      Layout
      GtkLayout
    >
  { $!l }

  method setLayout(LayoutAncestry $layout) {
    my $to-parent;
    $!l = do {
      given $layout {
        when GtkLayout  {
          $to-parent = cast(GtkContainer, $_);
          $_;
        }
        when GtkScrollable {
          $!s = $_ ;                              # GTK::Roles::Scrollable
          $to-parent = cast(GtkContainer, $_);
          cast(GtkLayout, $_);
        }
        default {
          $to-parent = $_;
          cast(GtkLayout, $_);
        }
      }
    }
    $!s //= cast(GtkScrollable, $!l);     # GTK::Roles::Scrollable
    self.setContainer($to-parent);
  }

  multi method new (LayoutAncestry $layout, :$ref = True) {
    return Nil unless $layout;

    my $o = self.bless(:$layout);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment,
    GtkAdjustment() $vadjustment
  ) {
    my $layout = gtk_layout_new($hadjustment, $vadjustment);

    $layout ?? self.bless(:$layout) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: guint
  method height is rw {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('height', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: guint
  method width is rw {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('width', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_bin_window (:$raw = False) is also<get-bin-window> {
    my $gw = gtk_layout_get_bin_window($!l);

    $gw ??
      ( $raw ?? $gw !! GDK::Window.new($gw) )
      !!
      Nil;
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size (
    $width is rw,
    $height is rw
  ) {
    my guint ($w, $h) = 0 xx 2;
    gtk_layout_get_size($!l, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_layout_get_type, $n, $t );
  }

  method move (GtkWidget() $child_widget, Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y);

    gtk_layout_move($!l, $child_widget, $x, $y);
  }

  method put (GtkWidget() $child_widget, Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y);

    gtk_layout_put($!l, $child_widget, $x, $y);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my guint ($w, $h) = ($width, $height);

    gtk_layout_set_size($!l, $width, $height);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'x' | 'y'   { self.child-set-int($c, $p, $v)  }

        default          { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
