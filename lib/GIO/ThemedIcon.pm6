use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::ThemedIcon;

use GTK::Raw::Utils;

use GTK::Roles::Properties;
use GIO::Roles::Icon;

class GIO::ThemedIcon {
  also does GTK::Roles::Properties;
  also does GIO::Roles::Icon;

  has GThemedIcon $!ti;

  submethod BUILD (:$themed-icon) {
    $!ti = $themed-icon;

    self.roleInit-Object;
    self.roleInit-Icon;
  }

  method GTK::Compat::Types::GThemedIcon
  { $!ti }

  method new (Str() $icon-name) {
    self.bless( themed-icon => g_themed_icon_new($icon-name) );
  }

  proto method new_from_names (|)
      is also<new-from-names>
  { * }

  multi method new_from_names(@names) {
    my $sa = CArray[Str].new;

    $sa[$_] = @names[$_] for @names.keys;
    samewith($sa, @names.elems);
  }
  multi method new_from_names (CArray[Str] $names, Int() $len) {
    my gint $l = $len;

    self.bless( themed-icon => g_themed_icon_new_from_names($names, $l) );
  }

  method new_with_default_fallbacks (Str() $icon-name)
    is also<new-with-default-fallbacks>
  {
    self.bless(
      themed-icon => g_themed_icon_new_with_default_fallbacks($icon-name)
    );
  }

  # Type: gboolean
  method use-default-fallbacks is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('use-default-fallbacks', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'use-default-fallbacks does not allow writing';
      }
    );
  }

  method append_name (Str() $iconname) is also<append-name> {
    g_themed_icon_append_name($!ti, $iconname);
  }

  method get_names
    is also<
      get-names
      names
    >
  {
    CStringArrayToArray( g_themed_icon_get_names($!ti) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_themed_icon_get_type, $n, $t );
  }

  method prepend_name (Str() $iconname) is also<prepend-name> {
    g_themed_icon_prepend_name($!ti, $iconname);
  }

}
