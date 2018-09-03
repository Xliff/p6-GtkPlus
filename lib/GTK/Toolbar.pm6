use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Toolbar;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Toolbar is GTK::Container {
  has GtkToolbar $!tb;

  submethod BUILD(:$toolbar) {
    given $toolbar {
      when GtkToolbar | GtkWidget {
        $!tb = do {
          when GtkWidget { nativecast(Gtk , $toolbar); }
          when GtkToolbar{ $toolbar; }
        }
        self.setContainer($toolbar);
      }
      when GTK::Toolbar {
      }
      default {
      }
    }
    self.setType('GTK::Toolbar');
  }

  method new {
    my $toolbar = gtk_toolbar_new();
    self.bless(:$toolbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  
  # Is originally:
  # GtkToolbar, gboolean, gpointer --> gboolean
  method focus-home-or-end {
    self.connect($!tb, 'focus-home-or-end');
  }

  # Is originally:
  # GtkToolbar, GtkOrientation, gpointer --> void
  method orientation-changed {
    self.connect($!tb, 'orientation-changed');
  }

  # Is originally:
  # GtkToolbar, gint, gint, gint, gpointer --> gboolean
  method popup-context-menu {
    self.connect($!tb, 'popup-context-menu');
  }

  # Is originally:
  # GtkToolbar, GtkToolbarStyle, gpointer --> void
  method style-changed {
    self.connect($!tb, 'style-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method show_arrow is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_toolbar_get_show_arrow($!tb);
      },
      STORE => sub ($, Int() $show_arrow is copy) {
        my gboolean $sa = $show_arrow == 0 ?? 0 !! 1;
        gtk_toolbar_set_show_arrow($!tb, $show_arrow);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_drop_index (Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y) >>+&<< (0xffff xx 2);
    gtk_toolbar_get_drop_index($!tb, $xx, $yy);
  }

  method get_icon_size {
    gtk_toolbar_get_icon_size($!tb);
  }

  multi method get_item_index (GtkToolItem $item) {
    gtk_toolbar_get_item_index($!tb, $item);
  }
  multi method get_item_index (Gtk::ToolItem $item)  {
    samewith($item.toolitem);
  }

  method get_n_items {
    gtk_toolbar_get_n_items($!tb);
  }

  method get_nth_item (Int() $n) {
    my gint $nn = $n +& 0xffff;
    gtk_toolbar_get_nth_item($!tb, $nn);
  }

  method get_relief_style {
    gtk_toolbar_get_relief_style($!tb);
  }

  method get_style {
    gtk_toolbar_get_style($!tb);
  }

  method get_type {
    gtk_toolbar_get_type();
  }

  multi method insert (GtkToolItem $item, Int() $pos) {
    my uint32 $p = $pos +& 0xffff;
    gtk_toolbar_insert($!tb, $item, $p);
  }
  multi method insert (Gtk::ToolItem $item, Int() $pos)  {
    my uint32 $p = $pos +& 0xffff;
    samewith($item.toolitem, $p);
  }

  multi method set_drop_highlight_item (GtkToolItem $tool_item, Int() $index) {
    my uint32 $i = $index +& 0xffff;
    gtk_toolbar_set_drop_highlight_item($!tb, $tool_item, $i);
  }
  multi method set_drop_highlight_item (Gtk::ToolItem $tool_item, Int() $index)  {
    my uint32 $i = $index +& 0xffff;
    samewith($tool_item.toolitem, $i);
  }

  method unset_icon_size {
    gtk_toolbar_unset_icon_size($!tb);
  }

  method unset_style {
    gtk_toolbar_unset_style($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
