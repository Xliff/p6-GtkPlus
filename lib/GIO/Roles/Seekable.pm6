use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::Raw::Seekable;

role GIO::Roles::Seekable {
  has GSeekable $!s;

  method roleInit-Seekable is also<roleInit_Seekable> {
    my \i = findProperImplementor(self.^attributes);

    $!s = cast( GSeekable, i.get_value(self) );
  }

  method GLib::Raw::Types::GSeekable
    is also<GSeekable>
  { $!s }

  method can_seek is also<can-seek> {
    so g_seekable_can_seek($!s);
  }

  method can_truncate is also<can-truncate> {
    so g_seekable_can_truncate($!s);
  }

  method seekable_get_type is also<seekable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_seekable_get_type, $n, $t );
  }

  method seek (
    Int() $offset,
    GSeekType $type,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my goffset $o = $offset;
    my GSeekType $t = $type;

    clear_error;
    my $rv = so g_seekable_seek($!s, $o, $t, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method tell {
    g_seekable_tell($!s);
  }

  method truncate (
    Int() $offset,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my goffset $o = $offset;

    clear_error;
    my $rv = so g_seekable_truncate($!s, $o, $cancellable, $error);
    set_error($error);
    $rv;
  }

}
