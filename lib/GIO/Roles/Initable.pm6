use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

role GIO::Roles::Initable {
  has GInitable $!i;

  method roleInit-Initable {
    $!i = cast( GInitable, self.^attributes(:local)[0].get-value(self) );
  }

  method GTK::Compat::Types::GInitable
    is also<GInitable>
  { $!i }

  method initable_get_type is also<initable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_initable_get_type, $n, $t );
  }

  method init (
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
