use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::SeparatorMenuItem;

use GTK::MenuItem;

class GTK::SeparatorMenuItem is GTK::MenuItem {
  has GtkSeparatorMenuItem $!smi;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::SeparatorMenuItem');
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when GtkSeparatorMenuItem | GtkWidget {
        $!smi = do {
          when GtkWidget {
            $to-parent = $_;
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
  }

  multi method new {
    my $separator = gtk_separator_menu_item_new();
    self.bless(:$separator);
  }
  multi method new (GtkWidget $separator) {
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
