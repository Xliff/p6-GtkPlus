use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::Raw::MenuModel;

class GIO::MenuLinkIter {
  has GMenuLinkIter $!mli is implementor;

  submethod BUILD (:$iter) {
    $!mli = $iter;
  }

  method new (GMenuLinkIter $iter) {
    self.bless(:$iter);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_menu_link_iter_get_type, $n, $t );
  }

  method next {
    g_menu_link_iter_next($!mli);
  }

  method name {
    g_menu_link_iter_get_name($!mli);
  }

  method value (:$raw = False) {
    my $mm = g_menu_link_iter_get_value($!mli);

    $mm ??
      ( $raw ?? $mm !! ::('GIO::MenuModel').new($mm) )
      !!
      Nil;
  }
}
