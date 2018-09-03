use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolButton;
use GTK::Raw::Types;

use GTK::ToolItem;

class GTK::ToolButton is GTK::ToolItem {
  has GtkToolButton $!tb;

  submethod BUILD(:$toolbutton) {
    given $toolbutton {
      when GtkToolButton | GtkWidget {
        $!tb = do {
          when GtkWidget     { nativecast(GtkToolButton, $toolbutton); }
          when GtkToolButton { $toolbutton; }
        }
        self.setToolItem($toolbutton);
      }
      when GTK::ToolButton {
      }
      default {
      }
    }
    self.setType('GTK::ToolButton');
  }

  multi method new (GtkWidget $widget, gchar $label) {
    my $toolbutton = gtk_tool_button_new($label);
    self.bless(:$toolbutton);
  }
  multi method new (GTK::Widget $widget, gchar $label) {
    samewith($widget.widget, $label);
  }

  method new_from_stock (gchar $stock_id)
    is deprecated('GTK::ToolButton.new( GTK::Image.new_from_icon_name() )')
  {
    my $toolbutton = gtk_tool_button_new_from_stock($stock_id);
    self.bless(:$toolbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkToolButton, gpointer --> void
  method clicked {
    self.connect($!tb, 'clicked');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_icon_name($!tb);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_tool_button_set_icon_name($!tb, $icon_name);
      }
    );
  }

  method icon_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_icon_widget($!tb);
      },
      STORE => sub ($, $icon_widget is copy) {
        my GtkWidget $iw = do given $icon_widget {
          when GtkWidget   { $icon_widget; }
          when GTK::Widget { $icon_widget.widget; }
          default {
            # Throw exception.
          }
        }
        gtk_tool_button_set_icon_widget($!tb, $iw);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label($!tb);
      },
      STORE => sub ($, $label is copy) {
        gtk_tool_button_set_label($!tb, $label);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label_widget($!tb);
      },
      STORE => sub ($, $label_widget is copy) {
        my GtkWidget $lw = do given $label_widget {
          when GtkWidget   { $label_widget; }
          when GTK::Widget { $label_widget.widget; }
          default {
            # Throw exception.
          }
        }
        gtk_tool_button_set_label_widget($!tb, $lw);
      }
    );
  }

  method stock_id is deprecated is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_stock_id($!tb);
      },
      STORE => sub ($, $stock_id is copy) {
        gtk_tool_button_set_stock_id($!tb, $stock_id);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_use_underline($!tb);
      },
      STORE => sub ($, Int() $use_underline is copy) {
        my $uu = $use_underline == 0 ?? 0 !! 1;
        gtk_tool_button_set_use_underline($!tb, $uu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_tool_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
