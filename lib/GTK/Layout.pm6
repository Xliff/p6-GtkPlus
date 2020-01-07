use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Layout;
use GTK::Raw::Types;

use GLib::Value;
use GDK::Window;
use GTK::Container;

use GTK::Roles::Scrollable;

our subset LayoutAncestry where GtkLayout | GtkScrollable | ContainerAncestry;

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
      when LayoutAncestry {
        self.setLayout($layout);
      }
      when GTK::Layout {
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkLayout is also<Layout> { $!l }

  method setLayout(LayoutAncestry $layout) {
    my $to-parent;
    $!l = do {
      given $layout {
        when GtkLayout  {
          $to-parent = nativecast(GtkContainer, $_);
          $_;
        }
        when GtkScrollable {
          $!s = $_ ;                              # GTK::Roles::Scrollable
          $to-parent = nativecast(GtkContainer, $_);
          nativecast(GtkLayout, $_);
        }
        default {
          $to-parent = $_;
          nativecast(GtkLayout, $_);
        }
      }
      $!s //= nativecast(GtkScrollable, $!l);     # GTK::Roles::Scrollable
      self.setContainer($to-parent);
    }
  }

  multi method new (LayoutAncestry $layout) {
    my $o = self.bless(:$layout);
    $o.upref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment,
    GtkAdjustment() $vadjustment
  ) {
    my $layout = gtk_layout_new($hadjustment, $vadjustment);
    self.bless(:$layout);
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
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('height', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: guint
  method width is rw {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('width', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('width', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_bin_window is also<get-bin-window> {
    GDKCompat::Window.new( gtk_layout_get_bin_window($!l) );
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    my ($w, $h);
    samewith($w, $h);
    ($w, $h);
  }
  multi method get_size (
    Int() $width is rw,
    Int() $height is rw
  ) {
    my @i = ($width, $height);
    my guint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_layout_get_size($!l, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_layout_get_type, $n, $t );
  }

  method move (GtkWidget() $child_widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_layout_move($!l, $child_widget, $x, $y);
  }

  method put (GtkWidget() $child_widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_layout_put($!l, $child_widget, $x, $y);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my @i = ($width, $height);
    my guint ($w, $h) = self.RESOLVE-INT(@i);
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
