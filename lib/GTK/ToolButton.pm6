use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ToolButton;
use GTK::Raw::Types;

use GTK::ToolItem;

use GTK::Roles::Actionable;

my subset Ancestry
  where GtkToolButton | GtkToolItem | GtkActionable | GtkBuildable |
        GtkWidget;

class GTK::ToolButton is GTK::ToolItem {
  also does GTK::Roles::Actionable;

  has GtkToolButton $!tb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ToolButton');
    $o;
  }

  submethod BUILD(:$toolbutton) {
    given $toolbutton {
      when Ancestry {
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
      when GtkToolItem | GtkBuildable | GtkWidget {
        $to-parent = $toolbutton;
        nativecast(GtkToolButton, $toolbutton);
      }
      when GtkActionable {
        $!action = $_;
        $to-parent = nativecast(GtkToolItem, $toolbutton);
        nativecast(GtkToolButton, $toolbutton);
      }
      when GtkToolButton {
        $to-parent = nativecast(GtkToolItem, $toolbutton);
        $toolbutton;
      }
    }
    self.setToolItem($to-parent);
    $!action //= nativecast(GtkActionable, $!tb);   GTK::Roles::Actionable
  }

  multi method new {
    my $toolbutton = gtk_tool_button_new(GtkWidget, Str);
    self.bless(:$toolbutton);
  }
  multi method new (Ancestry $toolbutton) {
    self.bless(:$toolbutton);
  }
  multi method new (GtkWidget() $widget, Str() $label) {
    my $toolbutton = gtk_tool_button_new($widget, $label);
    self.bless(:$toolbutton);
  }

  method new_from_stock (gchar $stock_id)
    is DEPRECATED('GTK::ToolButton.new( GTK::Image.new_from_icon_name() )')
  is also<new-from-stock> {
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
  method icon_name is rw is also<icon-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_icon_name($!tb);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_tool_button_set_icon_name($!tb, $icon_name);
      }
    );
  }

  method icon_widget is rw is also<icon-widget> {
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

  method label_widget is rw is also<label-widget> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_label_widget($!tb);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_tool_button_set_label_widget($!tb, $label_widget);
      }
    );
  }

  method stock_id is DEPRECATED is rw is also<stock-id> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_tool_button_get_stock_id($!tb);
      },
      STORE => sub ($, $stock_id is copy) {
        gtk_tool_button_set_stock_id($!tb, $stock_id);
      }
    );
  }

  method use_underline is rw is also<use-underline> {
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
  method get_type is also<get-type> {
    gtk_tool_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
