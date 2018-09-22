use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckMenuItem;
use GTK::Raw::Types;

use GTK::MenuItem;

class GTK::CheckMenuItem is GTK::MenuItem {
  has GtkCheckMenuItem $!cmi;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::CheckMenuItem');
    $o;
  }

  submethod BUILD(:$checkmenuitem) {
    my $to-parent;
    given $checkmenuitem {
      when GtkCheckMenuItem | GtkWidget {
        self.setCheckMenuItem($checkmenuitem);
      }
      when GTK::CheckMenuItem {
      }
      default {
      }
    }
  }

  method setCheckMenuItem($checkmenuitem) {
    $!cmi = do given $checkmenuitem {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkMenuItem, $_);
      }
      when GtkCheckMenuItem {
        $to-parent = nativecast(MenuItem, $_);
        $_;
      }
    }
    self.setMenuItem($to-parent);
  }

  method new {
    my $checkmenuitem = gtk_check_menu_item_new();
    self.bless(:$checkmenuitem);
  }

  method new(Str() :$label, Str() :$mnemonic) {
    die "Use ONE of \$label or \$mnemonic when using { ::?CLASS }.new()"
      unless $label.defined ^^ $nmemonic.defined;

    my $checkmenuitem = do {
      with $label    { gtk_check_menu_item_new_with_label($_);    }
      with $mnemonic { gtk_check_menu_item_new_with_mnemonic($_); }
    };
    self.bless(:$checkmenuitem);
  }

  method new_with_label {
    my $checkmenuitem = gtk_check_menu_item_new_with_label($!cmi);
    self.bless(:$checkmenuitem);
  }

  method new_with_mnemonic {
    my $checkmenuitem = gtk_check_menu_item_new_with_mnemonic($!cmi);
    self.bless(:$checkmenuitem);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCheckMenuItem, gpointer --> void
  method toggled {
    self.connect($!cmi, 'toggled');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_check_menu_item_get_active($!cmi) );
      },
      STORE => sub ($, Int() $is_active is copy) {
        my $ia = $is_active == 0 ?? 0 !! 1;
        gtk_check_menu_item_set_active($!cmi, $ia);
      }
    );
  }

  method draw_as_radio is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_check_menu_item_get_draw_as_radio($!cmi) );
      },
      STORE => sub ($, Int() $draw_as_radio is copy) {
        my $dar = $draw_as_radio == 0 ?? 0 !! 1;
        gtk_check_menu_item_set_draw_as_radio($!cmi, $dar);
      }
    );
  }

  method inconsistent is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_check_menu_item_get_inconsistent($!cmi) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my $s = $setting == 0 ?? 0 !! 1
        gtk_check_menu_item_set_inconsistent($!cmi, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_check_menu_item_get_type();
  }

  # Alias to emit_toggled for C-ppl
  method emit-toggled {
    gtk_check_menu_item_toggled($!cmi);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
