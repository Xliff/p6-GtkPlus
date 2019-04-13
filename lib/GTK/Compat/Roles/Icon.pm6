use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Icon;

use GTK::Roles::Types;

role GTK::Compat::Roles::Icon {
  also does GTK::Roles::Types;

  has GIcon $!icon;

  method GTK::Raw::Types::GIcon is also<Icon> { $!icon }

  method new_for_string (
    Str() $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-for-string>
  {
    clear_error;
    my $rc = g_icon_new_for_string($name, $error);
    set_error($error);
    $rc;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method deserialize(GVariant() $v) {
    g_icon_deserialize($v);
  }

  method equal (GIcon() $icon2) {
    g_icon_equal($!icon, $icon2);
  }

  method get_icon_type is also<get-icon-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &g_icon_get_type, $n, $t );
  }

  method hash(GIcon() $i) {
    g_icon_hash($i);
  }

  method serialize {
    GTK::Compat::Variant.new( g_icon_serialize($!icon) );
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_icon_to_string($!icon);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
