use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::SeparatorMenuItem:ver<3.0.1146>;

use GTK::MenuItem:ver<3.0.1146>;

our subset GtkSeparatorMenuItemAncestry
  where GtkSeparatorMenuItem | GtkMenuItemAncestry;

class GTK::SeparatorMenuItem:ver<3.0.1146> is GTK::MenuItem {
  has GtkSeparatorMenuItem $!smi is implementor;

  submethod BUILD( :$separator ) {
    self.setGtkSeparatorMenuItem($separator) if $separator;
  }

  method setGtkSeparatorMenuItem (GtkSeparatorMenuItemAncestry $_) {
    my $to-parent;

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
    self.setGtkMenuItem($to-parent);
  }

  multi method new (GtkSeparatorMenuItemAncestry $separator, :$ref = True) {
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
