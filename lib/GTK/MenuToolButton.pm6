use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuToolButton;
use GTK::Raw::Types;

use GTK::ToolButton;

class GTK::MenuToolButton is GTK::ToolButton {
  has GtkMenuToolButton $!mtb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuToolButton');
    $o;
  }

  submethod BUILD(:$menutoolbutton) {
    my $to-parent;
    given $menutoolbutton {
      when GtkMenuToolButton | GtkToolItem | GtkWidget {
        $!mtb = do {
          when GtkWidget | GtkToolItem {
            $to-parent = $_;
            nativecast(GtkMenuToolButton, $_);
          }
          when GtkMenuToolButton {
            $to-parent = nativecast(GtkToolButton, $_);
            $_
          }
        }
        self.setToolButton($to-parent);
      }
      when GTK::MenuToolButton {
      }
      default {
      }
    }
  }

  multi method new (GtkWidget $menutoolbutton) {
    self.bless(:$menutoolbutton);
  }
  multi method new (GtkWidget $widget, gchar $label) {
    my $menutoolbutton = gtk_menu_tool_button_new($widget, $label);
    self.bless(:$menutoolbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuToolButton, gpointer --> void
  method show-menu {
    self.connect($!mtb, 'show-menu');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method menu is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_tool_button_get_menu($!mtb);
      },
      STORE => sub ($, GtkWidget() $menu is copy) {
        gtk_menu_tool_button_set_menu($!mtb, $menu);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_menu_tool_button_get_type();
  }

  method set_arrow_tooltip_markup (gchar $markup) {
    gtk_menu_tool_button_set_arrow_tooltip_markup($!mtb, $markup);
  }

  method set_arrow_tooltip_text (gchar $text) {
    gtk_menu_tool_button_set_arrow_tooltip_text($!mtb, $text);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
