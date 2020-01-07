use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Types;
use GTK::Raw::SeparatorMenuItem;

use GTK::MenuItem;

our subset SeparatorMenuItemAncestry 
  where GtkSeparatorMenuItem | MenuItemAncestry;

class GTK::SeparatorMenuItem is GTK::MenuItem {
  has GtkSeparatorMenuItem $!smi is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when SeparatorMenuItemAncestry {
        $!smi = do {
          when GtkSeparatorMenuItem {
            $to-parent = nativecast(GtkMenuItem, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSeparatorMenuItem, $_);
          }
        }
        self.setMenuItem($to-parent);
      }
      when GTK::SeparatorMenuItem {
      }
      default {
      }
    }
  }

  multi method new (SeparatorMenuItemAncestry $separator) {
    my $o = self.bless(:$separator);
    $o.upref;
    $o;
  }
  multi method new {
    my $separator = gtk_separator_menu_item_new();
    self.bless(:$separator);
  }
  multi method new (
    Str() $label,
    *%dummy_opts
  ) {
    my $separator = gtk_separator_menu_item_new();
    self.bless(:$separator);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_separator_menu_item_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
