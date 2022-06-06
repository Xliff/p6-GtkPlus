use v6.c;

use Method::Also;

use GTK::Raw::MenuButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Widget:ver<3.0.1146>;

use GIO::MenuModel;
use GTK::Container:ver<3.0.1146>;
use GTK::Menu:ver<3.0.1146>;
use GTK::Popover:ver<3.0.1146>;
use GTK::ToggleButton:ver<3.0.1146>;

our subset GtkMenuButtonAncestry is export of Mu
  where GtkMenuButton | ToggleButtonAncestry;

constant MenuButtonAncestry is export = GtkMenuButtonAncestry;

class GTK::MenuButton:ver<3.0.1146> is GTK::ToggleButton {
  has GtkMenuButton $!mb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD ( :$menubutton ) {
    self.setGtkMenuButton($menubutton) if $menubutton;
  }

  method setGtkMenuButton (GtkMenuButtonAncestry $_) {
    my $to-parent;

    $!mb = do {
      when GtkMenuButton {
        $to-parent = cast(GtkToggleButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMenuButton, $_);
      }
    };
    self.setToggleButton($to-parent);
  }

  method GTK::Raw::Definitions::GtkMenuButton
    is also<GtkMenuButton>
  { $!mb }

  multi method new (GtkMenuButtonAncestry $menubutton, :$ref = True) {
    return Nil unless $menubutton;

    my $o = self.bless(:$menubutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $menubutton = gtk_menu_button_new();

    $menubutton ?? self.bless( :$menubutton ) !! Nil;
  }

  # Exposed from GTK::ToggleButton
  method new_with_label (Str() $label) is also<new-with-label> {
    my $menubutton = callwith($label);

    $menubutton ?? self.bless(:$menubutton) !! Nil;
  }

  method new_with_mnemonic (Str() $label) is also<new-with-mnemonic> {
    my $menubutton = callwith($label);

    $menubutton ?? self.bless(:$menubutton) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method align_widget (:$raw = False) is rw is also<align-widget> {
    Proxy.new(
      FETCH => sub ($) {
        my $c = gtk_menu_button_get_align_widget($!mb);

        $c ??
          ( $raw ?? $c !! GTK::Container.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, GtkContainer() $align_widget is copy) {
        gtk_menu_button_set_align_widget($!mb, $align_widget);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkArrowTypeEnum( gtk_menu_button_get_direction($!mb) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my GtkArrowType $d = $direction;

        gtk_menu_button_set_direction($!mb, $d);
      }
    );
  }

  method menu_model (:$raw = False) is rw is also<menu-model> {
    # GtkMenuModel (really is GMenuModel)
    Proxy.new(
      FETCH => sub ($) {
        my $mm = gtk_menu_button_get_menu_model($!mb);

        $mm ??
          ( $raw ?? $mm !! GIO::MenuModel.new($mm) )
          !!
          Nil;
      },
      STORE => sub ($, GMenuModel() $menu_model is copy) {
        gtk_menu_button_set_menu_model($!mb, $menu_model);
      }
    );
  }

  method popover (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $po = gtk_menu_button_get_popover($!mb);

        $po ??
          ( $raw ?? $po !! GTK::Popover.new($po) )
          !!
          Nil;
      },
      STORE => sub ($, GtkPopover() $popover is copy) {
        gtk_menu_button_set_popover($!mb, $popover);
      }
    );
  }

  method popup (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $m = gtk_menu_button_get_popup($!mb);

        $m ??
          ( $raw ?? $m !! GTK::Menu.new($m) )
          !!
          Nil;
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
        my gboolean $up = $use_popover.so.Int;

        gtk_menu_button_set_use_popover($!mb, $up);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
