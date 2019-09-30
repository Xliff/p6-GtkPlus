use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::EmblemedIcon;

use GIO::Emblem;

use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::ListData;
use GIO::Roles::Icon;

class GIO::EmblemedIcon {
  also does GTK::Compat::Roles::Object;

  has GEmblemedIcon $!ei;

  submethod BUILD (:$emblem) {
    $!ei = $emblem;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GEmblemedIcon
    is also<GEmblemedIcon>
  { $!ei }

  multi method new (GEmblemedIcon $emblem) {
    self.bless( :$emblem );
  }
  multi method new (GIcon() $icon, GEmblem() $emblem) {
    self.bless( emblem => g_emblemed_icon_new($icon, $emblem) );
  }

  method add_emblem (GEmblem() $emblem) is also<add-emblem> {
    g_emblemed_icon_add_emblem($!ei, $emblem);
  }

  method clear_emblems is also<clear-emblems> {
    g_emblemed_icon_clear_emblems($!ei);
  }

  method get_emblems (:$glist = False, :$raw = False) is also<get-emblems> {
    return (
      my $el = g_emblemed_icon_get_emblems($!ei)
        but GTK::Compat::Roles::ListData[GEmblem]
    ) if $glist;

    $el ??
      ( $raw ?? $el.Array !! $el.Array.map({ GIO::Emblem.new($_) }) )
      !!
      Nil;
  }

  method get_icon (:$raw = False)
    is also<
      get-icon
      icon
      gicon
    >
  {
    my $i = g_emblemed_icon_get_icon($!ei);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_emblemed_icon_get_type, $n, $t );
  }

}
