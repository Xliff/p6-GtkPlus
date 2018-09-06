use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Overlay;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Overlay is GTK::Bin {
  has GtkOverlay $!o;

  submethod BUILD(:$overlay) {
    my $to-parent;
    given $overlay {
      when Gtk | GtkWidget {
        $!o = do {
          when GtkWidget {
            $to-parent = $_
            nativecast(GtkOverlay, $_);
          }
          when GtkOverlay  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK:: {
      }
      default {
      }
    }
    self.setType('GTK::Overlay');
  }

  method new {
    my $overlay = gtk_overlay_new();
    self.bless(:$overlay);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  
  # Is originally:
  # GtkOverlay, GtkWidget, GdkRectangle, gpointer --> gboolean
  method get-child-position {
    self.connect($!o, 'get-child-position');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_overlay (GtkWidget $widget) {
    gtk_overlay_add_overlay($!o, $widget);
  }
  multi method add_overlay (GTK::Widget $widget)  {
    samewith($widget.widget);
  }

  multi method get_overlay_pass_through (GtkWidget $widget) {
    gtk_overlay_get_overlay_pass_through($!o, $widget);
  }
  multi method get_overlay_pass_through (GTK::Widget $widget)  {
    samewith($widget.widget);
  }

  method get_type {
    gtk_overlay_get_type();
  }

  multi method reorder_overlay (GtkWidget $child, Int() $position) {
    my gint $p = ($position.abs +& 0x7fff) * ($position < 0 ?? -1 !! 1);
    gtk_overlay_reorder_overlay($!o, $child, $position);
  }
  multi method reorder_overlay (GTK::Widget $child, Int() $position)  {
    samewith($child.widget, $position);
  }

  multi method set_overlay_pass_through (
    GtkWidget $widget,
    Int() $pass_through
  ) {
    my $pt = $pass_through == 0 ?? 0 !! 1
    gtk_overlay_set_overlay_pass_through($!o, $widget, $pt);
  }
  multi method set_overlay_pass_through (
    GTK::Widget $widget,
    Int() $pass_through
  )  {
    samewith($widget.widget, $pass_through);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
