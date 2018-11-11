use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Layout;
use GTK::Raw::Types;

use GTK::Container;

use GTK::Roles::Scrollable;

my subset ParentChild where GtkLayout | GtkWidget;

class GTK::Layout is GTK::Container {
  also does GTK::Roles::Scrollable;

  has GtkLayout $!l;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Layout');
    $o;
  }

  submethod BUILD(:$layout) {
    given $layout {
      when ParentChild {
        self.setLayout($layout);
      }
      when GTK::Layout {
      }
      default {
      }
    }
  }

  method setLayout($layout) {
    my $to-parent;
    $!l = do {
      given $layout {
        when GtkWidget {
          $to-parent = $_;
          nativecast(GtkLayout, $_);
        }
        when GtkLayout  {
          $to-parent = nativecast(GtkContainer, $_);
          $_;
        }
      }
    }
    self.setContainer($to-parent);
    $!s = nativecast(GtkScrollable, $!l);     # GTK::Roles::Scrollable
  }

  multi method new (ParentChild $layout) {
    self.bless(:$layout);
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
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('height', $gv); );
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
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('width', $gv); );
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
    gtk_layout_get_bin_window($!l);
  }

  multi method get-size {
    self.get_size;
  }
  multi method get_size {
    my ($w, $h);
    samewith($w, $h);
    ($w, $h);
  }

  multi method get-size (
    Int() $width is rw,
    Int() $height is rw
  ) {
    self.get_size($width, $height);
  }
  multi method get_size (
    Int() $width is rw,
    Int() $height is rw
  ) {
    my @i = ($width, $height);
    my guint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_layout_get_size($!l, $w, $h);
    ($width, $height) = ($w, $h);
    Nil;
  }

  method get_type is also<get-type> {
    gtk_layout_get_type();
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

}
