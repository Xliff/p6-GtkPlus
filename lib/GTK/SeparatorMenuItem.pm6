use v6.c;

use Method::Also;

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
            $to-parent = cast(GtkMenuItem, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkSeparatorMenuItem, $_);
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

  multi method new (SeparatorMenuItemAncestry $separator, :$ref = True) {
    return Nil unless $separator;

    my $o = self.bless(:$separator);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $separator = gtk_separator_menu_item_new();

    $separator ?? self.bless(:$separator) !! Nil;
  }
  multi method new (
    Str() $label, 
    # For compatibility with GTK::Utils::MenuBuilder
    *%dummy_opts
  ) {
    my $separator = gtk_separator_menu_item_new();

    $separator ?? self.bless(:$separator) !! Nil;
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
