use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Box;
use GTK::Raw::Types;

use GTK::Container;
use GTK::Widget;

class GTK::Box is GTK::Container {

  # Maybe make Widget a role that has $.w and all variants assign to it,
  # but how to keep $.w from being set from outside the object tree?

  has $!b;

  submethod BUILD(:$box) {
    given $box {
      # I don't think this distinction needs to be made. Must test.
      when GtkWidget | GtkBox {
        $!b = $box;
      }
      when GTK::Box {
        warn "To copy a { ::?CLASS }, use { ::?CLASS }.clone.";
      }
      default {
      }
    }
  }

  multi method new-box (GtkOrientation $orientation, Int $spacing) {
    my $box = gtk_box_new($orientation, $spacing);
    self.bless( :$box, :container($box), :widget($box) );
  }

  multi method new-box (:$box!) {
    self.bless( :$box, :container($box), :widget($box) );
  }

  method new-hbox(Int $spacing = 2) {
    my $box = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, $spacing);
    self.bless( :$box, :container($box), :widget($box) );
  }

  method new-vbox(Int $spacing = 2) {
    my $box = gtk_box_new(GTK_ORIENTATION_VERTICAL, $spacing);
    self.bless( :$box, :container($box), :widget($box) );
  }

  # cw: Just in case I need it in the near future. May want to put it in an
  #     an inactive role, before I ever delete it.
  # method resolveObject($o) {
  #   given $o {
  #     when ::?CLASS {
  #       self.w;
  #     }
  #     when GtkWidget {
  #       $o;
  #     }
  #     default {
  #     }
  #   }
  # }

  method baseline_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_baseline_position($!b);
      },
      STORE => sub ($, $position is copy) {
        gtk_box_set_baseline_position($!b, $position);
      }
    );
  }

  method center_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_center_widget($!b);
      },
      STORE => sub ($, $widget is copy) {
        gtk_box_set_center_widget($!b, $widget);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_homogeneous($!b);
      },
      STORE => sub ($, $homogeneous is copy) {
        gtk_box_set_homogeneous($!b, $homogeneous);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_spacing($!b);
      },
      STORE => sub ($, $spacing is copy) {
        gtk_box_set_spacing($!b, $spacing);
      }
    );
  }

  method get_type {
    gtk_box_get_type();
  }

  multi method pack_end (
    GTK::Widget $child,
    Bool $expand = False,
    Bool $fill   = False,
    Int $padding = 0
  ) {
    my uint32 $e = $expand.Int;
    my uint32 $f = $fill.Int;
    my guint $p = $padding;

    self.unshift-end($child);
    samewith($child.widget, $e, $f, $p);
  }
  multi method pack_end (
    GtkWidget $child,
    gboolean $expand = 0,
    gboolean $fill   = 0,
    guint $padding   = 0
  ) {
    gtk_box_pack_end($!b, $child, $expand, $fill, $padding);
  }

  multi method pack_start (
    GTK::Widget $child,
    Bool $expand = False,
    Bool $fill   = False,
    Int $padding = 0
  ) {
    my uint32 $c = $expand.Int;
    my uint32 $f = $fill.Int;
    my guint $p = $padding;

    self.push-start($child);
    samewith($child.widget, $c, $f, $p);
  }
  multi method pack_start (
    GtkWidget $child,
    uint32 $expand = 0,
    uint32 $fill   = 0,
    guint $padding = 0
  ) {
    gtk_box_pack_start($!b, $child, $expand, $fill, $padding);
  }

  multi method query_child_packing (GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type) {
    gtk_box_query_child_packing($!b, $child, $expand, $fill, $padding, $pack_type);
  }
  multi method query_child_packing (GTK::Widget $child, Bool $expand, Bool $fill, Int $padding, GtkPackType $pack_type) {
    nextwith($child.widget, $expand.Int, $fill.Int, $padding, $pack_type);
  }

  multi method reorder_child (GtkWidget $child, gint $position) {
    gtk_box_reorder_child($!b, $child, $position);
  }
  multi method reorder_child (GTK::Widget $child, Int $position) {
    nextwith($child.widget, $position);
  }

  multi method set_child_packing (GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type) {
    gtk_box_set_child_packing($!b, $child, $expand, $fill, $padding, $pack_type);
  }
  multi method set_child_packing (GTK::Widget $child, Bool $expand, Bool $fill, Int $padding, GtkPackType $pack_type) {
    nextwith($child.widget, $expand, $fill.Int, $padding.Int, $pack_type);
  }

}
