use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GIO::InputStream;

role GIO::Roles::LoadableIcon {
  has GLoadableIcon $!li;

  submethod BUILD (:$loadable) {
    $!li = $loadable;
  }

  method roleInit-LoadableIcon {
    $!li = cast(
      GLoadableIcon,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GLoadableIcon
    is also<GLoadableIcon>
  { $!li }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_loadable_icon_get_type, $n, $t );
  }

  multi method load (
    Int() $size,
    CArray[Pointer[GError]] $error  = gerror,
    :$all = False,
    :$raw = False,
  ) {
    my $rc = samewith($size, $, GCancellable, $error, :$all, :$raw);
    $rc;
  }
  multi method load (
    Int() $size,
    $type is rw,
    GCancellable() $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error  = gerror,
    :$all = False,
    :$raw = False
  ) {
    my gint $s = resolve-int($size);
    my $t = CArray[Str].new;
    $t[0] = Str;

    clear_error;
    my $rc = g_loadable_icon_load($!li, $s, $t, $cancellable, $error);
    set_error($error);

    $type = $t[0] if $t[0];

    my $is = $rc ??
      ( $raw ?? $rc !! GIO::InputStream.new($rc) )
      !!
      Nil;

    $all.not ?? $is !! ($is, $type);
  }

  proto method load_async (|)
    is also<load-async>
  { * }

  multi method load_async (
    Int() $size,
    &callback,
    gpointer $user_data         = Pointer,
  ) {
    samewith($size, GCancellable, &callback, $user_data);
  }
  multi method load_async (
    Int() $size,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my gint $s = resolve-int($size);

    g_loadable_icon_load_async($!li, $s, $cancellable, &callback, $user_data);
  }

  proto method load_finish (|)
    is also<load-finish>
  { * }

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
  multi method load_finish (
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
        ( $raw ?? $rc !! GIO::InputStream.new($rc) )
        !!
        Nil;

      $type = $s[0].defined ?? $s[0] !! Nil;
      $all.not ?? $is !! ($is, $type);
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
  &callback (GObject, GAsyncResult, Pointer),
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
