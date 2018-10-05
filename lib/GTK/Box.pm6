use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Box;
use GTK::Raw::Types;

use GTK::Container;

use GTK::Roles::Orientable;

class GTK::Box is GTK::Container {
  also does GTK::Roles::Orientable;

  # Maybe make Widget a role that has $.w and all variants assign to it,
  # but how to keep $.w from being set from outside the object tree?

  has GtkBox $!b;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Box');
    $o;
  }

  submethod BUILD(:$box) {
    given $box {
      when GtkWidget | GtkBox {
        self.setBox($box);
      }
      when GTK::Box {
        my $class = ::?CLASS.^name;
        warn "To copy a { $class }, use { $class }.clone.";
      }
      default {
      }
    }
    # For GTK::Roles::Orientable
    $!or = nativecast(GtkOrientable, $!b);
  }

  multi method new (
    Int() $orientation,          # GtkOrientation,
    Int() $spacing
  ) {
    # This works because it is NOT the array version.
    my guint $o = self.RESOLVE-UINT($orientation);
    my gint $s = self.RESOLVE-INT($spacing);
    my $box = gtk_box_new($o, $s);
    self.bless(:$box);
  }
  multi method new (GtkWidget $box) {
    self.bless(:$box);
  }

  method new-hbox(Int $spacing = 2) {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_HORIZONTAL.Int, $s);
    self.bless(:$box);
  }

  method new-vbox(Int $spacing = 2) {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_VERTICAL.Int, $s);
    self.bless(:$box);
  }

  method setBox($box) {
    my $to-parent;
    $!b = do given $box {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkBox, $_);
      }
      when GtkBox {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }
    }
    self.setContainer($to-parent);
  }

  method baseline_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkBaselinePosition( gtk_box_get_baseline_position($!b) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = self.RESOLVE-UINT($position);
        gtk_box_set_baseline_position($!b, $p);
      }
    );
  }

  method center_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_center_widget($!b);
      },
      STORE => sub ($, GtkWidget() $widget is copy) {
        gtk_box_set_center_widget($!b, $widget);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_homogeneous($!b);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = self.RESOLVE-BOOL($homogeneous);
        gtk_box_set_homogeneous($!b, $h);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_spacing($!b);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = self.RESOLVE-INT($spacing);
        gtk_box_set_spacing($!b, $s);
      }
    );
  }

  method get_type {
    gtk_box_get_type();
  }

  multi method pack_end (
    GtkWidget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    my @u = ($expand, $fill, $padding);
    my ($e, $f, $p) = self.RESOLVE-UINT(@u);
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_box_pack_end($!b, $child, $e, $f, $p);
  }
  multi method pack_end (
    GTK::Widget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.unshift-end($child);
    self.SET-LATCH;
    samewith($child.widget, $expand, $fill, $padding);
  }

  multi method pack_start (
    GtkWidget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    my @u = ($expand, $fill, $padding);
    my uint32 ($e, $f, $p) = self.RESOLVE-UINT(@u);
    self.push-start($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_box_pack_start($!b, $child, $e, $f, $p);
  }
  multi method pack_start (
    GTK::Widget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.push-start($child);
    self.SET-LATCH;
    samewith($child.widget, $expand, $fill, $padding);
  }

  multi method query_child_packing (GtkWidget() $child) {
    my ($e, $f, $p, $pt) = (0 xx 4);
    callwith($child, $e, $f, $p, $pt);
    ($e, $f, $p, GtkPackType($pt));
  }
  multi method query_child_packing (
    GtkWidget() $child,
    Int() $expand is rw,
    Int() $fill is rw,
    Int() $padding is rw,
    Int() $pack_type is rw
  ) {
    my @b = ($expand, $fill);
    my @ui = ($padding, $pack_type);
    my gboolean ($e, $f) = self.RESOLVE-BOOL(@b);
    my guint ($p, $pt) = self.RESOLVE-UINT(@ui);
    my $rc = gtk_box_query_child_packing($!b, $child, $e, $f, $p, $pt);
    ($expand, $fill, $padding, $pack_type) = ($e, $f, $p, $pt);
    $rc;
  }

  multi method reorder_child (GtkWidget() $child, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_box_reorder_child($!b, $child, $p);
  }

  method set_child_packing (
    GtkWidget() $child,
    Int() $expand,
    Int() $fill,
    Int() $padding,
    Int() $pack_type
  ) {
    my @b = ($expand, $fill);
    my @ui = ($padding, $pack_type);
    my ($e, $f) = self.RESOLVE-BOOL(@b);
    my ($p, $pt) = self.RESOLVE-UINT(@ui);
    gtk_box_set_child_packing($!b, $child, $e, $f, $p, $pt);
  }

}
