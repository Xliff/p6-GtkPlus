use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Box;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::Roles::Orientable;

use GTK::Container;

our subset BoxAncestry is export
  where GtkBox | GtkOrientable | ContainerAncestry;

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
      when BoxAncestry {
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

  method GTK::Raw::Types::GtkBox is also<Box> { $!b }

  method setBox($box) {
    self.IS-PROTECTED;

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
      when ContainerAncestry {
        $to-parent = $_;
        nativecast(GtkBox, $_);
      }
    }
    self.setContainer($to-parent);
    $!or //= nativecast(GtkOrientable, $!b);    # For GTK::Roles::Orientable
  }

  multi method new (BoxAncestry $box) {
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
    my guint $o = resolve-uint($orientation);
    my gint $s = resolve-int($spacing);
    my $box = gtk_box_new($o, $s);
    self.bless(:$box);
  }

  method new-hbox(Int $spacing = 0) is also<new_hbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, $s);
    self.bless(:$box);
  }

  method new-vbox(Int $spacing = 0) is also<new_vbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_VERTICAL, $s);
    self.bless(:$box);
  }

  method baseline_position is rw is also<baseline-position> {
    Proxy.new(
      FETCH => sub ($) {
        GtkBaselinePosition( gtk_box_get_baseline_position($!b) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = resolve-uint($position);
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
        my gboolean $h = resolve-bool($homogeneous);
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
        my gint $s = resolve-int($spacing);
        gtk_box_set_spacing($!b, $s);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_box_get_type, $n, $t );
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
    my ($e, $f, $p) = resolve-uint(@u);
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
    samewith($child.Widget, $expand, $fill, $padding);
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
    my uint32 ($e, $f, $p) = resolve-uint(@u);
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
    samewith($child.Widget, $expand, $fill, $padding);
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
    my gboolean ($e, $f) = resolve-bool(@b);
    my guint ($p, $pt) = resolve-uint(@ui);
    my $rc = gtk_box_query_child_packing($!b, $child, $e, $f, $p, $pt);
    ($expand, $fill, $padding, $pack_type) = ($e, $f, $p, $pt);
    $rc;
  }

  multi method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = resolve-int($position);
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
    my ($e, $f) = resolve-bool(@b);
    my ($p, $pt) = resolve-uint(@ui);
    gtk_box_set_child_packing($!b, $child, $e, $f, $p, $pt);
  }

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'expand'    |
             'fill'      |
             'pack-type' |
             'padding'   { self.child-set-uint($c, $p, $v) }

        when 'position'  { self.child-set-int($c, $p, $v)  }

        default          { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }

}
