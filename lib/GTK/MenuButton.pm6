use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuButton;
use GTK::Raw::Types;

use GTK::ToggleButton;

class GTK::MenuButton is GTK::ToggleButton {
  has GtkMenuButton $!mb;

  submethod BUILD(:$menubutton) {
    given $button {
      when GtkMenuButton | GtkWidget {
        $!mb = do {
          when GtkWidget     { nativecast(GtkMenuButton, $menubutton); }
          when GtkMenuButton { $menubutton; }
        };
        self.setToggleButton($menubutton);
      }
      when GTK::CheckButton {
      }
      default {
      }
    }
    self.setType('GTK::MenuButton');
  }

  method new {
    my $menubutton = gtk_menu_button_new();
    self.bless(:$menubutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method align_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_align_widget($!mb);
      },
      STORE => sub ($, $align_widget is copy) {
        gtk_menu_button_set_align_widget($!mb, $align_widget);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_direction($!mb);
      },
      STORE => sub ($, $direction is copy) {
        gtk_menu_button_set_direction($!mb, $direction);
      }
    );
  }

  method menu_model is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_menu_model($!mb);
      },
      STORE => sub ($, $menu_model is copy) {
        gtk_menu_button_set_menu_model($!mb, $menu_model);
      }
    );
  }

  method popover is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_popover($!mb);
      },
      STORE => sub ($, $popover is copy) {
        gtk_menu_button_set_popover($!mb, $popover);
      }
    );
  }

  method popup is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_popup($!mb);
      },
      STORE => sub ($, $menu is copy) {
        gtk_menu_button_set_popup($!mb, $menu);
      }
    );
  }

  method use_popover is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_button_get_use_popover($!mb);
      },
      STORE => sub ($, $use_popover is copy) {
        gtk_menu_button_set_use_popover($!mb, $use_popover);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_menu_button_get_type(;
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
