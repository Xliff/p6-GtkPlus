use v6.c;

use GTK::Compat::Types;
use GTK::Compat::Raw::MenuModel;

class GTK::Compat::MenuLinkIter {
  has GMenuLinkIter $!mli;

  submethod BUILD (:$iter) {
    $!mli = $iter;
  }

  method new (GMenuLinkIter $iter) {
    self.bless(:$iter);
  }

  method get_type {
    g_menu_link_iter_get_type();
  }

  method next {
    g_menu_link_iter_next($!mli);
  }

  method name {
    g_menu_link_iter_get_name($!mli);
  }

  method value {
    g_menu_link_iter_get_value($!mli);
  }
}
