use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::SeparatorMenuItem;

use GTK::MenuItem;

my subset Ancestry where GtkSeparatorMenuItem | GtkMenuItem  | GtkActionable |
                         GtkContainer         | GtkBuildable | GtkWidget;

class GTK::SeparatorMenuItem is GTK::MenuItem {
  has GtkSeparatorMenuItem $!smi;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::SeparatorMenuItem');
    $o;
  }

  submethod BUILD(:$separator) {
    my $to-parent;
    given $separator {
      when Ancestry {
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

  multi method new (Ancestry $separator) {
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
    gtk_separator_menu_item_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
