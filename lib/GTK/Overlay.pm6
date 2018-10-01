use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Overlay;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Overlay is GTK::Bin {
  has GtkOverlay $!o;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Overlay');
    $o;
  }

  submethod BUILD(:$overlay) {
    my $to-parent;
    given $overlay {
      when GtkOverlay | GtkWidget {
        $!o = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkOverlay, $_);
          }
          when GtkOverlay  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Overlay {
      }
      default {
      }
    }
  }

  multi method new {
    my $overlay = gtk_overlay_new();
    self.bless(:$overlay);
  }
  multi method new (GtkWidget $overlay) {
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
  method add_overlay (GtkWidget() $widget) {
    gtk_overlay_add_overlay($!o, $widget);
  }

  method get_overlay_pass_through (GtkWidget() $widget) {
    gtk_overlay_get_overlay_pass_through($!o, $widget);
  }

  method get_type {
    gtk_overlay_get_type();
  }

  method reorder_overlay (GtkWidget() $child, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_overlay_reorder_overlay($!o, $child, $p);
  }

  method set_overlay_pass_through (
    GtkWidget() $widget,
    Int() $pass_through
  ) {
    my gboolean $pt = self.RESOLVE-BOOL($pass_through);
    gtk_overlay_set_overlay_pass_through($!o, $widget, $pt);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
