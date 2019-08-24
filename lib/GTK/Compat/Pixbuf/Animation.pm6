use v6.c;

use GTK::Compat::Types;
use GTK::Compat::Pixbuf::Raw::Animation;

class GTK::Compat::Pixbuf::Animation {
  has GdkPixbufAnimation $!pa;

  submethod BUILD (:$pixbuf-anim) {
    $!pa = $pixbuf-anim;
  }

  method GTK:::Compat::Raw::Types::GdkPixbufAnimation
  { $!pa }

  method new (GdkPixbufAnimation $pixbuf-anim) {
    self.bless( :$pixbuf-anim );
  }

  method new_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    gdk_pixbuf_animation_new_from_file($filename, $error);
    set_error($error);
  }

  method new_from_file_utf8 (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    gdk_pixbuf_animation_new_from_file_utf8($filename, $error);
    set_error($error);
  }

  method new_from_resource (
    Str() $path,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    gdk_pixbuf_animation_new_from_resource($path, $error);
    set_error($error);
  }

  method new_from_stream (
    GInputStream() $stream,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    gdk_pixbuf_animation_new_from_stream(
      $stream,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method new_from_stream_async (
    GInputStream() $stream,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    gdk_pixbuf_animation_new_from_stream_async(
      $stream,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method new_from_stream_finish (
    GAsyncResult $async_result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    gdk_pixbuf_animation_new_from_stream_finish(
      $async_result,
      $error
    );
    set_error($error);
  }

  method gdk_pixbuf_non_anim_get_type {
    gdk_pixbuf_non_anim_get_type();
  }

  method gdk_pixbuf_non_anim_new {
    gdk_pixbuf_non_anim_new();
  }

  method get_height {
    gdk_pixbuf_animation_get_height($!pa);
  }

  method get_iter (GTimeVal $start_time, :$raw = False) {
    my $pai = gdk_pixbuf_animation_get_iter($!pa, $start_time);

    $pai ??
      ( $raw ?? GTK::Compat::Pixbuf::Animation::Iter.new($pai) )
      !!
      Nil
  }

  method get_static_image (:$raw = False) {
    my $p = gdk_pixbuf_animation_get_static_image($!pa);

    $p ??
      ( $raw ?? $p !! GTK::Compat::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_animation_get_type, $n, $t );
  }

  method get_width {
    gdk_pixbuf_animation_get_width($!pa);
  }

  method is_static_image {
    so gdk_pixbuf_animation_is_static_image($!pa);
  }

}

class GTK::Compat::Pixbuf::Animation::Iter {
  has GdkPixbufAnimationIter $!pai;

  submethod BUILD (:$iter) {
    $!pai = $iter;
  }

  method GTK:::Compat::Raw::Types::GdkPixbufAnimation
  { $!pai }

  method new (GdkPixbufAnimationIter $iter) {
    self.bless( :$iter );
  }

  method advance (GTimeVal $current_time) {
    so gdk_pixbuf_animation_iter_advance($!pa, $current_time);
  }

  method get_delay_time {
    gdk_pixbuf_animation_iter_get_delay_time($!pa);
  }

  method get_pixbuf (:$raw = False) {
    my $p = gdk_pixbuf_animation_iter_get_pixbuf($!pa);

    $p ??
      ( $raw ?? $p !! GTK::Compat::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_animation_iter_get_type, $n, $t);
  }

  method on_currently_loading_frame {
    so gdk_pixbuf_animation_iter_on_currently_loading_frame($!pa);
  }

}
