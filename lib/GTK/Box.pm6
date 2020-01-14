use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Box;
use GTK::Raw::Types;

use GTK::Roles::Orientable;

use GTK::Container;

our subset BoxAncestry is export
  where GtkBox | GtkOrientable | ContainerAncestry;

class GTK::Box is GTK::Container {
  also does GTK::Roles::Orientable;

  # Maybe make Widget a role that has $.w and all variants assign to it,
  # but how to keep $.w from being set from outside the object tree?

  has GtkBox $!b is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$box) {
    given $box {
      when BoxAncestry {
        self.setBox($_);
      }
      when GTK::Box {
        my $class = ::?CLASS.^name;
        warn "To copy a { $class }, use { $class }.clone.";
      }
      default {
      }
    }
  }

  method GTK::Raw::Types::GtkBox
    is also<
      GtkBox
      Box
    >
  { $!b }

  method setBox(BoxAncestry $_) {
    my $to-parent;
    $!b = do {
      when GtkBox {
        $to-parent = nativecast(GtkContainer, $_);
        $_;
      }

      when GtkOrientable {
        $!or = $_;                            # For GTK::Roles::Orientable
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

  multi method new (BoxAncestry $box) {
    return unless $box;

    my $o = self.bless( :$box );
    $o.upref;
    $o;
  }
  multi method new (
    # Default orientation established from Glade.
    Int() $orientation = GTK_ORIENTATION_HORIZONTAL,  # GtkOrientation,
    Int() $spacing = 0
  ) {
    # This works because it is NOT the array version.
    my guint $o = $orientation;
    my gint $s = $spacing;
    my $box = gtk_box_new($o, $s);

    $box ?? self.bless( :$box ) !! Nil;
  }

  method new-hbox(Int $spacing = 0) is also<new_hbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, $s);

    $box ?? self.bless( :$box ) !! Nil;
  }

  method new-vbox(Int $spacing = 0) is also<new_vbox> {
    my gint $s = $spacing;
    my $box = gtk_box_new(GTK_ORIENTATION_VERTICAL, $s);

    $box ?? self.bless( :$box ) !! Nil;
  }

  method baseline_position is rw is also<baseline-position> {
    Proxy.new(
      FETCH => sub ($) {
        GtkBaselinePositionEnum( gtk_box_get_baseline_position($!b) );
      },
      STORE => sub ($, Int() $position is copy) {
        my uint32 $p = $position;

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
        my gboolean $h = $homogeneous.so.Int;

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
        my gint $s = $spacing;

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
    my ($e, $f, $p) = ($expand, $fill, $padding);

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
    my uint32 ($e, $f, $p) = ($expand, $fill, $padding);

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

  proto method query_child_packing (|)
    is also<query-child-packing>
  { * }

  multi method query_child_packing (GtkWidget() $child, :$all = True) {
    samewith($child, $, $, $, $, :$all);
  }
  multi method query_child_packing (
    GtkWidget() $child,
    $expand is rw,
    $fill is rw,
    $padding is rw,
    $pack_type is rw,
    :$all = False
  ) {
    my gboolean ($e, $f) = 0 xx 2;
    my guint ($p, $pt) = 0 xx 2;
    my $rc = gtk_box_query_child_packing($!b, $child, $e, $f, $p, $pt);

    ($expand, $fill, $padding, $pack_type) = ($e, $f, $p, $pt);
    $all.not ?? $rc !! ($rc, $expand, $fill, $padding, $pack_type);
  }

  multi method reorder_child (GtkWidget() $child, Int() $position)
    is also<reorder-child>
  {
    my gint $p = $position;
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
    my ($e, $f) = ($expand, $fill).map( *.so.Int );
    my ($p, $pt) = ($padding, $pack_type);

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
