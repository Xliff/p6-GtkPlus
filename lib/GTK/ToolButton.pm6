use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolButton;
use GTK::Raw::Types;

use GTK::ToolItem;

class GTK::ToolButton is GTK::ToolItem {
  has GtkToolButton $!tb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolButton');
    $o;
  }

  submethod BUILD(:$toolbutton) {
    given $toolbutton {
      when GtkToolButton | GtkToolItem | GtkWidget {
        self.setToolButton($toolbutton);
      }
      when GTK::ToolButton {
      }
      default {
      }
    }
  }

  method setToolButton($toolbutton) {
    self.IS-PROTECTED;

    my $to-parent;
    $!tb = do given $toolbutton {
      when GtkToolItem | GtkWidget {
        $to-parent = $toolbutton;
        nativecast(GtkToolButton, $toolbutton);
      }
      when GtkToolButton {
        $to-parent = nativecast(GtkToolItem, $toolbutton);
        $toolbutton;
      }
    }
    self.setToolItem($to-parent);
  }

  multi method new (GtkWidget $toolbutton) {
    self.bless(:$toolbutton);
  }
  multi method new (GtkWidget() $widget, Str() $label) {
    my $toolbutton = gtk_tool_button_new($widget, $label);
    self.bless(:$toolbutton);
  }

  method new_from_stock (gchar $stock_id)
    is DEPRECATED('GTK::ToolButton.new( GTK::Image.new_from_icon_name() )')
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
      STORE => sub ($, GtkWidget() $icon_widget is copy) {
        gtk_tool_button_set_icon_widget($!tb, $icon_widget);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label($!tb);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_tool_button_set_label($!tb, $label);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label_widget($!tb);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_tool_button_set_label_widget($!tb, $label_widget);
      }
    );
  }

  method stock_id is DEPRECATED is rw {
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
        my $uu = self.RESOLVE-BOOL($use_underline);
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
