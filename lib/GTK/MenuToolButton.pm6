use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuToolButton;
use GTK::Raw::Types;

use GTK::ToolButton;

class GTK::MenuToolButton is GTK::ToolButton {
  has GtkMenuToolButton $!mtb;

  submethod BUILD(:$menutoolbutton) {
    given $menutoolbutton {
      when GtkMenuToolButton | GtkToolItem | GtkWidget {
        $!mtb = do {
          when GtkWidget | GtkToolItem {
            nativecast(GtkMenuToolButton, $menutoolbutton);
          }
          when GtkMenuToolButton {
            $menutoolbutton
          }
        }
        self.setToolButton($menutoolbutton);
      }
      when GTK::MenuToolButton {
      }
      default {
      }
    }
    self.setType('GTK::MenuToolButton');
  }

  multi method new (GtkWidget $widget, gchar $label) {
    my $menutoolbutton = gtk_menu_tool_button_new($!mtb, $widget, $label);
    self.bless(:$menutoolbutton);
  }
  multi method new (GTK::Widget $widget, gchar $label) {
    samewith($widget.widget, $label);
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
      STORE => sub ($, $menu is copy) {
        my $m = do given $menu {
          when GtkWidget   { $menu }
          when GTK::Widget { $menu.widget; }
          default {
            # Throw exception
            die "Invalid type passed to " ~ ?::CLASS ~ ".menu()";
          }
        }
        gtk_menu_tool_button_set_menu($!mtb, $m);
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
