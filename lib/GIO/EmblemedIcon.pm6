use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::Raw::EmblemedIcon;

use GLib::GList;
use GIO::Emblem;

use GLib::Roles::Object;
use GLib::Roles::ListData;
use GIO::Roles::Icon;

class GIO::EmblemedIcon {
  also does GLib::Roles::Object;
  also does GIO::Roles::Icon;

  has GEmblemedIcon $!ei is implementor;

  submethod BUILD (:$emblem) {
    $!ei = $emblem;

    self.roleInit-Object;
    self.roleInit-Icon;
  }

  method GLib::Raw::Types::GEmblemedIcon
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

  method get_emblems (:$glist = False, :$raw = False)
    is also<
      get-emblems
      emblems
    >
  {
    my $el = g_emblemed_icon_get_emblems($!ei);
    return $el if $glist;

    $el = GLib::GList.new($el)
      but GLib::Roles::ListData[GEmblem];

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
