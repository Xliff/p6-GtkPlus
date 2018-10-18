use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Toolbar;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Toolbar is GTK::Container {
  has GtkToolbar $!tb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Toolbar');
    $o;
  }

  submethod BUILD(:$toolbar) {
    my $to-parent;
    given $toolbar {
      when GtkToolbar | GtkWidget {
        $!tb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkToolbar, $_);
          }
          when GtkToolbar {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        }
        self.setContainer($to-parent);
      }
      when GTK::Toolbar {
      }
      default {
      }
    }
  }

  multi method new {
    my $toolbar = gtk_toolbar_new();
    self.bless(:$toolbar);
  }
  multi method new (GtkWidget $toolbar) {
    self.bless(:$toolbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkToolbar, gboolean, gpointer --> gboolean
  method focus-home-or-end {
    self.connect-uint-rbool($!tb, 'focus-home-or-end');
  }

  # Is originally:
  # GtkToolbar, GtkOrientation, gpointer --> void
  method orientation-changed {
    self.connect-uint($!tb, 'orientation-changed');
  }

  # Is originally:
  # GtkToolbar, gint, gint, gint, gpointer --> gboolean
  method popup-context-menu {
    self.connect-context-menu($!tb);
  }

  # Is originally:
  # GtkToolbar, GtkToolbarStyle, gpointer --> void
  method style-changed {
    self.connect-uint($!tb, 'style-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method show_arrow is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toolbar_get_show_arrow($!tb);
      },
      STORE => sub ($, Int() $show_arrow is copy) {
        my gboolean $sa = self.RESOLVE-BOOL($show_arrow);
        gtk_toolbar_set_show_arrow($!tb, $show_arrow);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_drop_index (Int() $x is rw, Int $y is rw) {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-UINT(@u);
    my $rc = gtk_toolbar_get_drop_index($!tb, $xx, $yy);
    ($x, $y) = ($xx, $yy);
    $rc;
  }
  # Add a no-arg multi

  method get_icon_size {
    GtkIconSize( gtk_toolbar_get_icon_size($!tb) );
  }

  multi method get_item_index (GtkToolItem() $item) {
    gtk_toolbar_get_item_index($!tb, $item);
  }

  method get_n_items {
    gtk_toolbar_get_n_items($!tb);
  }

  method get_nth_item (Int $n) {
    my gint $nn = self.RESOLVE-INT($n);
    gtk_toolbar_get_nth_item($!tb, $nn);
  }

  method get_relief_style {
    GtkReliefStyle( gtk_toolbar_get_relief_style($!tb) );
  }

  method get_style {
    GtkToolbarStyle( gtk_toolbar_get_style($!tb) );
  }

  method get_type {
    gtk_toolbar_get_type();
  }

  method insert (GtkToolItem() $item, Int $pos = -1) {
    my uint32 $p = self.RESOLVE-UINT($pos);
    gtk_toolbar_insert($!tb, $item, $p);
  }

  method set_drop_highlight_item (GtkToolItem() $tool_item, Int $index) {
    my uint32 $i = self.RESOLVE-UINT($index);
    gtk_toolbar_set_drop_highlight_item($!tb, $tool_item, $i);
  }

  method unset_icon_size {
    gtk_toolbar_unset_icon_size($!tb);
  }

  method unset_style {
    gtk_toolbar_unset_style($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
