use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

role GIO::Roles::Initable {
  has GInitable $!i;

  method roleInit-Initable {
    my \i = findProperImplementor(self.^attributes);

    $!i = cast(GInitable, i.get_value(self) );
  }

  method GLib::Raw::Types::GInitable
    is also<GInitable>
  { $!i }

  method initable_get_type is also<initable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_initable_get_type, $n, $t );
  }

  multi method init (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    so g_initable_init($!i, $cancellable, $error);
  }

}

sub g_initable_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_initable_init (
  GInitable $initable,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
