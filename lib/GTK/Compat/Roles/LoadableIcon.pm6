use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GIO::InputStream;

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
    GCancellable() $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error  = gerror,
    :$raw = False
  ) {
    my gint $s = resolve-int($size);
    clear_error;
    my $rc = g_loadable_icon_load($!li, $s, $type, $cancellable, $error);
    set_error($error);

    $rc ??
      ( $raw ?? $rc !! GIO::InputStream.new($rc) )
      !!
      Nil;
  }

  proto method load_async (|)
    is also<load-async>
  { * }

  multi method load_async (
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method load_async (Int() $size,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my gint $s = resolve-int($size);
    g_loadable_icon_load_async($!li, $s, $cancellable, &callback, $user_data);
  }

  multi method load_finish (
    GAsyncResult() $res,
    :$all = False,
    :$raw = False
  ) {
    samewith($res, $, gerror, :$all, :$raw);
  }
  multi method load_finish (
    GAsyncResult() $res,
    $type is rw,
    :$all = False,
    :$raw = False,
  ) {
    samewith($res, $type, gerror, :$all, :$raw);
  }
  method load_finish (
    GAsyncResult() $res,
    $type is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False
  ) {
    my $s = CArray[Str].new;
    $s[0] = '';
    clear_error;
    my $rc = g_loadable_icon_load_finish($!li, $res, $s, $error);
    set_error($error);

    do if $rc {
      my $is = $rc ??
        ( $raw ?? $rc !! GTK::Compat::InputStream.new($rc) )
        !!
        Nil;

      $type = $s[0].defined ?? $s[0] !! Nil;
      $all ?? $is !! ($is, $type);
    } else {
      $type = Nil;
      Nil;
    }
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
