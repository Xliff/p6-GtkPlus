use v6.c;

use GTK::Compat::Types;
use GTK::Compat::Raw::MenuModel;

class GTK::Compat::MenuAttributeIter {
  has GMenuAttributeIter $!mai is implementor;

  submethod BUILD(:$iter) {
    $!mai = $iter;
  }

  method new (GMenuAttributeIter $iter) {
    self.bless(:$iter);
  }

  method next {
    g_menu_attribute_iter_next($!mai);
  }

  method name {
    g_menu_attribute_iter_get_name($!mai);
  }

  method value {
    g_menu_attribute_iter_get_value($!mai);
  }

}
