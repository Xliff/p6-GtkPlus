use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuItem;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::MenuItem is GTK::Bin {
  has GtkMenuItem $!mi;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuItem');
    $o;
  }

  submethod BUILD(:$menuitem) {
    given $menuitem {
      when GtkMenuItem | GtkWidget {
        self.setMenuItem($menuitem);
      }
      when GTK::MenuItem {
      }
      default {
      }
    }
  }

  method setMenuItem($menuitem) {
    my $to-parent;
    $!mi = do given $checkmenuitem {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkMenuItem, $_);
      }
      when GtkMenuItem {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
    }
    self.setBin($to-parent);
  }

  multi method new {
    my $menuitem = gtk_menu_item_new();
    self.bless(:$menuitem);
  }
  multi method new (GtkWidget $menuitem) {
    self.bless(:$menuitem);
  }
  multi method new(Str() :$label, Str() :$mnemonic) {
    die "Use ONE of \$label or \$mnemonic when using { ::?CLASS.name }.new()"
      unless $label.defined ^^ $nmemonic.defined;

    my $menuitem = do {
      with $label    { gtk_menu_item_new_with_label($_);    }
      with $mnemonic { gtk_menu_item_new_with_mnemonic($_); }
    };
    self.bless(:$menuitem);
  }

  method new_with_label (Str() $label) {
    my $menuitem = gtk_menu_item_new_with_label($label);
    self.bless(:$menuitem);
  }

  method new_with_mnemonic (Str() $label) {
    my $menuitem = gtk_menu_item_new_with_mnemonic($label);
    self.bless(:$menuitem);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method activate {
    self.connect($!mi, 'activate');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method activate-item {
    self.connect($!mi, 'activate-item');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method deselect {
    self.connect($!mi, 'deselect');
  }

  # Is originally:
  # GtkMenuItem, gpointer --> void
  method select {
    self.connect($!mi, 'select');
  }

  # Is originally:
  # GtkMenuItem, gint, gpointer --> void
  method toggle-size-allocate {
    self.connect($!mi, 'toggle-size-allocate');
  }

  # Is originally:
  # GtkMenuItem, gpointer, gpointer --> void
  method toggle-size-request {
    self.connect($!mi, 'toggle-size-request');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accel_path is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_item_get_accel_path($!mi);
      },
      STORE => sub ($, Str() $accel_path is copy) {
        gtk_menu_item_set_accel_path($!mi, $accel_path);
      }
    );
  }

  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_item_get_label($!mi);
      },
      STORE => sub ($, Str() $label is copy) {
        gtk_menu_item_set_label($!mi, $label);
      }
    );
  }

  method reserve_indicator is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_item_get_reserve_indicator($!mi);
      },
      STORE => sub ($, Int() $reserve is copy) {
        my $r = self.RESOLVE-BOOL($reserve);
        gtk_menu_item_set_reserve_indicator($!mi, $r);
      }
    );
  }

  # Deprecated and not useful, IMHO. See:
  # https://developer.gnome.org/gtk3/stable/GtkMenuItem.html#gtk-menu-item-set-right-justified
  #
  # method right_justified is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_menu_item_get_right_justified($!mi);
  #     },
  #     STORE => sub ($, $right_justified is copy) {
  #       gtk_menu_item_set_right_justified($!mi, $right_justified);
  #     }
  #   );
  # }

  method submenu is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_menu_item_get_submenu($!mi);
      },
      STORE => sub ($, GtkWidget() $submenu is copy) {
        gtk_menu_item_set_submenu($!mi, $submenu);
      }
    );
  }

  method use_underline is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_menu_item_get_use_underline($!mi);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_menu_item_set_use_underline($!mi, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate {
    gtk_menu_item_activate($!mi);
  }

  method deselect {
    gtk_menu_item_deselect($!mi);
  }

  method get_type {
    gtk_menu_item_get_type();
  }

  method select {
    gtk_menu_item_select($!mi);
  }

  method toggle_size_allocate (Int() $allocation) {
    my gint $a = self.RESOLVE-INT($allocation);
    gtk_menu_item_toggle_size_allocate($!mi, $a);
  }

  method toggle_size_request (Int() $requisition) {
    my gint $r = self.RESOLVE-INT($requisition);
    gtk_menu_item_toggle_size_request($!mi, $r);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
