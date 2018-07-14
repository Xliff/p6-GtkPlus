use v6.c;

use GTK::Raw::Box;
use GTK::Raw::Types;
use GTK::Container;

class GTK::Box is GTK::Container {
  also does GTK::Roles::Signals;

  has GtkBox $!b;

  submethod BUILD(:$box) {
    $!b = $box;
  }

  method new (GtkOrientation $orientation, gint $spacing){
    my $box = gtk_box_new($orientation, $spacing);
    self.bless(:$box, :container($box), :widget($box));
  }

  method baseline_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_baseline_position($box);
      },
      STORE => -> sub ($, $position is copy) {
        gtk_box_set_baseline_position($box, $position);
      }
    );
  }

  method center_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_center_widget($box);
      },
      STORE => -> sub ($, $widget is copy) {
        gtk_box_set_center_widget($box, $widget);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_homogeneous($box);
      },
      STORE => -> sub ($, $homogeneous is copy) {
        gtk_box_set_homogeneous($box, $homogeneous);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_box_get_spacing($box);
      },
      STORE => -> sub ($, $spacing is copy) {
        gtk_box_set_spacing($box, $spacing);
      }
    );
  }

  #method get_type () {
  #  gtk_box_get_type();
  #}

  method pack_end (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding) {
    gtk_box_pack_end($box, $child, $expand, $fill, $padding);
  }

  method pack_start (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding) {
    gtk_box_pack_start($box, $child, $expand, $fill, $padding);
  }

  method query_child_packing (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type) {
    gtk_box_query_child_packing($box, $child, $expand, $fill, $padding, $pack_type);
  }

  method reorder_child (GtkBox $box, GtkWidget $child, gint $position) {
    gtk_box_reorder_child($box, $child, $position);
  }

  method set_child_packing (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type) {
    gtk_box_set_child_packing($box, $child, $expand, $fill, $padding, $pack_type);
  }

}
