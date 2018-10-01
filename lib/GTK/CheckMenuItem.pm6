use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CheckMenuItem;
use GTK::Raw::Types;

use GTK::MenuItem;

class GTK::CheckMenuItem is GTK::MenuItem {
  has GtkCheckMenuItem $!cmi;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
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
    my $to-parent;
    $!cmi = do given $checkmenuitem {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkCheckMenuItem, $_);
      }
      when GtkCheckMenuItem {
        $to-parent = nativecast(GtkMenuItem, $_);
        $_;
      }
    }
    self.setMenuItem($to-parent);
  }

  multi method new {
    my $checkmenuitem = gtk_check_menu_item_new();
    self.bless(:$checkmenuitem);
  }
  multi method new (GtkWidget $checkmenuitem) {
    self.bless(:$checkmenuitem);
  }
  multi method new(Str() :$label, Str() :$mnemonic) {
    die "Use ONE of \$label or \$mnemonic when using { ::?CLASS.^name }.new()"
      unless $label.defined ^^ $mnemonic.defined;

    my $checkmenuitem = do {
      with $label    { gtk_check_menu_item_new_with_label($_);    }
      with $mnemonic { gtk_check_menu_item_new_with_mnemonic($_); }
    };
    self.bless(:$checkmenuitem);
  }

  method new_with_label(Str $label) {
    my $checkmenuitem = gtk_check_menu_item_new_with_label($label);
    self.bless(:$checkmenuitem);
  }

  method new_with_mnemonic(Str $label) {
    my $checkmenuitem = gtk_check_menu_item_new_with_mnemonic($label);
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
        so gtk_check_menu_item_get_active($!cmi);
      },
      STORE => sub ($, Int() $is_active is copy) {
        my $ia = self.RESOLVE-BOOL($is_active);
        gtk_check_menu_item_set_active($!cmi, $ia);
      }
    );
  }

  method draw_as_radio is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_check_menu_item_get_draw_as_radio($!cmi);
      },
      STORE => sub ($, Int() $draw_as_radio is copy) {
        my $dar = self.RESOLVE-BOOL($draw_as_radio);
        gtk_check_menu_item_set_draw_as_radio($!cmi, $dar);
      }
    );
  }

  method inconsistent is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_check_menu_item_get_inconsistent($!cmi);
      },
      STORE => sub ($, Int() $setting is copy) {
        my $s = self.RESOLVE-BOOL($setting);
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
