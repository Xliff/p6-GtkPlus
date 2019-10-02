use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GTK::Compat::Bytes;

use GTK::Compat::Roles::Object;
use GIO::Roles::Icon;
use GIO::Roles::LoadableIcon;

class GIO::BytesIcon {
  also does GTK::Compat::Roles::Object;
  also does GIO::Roles::Icon;
  also does GIO::Roles::LoadableIcon;

  has GBytesIcon $!bi;

  submethod BUILD (GBytes :$bytes-icon) {
    $!bi = $bytes;
  }

  method GTK::Compat::Types::GBytesIcon
    is also<GBytesIcon>
  { $!bi }

  multi method new (GBytesIcon $bytes-icon) {
    self.bless( :$bytes-icon );
  }
  multi method new (GBytes() $bytes) {
    g_bytes_icon_new();
  }

  method get_bytes (:$raw = False)
    is also<
      get-bytes
      bytes
    >
  {
    my $b = g_bytes_icon_get_bytes($!bi);

    $b ??
      ( $raw ?? $b !! GTK::Compat::Bytes.new($b) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_bytes_icon_get_type, $n, $t );
  }

}

sub g_bytes_icon_get_bytes (GBytesIcon $icon)
  returns GBytes
  is native(gio)
  is export
{ * }

sub g_bytes_icon_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_bytes_icon_new (GBytes $bytes)
  returns GBytesIcon
  is native(gio)
  is export
{ * }
