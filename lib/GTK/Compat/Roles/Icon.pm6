use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Icon;

use GTK::Roles::Types;

role GTK::Compat::Roles::Icon {
  also does GTK::Roles::Types;

  has GIcon $!icon;

  method GTK::Raw::Types::GIcon {
    $!icon;
  }

  method new_for_string (
    Str() $name,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_icon_new_for_string($name, $error);
    $ERROR = $error with $error[0];
    $rc;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method deserialize(GVariant $v) {
    g_icon_deserialize($v);
  }

  method equal (GIcon() $icon2) {
    g_icon_equal($!icon, $icon2);
  }

  method get_type {
    g_icon_get_type();
  }

  method hash(Pointer $i) {
    g_icon_hash($i);
  }

  method serialize {
    g_icon_serialize($!icon);
  }

  method to_string {
    g_icon_to_string($!icon);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
