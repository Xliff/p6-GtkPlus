use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Pixbufs::Raw::Animation;

sub gdk_pixbuf_non_anim_get_type ()
  returns GType
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_non_anim_new (GdkPixbuf $pixbuf)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_get_height (GdkPixbufAnimation $animation)
  returns gint
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_get_iter (
  GdkPixbufAnimation $animation,
  GTimeVal $start_time
)
  returns GdkPixbufAnimationIter
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_get_static_image (GdkPixbufAnimation $animation)
  returns GdkPixbuf
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_get_type ()
  returns GType
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_get_width (GdkPixbufAnimation $animation)
  returns gint
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_is_static_image (GdkPixbufAnimation $animation)
  returns uint32
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_iter_advance (
  GdkPixbufAnimationIter $iter,
  GTimeVal $current_time
)
  returns uint32
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_iter_get_delay_time (GdkPixbufAnimationIter $iter)
  returns gint
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_iter_get_pixbuf (GdkPixbufAnimationIter $iter)
  returns GdkPixbuf
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_iter_get_type ()
  returns GType
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_iter_on_currently_loading_frame (
  GdkPixbufAnimationIter $iter
)
  returns uint32
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_file (
  Str $filename,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_file_utf8 (
  Str $filename,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_resource (
  Str $resource_path,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_stream (
  GInputStream $stream,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_stream_async (
  GInputStream $stream,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gdk-pixbuf)
  is export
{ * }

sub gdk_pixbuf_animation_new_from_stream_finish (
  GAsyncResult $async_result,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufAnimation
  is native(gdk-pixbuf)
  is export
{ * }
