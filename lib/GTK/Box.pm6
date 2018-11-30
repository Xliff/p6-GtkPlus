use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Box;
use GTK::Raw::Types;

use GTK::Container;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkBox| GtkContainer | GtkOrientable | GtkBuildable | GtkWidget;

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
      when Ancestry {
        self.setBox($box);
      }
      when GTK::Box {
        my $class = ::?CLASS.^name;
        warn "To copy a { $class }, use { $class }.clone.";
      }
      default {
      }
    }
  }

  method setBox($box) {
    my $to-parent;
    $!b = do given $box {
      when GtkBox {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $box;                            # For GTK::Roles::Orientable
        $to-parent = nativecast(GtkContainer, $_);
        nativecast(GtkBox, $_);
      }
      default {
        $to-parent = $_;
        nativecast(GtkBox, $_);
      }
    }
    self.setContainer($to-parent);
    $!or //= nativecast(GtkOrientable, $!b);    # For GTK::Roles::Orientable
  }

  multi method new (Ancestry $box) {
    my $o = self.bless(:$box);
    $o.upref;
    $o;
  }
  multi method new (
    # Default orientation established from Glade.
    Int() $orientation = GTK_ORIENTATION_HORIZONTAL,  # GtkOrientation,
    Int() $spacing = 0
  ) {
    # This works because it is NOT the array version.
    my guint $o = self.RESOLVE-UINT($orientation);
    my gint $s = self.RESOLVE-INT($spacing);
    my $box = gtk_box_new($o, $s);
    self.bless(:$box);
  }

  method new-hbox(Int $spacing = 0) is also<new_hbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_HORIZONTAL.Int, $s);
    self.bless(:$box);
  }

  method new-vbox(Int $spacing = 0) is also<new_vbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_VERTICAL.Int, $s);
    self.bless(:$box);
  }

  method baseline_position is rw is also<baseline-position> {
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

  method center_widget is rw is also<center-widget> {
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

  method get_type is also<get-type> {
    gtk_box_get_type();
  }

  multi method pack-end (
    GtkWidget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.pack_end($child, $expand, $fill, $padding);
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
  multi method pack-end (
    GTK::Widget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.pack_end($child, $expand, $fill, $padding);
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

  multi method pack-start (
    GtkWidget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.pack_start($child, $expand, $fill, $padding);
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
  multi method pack-start (
    GTK::Widget $child,
    Int() $expand  = 0,
    Int() $fill    = 0,
    Int() $padding = 0
  ) {
    self.pack_start($child, $expand, $fill, $padding);
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

  multi method query-child-packing (GtkWidget() $child) {
    self.query-child-packing($child);
  }
  multi method query_child_packing (GtkWidget() $child) {
    my ($e, $f, $p, $pt) = (0 xx 4);
    callwith($child, $e, $f, $p, $pt);
    ($e, $f, $p, GtkPackType($pt));
  }
  multi method query-child-packing (
    GtkWidget() $child,
    Int() $expand is rw,
    Int() $fill is rw,
    Int() $padding is rw,
    Int() $pack_type is rw
  ) {
    self.query_child_packing($child, $expand, $fill, $padding, $pack_type);
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

  multi method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = self.RESOLVE-INT($position);
    gtk_box_reorder_child($!b, $child, $p);
  }

  method set_child_packing (
    GtkWidget() $child,
    Int() $expand,
    Int() $fill,
    Int() $padding,
    Int() $pack_type
  )
    is also<set-child-packing>
  {
    my @b = ($expand, $fill);
    my @ui = ($padding, $pack_type);
    my ($e, $f) = self.RESOLVE-BOOL(@b);
    my ($p, $pt) = self.RESOLVE-UINT(@ui);
    gtk_box_set_child_packing($!b, $child, $e, $f, $p, $pt);
  }

}
