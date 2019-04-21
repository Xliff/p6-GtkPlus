use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GTK::Compat::InputStream;

role GTK::Compat::Roles::LoadableIcon {
  has GLoadableIcon $!li;

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &g_loadable_icon_get_type, $n, $t );
  }

  multi method load (
    Int() $size,
    Str $type is rw
  ) {
    my $s = CArray[Str].new;
    my $rc = samewith($size, $s);
    $rc;
  }
  multi method load (
    Int() $size,
    CArray[Str] $type,
    GCancellable $cancellable       = Pointer,
    CArray[Pointer[GError]] $error  = gerror()
  ) {
    my gint $s = resolve-int($size);
    clear_error;
    my $rc = g_loadable_icon_load($!li, $s, $type, $cancellable, $error);
    set_error($error);
    GTK::Compat::InputStream.new(
      $rc
    );
  }

  proto method load_async (|)
    is also<load-async>
  { * }

  multi method load_async (
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_async (Int() $size,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my gint $s = resolve-int($size);
    g_loadable_icon_load_async($!li, $s, $cancellable, &callback, $user_data);
  }

  multi method load_finish (
    GAsyncResult() $res,
    Str $type is rw
  ) {
    my $s = CArray[Str].new;
    my $rc = samewith($res, $s);
    $type = $s[0];
    $rc;
  }
  method load_finish (
    GAsyncResult() $res,
    CArray[Str] $type              = CArray[Str],
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = g_loadable_icon_load_finish($!li, $res, $type, $error);
    set_error($error);
    GTK::Compat::InputStream.new(
      $rc
    )
  }
}

sub g_loadable_icon_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_loadable_icon_load (
  GLoadableIcon $icon,
  int32 $size,                        # Only marked as int
  CArray[Str] $type,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is native(gio)
  is export
  { * }

sub g_loadable_icon_load_async (
  GLoadableIcon $icon,
  int32 $size,                        # Only marked as int
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_loadable_icon_load_finish (
  GLoadableIcon $icon,
  GAsyncResult $res,
  CArray[Str] $type,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is native(gio)
  is export
  { * }
