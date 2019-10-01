use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Variant;

use GTK::Compat::Types;
use GIO::Raw::Icon;

role GIO::Roles::Icon {
  has GIcon $!icon;

  submethod BUILD (:$icon) {
    $!icon = $icon;
  }

  method roleInit-Icon {
    $!icon = cast(
      GIcon,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GIcon
    is also<
      GIcon
      Icon
    >
  { $!icon }

  method new-icon-obj ($icon) {
    self.bless( :$icon );
  }

  method new_for_string (
    Str() $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-for-string>
  {
    clear_error;
    my $rc = g_icon_new_for_string($name, $error);
    set_error($error);
    self.bless( icon => $rc );
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method deserialize(
    GIO::Roles::Icon:U:
    GVariant() $v,
    :$raw = False
  ) {
    my $i = g_icon_deserialize($v);

    $i ??
      ( $raw ?? $i !! self.bless( icon => $i ) )
      !!
      Nil;
  }

  method equal (GIcon() $icon2) {
    so g_icon_equal($!icon, $icon2);
  }

  method icon_get_type is also<icon-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_icon_get_type, $n, $t );
  }

  multi method hash(GIO::Roles::Icon:D:) {
    GIO::Roles::Icon.hash($!icon);
  }
  multi method hash (GIO::Roles::Icon:U: GIcon() $i) {
    g_icon_hash($i);
  }

  method serialize (:$raw = False) {
    my $si = g_icon_serialize($!icon);

    $si ??
      ( $raw ?? $si !! GTK::Compat::Variant.new($si) )
      !!
      Nil
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
