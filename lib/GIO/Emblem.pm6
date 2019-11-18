use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;
use GIO::Raw::Emblem;

use GTK::Compat::Roles::Object;
use GIO::Roles::Icon;

class GIO::Emblem {
  also does GTK::Compat::Roles::Object;

  has GEmblem $!e is implementor;

  submethod BUILD (:$emblem) {
    $!e = $emblem;

    self.roleInit-Object;
  }

  multi method GTK::Compat::Types::GEmblem
    is also<GEmblem>
  { $!e }

  multi method new (GEmblem $emblem) {
    self.bless( :$emblem );
  }
  multi method new (GIcon() $icon) {
    self.bless( emblem => g_emblem_new($icon) );
  }

  multi method new_with_origin (GIcon() $icon, Int() $origin)
    is also<new-with-origin>
  {
    my GEmblemOrigin $o = $origin;

    self.bless( emblem => g_emblem_new_with_origin($icon, $o) );
  }

  method get_icon (:$raw = False)
    is also<
      get-icon
      icon
      gicon
    >
  {
    my $i = g_emblem_get_icon($!e);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil
  }

  method get_origin
    is also<
      get-origin
      origin
    >
  {
    GEmblemOriginEnum( g_emblem_get_origin($!e) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_emblem_get_type, $n, $t );
  }

}
