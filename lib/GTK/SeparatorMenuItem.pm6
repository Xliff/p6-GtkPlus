use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::;
use GTK::Raw::Types;

use GTK::MenuItem;

class GTK::SeparatorMenuItem is GTK::MenuItem {
  has GtkSeparatorMenuItem $!smi;

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when GtkSeparatorMenuItem | GtkWidget {
        $!smi = do {
          when GtkWidget {
            $to-parent = $_
            nativecast(GtkSeparatorMenuItem, $_);
          }
          when GtkSeparatorMenuItem {
            $to-parent = nativecast(GtkMenuItem, $_);
            $_;
          }
        }
        self.setMenuItem($to-parent);
      }
      when GTK::SeparatorMenuItem {
      }
      default {
      }
    }
    self.setType('GTK::SeparatorMenuItem');
  }

  method new {
    my $separator = gtk_separator_menu_item_new($!smi);
    self.bless(:$separator);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_separator_menu_item_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
