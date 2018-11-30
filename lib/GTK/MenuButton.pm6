use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuButton;
use GTK::Raw::Types;
use GTK::Raw::Widget;

use GTK::Container;
use GTK::Menu;
use GTK::Popover;
use GTK::ToggleButton;

my subset Ancestry
  where GtkMenuButton | GtkToggleButton | GtkButton | GtkBin | GtkContainer |
        GtkBuildable  | GtkWidget;

class GTK::MenuButton is GTK::ToggleButton {
  has GtkMenuButton $!mb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuButton');
    $o;
  }

  submethod BUILD(:$menubutton) {
    my $to-parent;
    given $menubutton {
      when Ancestry {
        $!mb = do {
          when GtkMenuButton {
            $to-parent = nativecast(GtkToggleButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkMenuButton, $_);
          }
        };
        self.setToggleButton($to-parent);
      }
      when GTK::MenuButton {
      }
      default {
      }
    }
  }

  multi method new (GtkWidget $menubutton) {
    my $o = self.bless(:$menubutton);
    $o.upref;
    $o;
  }
  multi method new {
    my $menubutton = gtk_menu_button_new();
    self.bless(:$menubutton);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method align_widget is rw is also<align-widget> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Container.new( gtk_menu_button_get_align_widget($!mb) );
      },
      STORE => sub ($, GtkContainer() $align_widget is copy) {
        gtk_menu_button_set_align_widget($!mb, $align_widget);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkArrowType( gtk_menu_button_get_direction($!mb) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = self.RESOLVE-UINT($direction);
        gtk_menu_button_set_direction($!mb, $d);
      }
    );
  }

  method menu_model is rw is also<menu-model> {
    # GtkMenuModel (really is GMenuModel)
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
        GTK::Popover.new( gtk_menu_button_get_popover($!mb) );
      },
      STORE => sub ($, GtkPopover() $popover is copy) {
        gtk_menu_button_set_popover($!mb, $popover);
      }
    );
  }

  method popup is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Menu.new( gtk_menu_button_get_popup($!mb) );
      },
      STORE => sub ($, GtkMenu() $menu is copy) {
        gtk_menu_button_set_popup($!mb, $menu);
      }
    );
  }

  method use_popover is rw is also<use-popover> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_button_get_use_popover($!mb);
      },
      STORE => sub ($, Int() $use_popover is copy) {
        my gboolean $up = self.RESOLVE-BOOL($use_popover);
        gtk_menu_button_set_use_popover($!mb, $up);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_menu_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
