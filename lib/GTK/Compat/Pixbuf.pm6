use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Pixbuf;

class GTK::Compat::Pixbuf  {
  has GdkPixbuf $!p;

  submethod BUILD(:$pixbuf) {
    $!p = $pixbuf;
  }

  method GTK::Compat::Types::GdkPixbuf {
    $!p;
  }

  # ↓↓↓↓ OBJECT CREATION ↓↓↓↓
  multi method new (GdkPixbuf $pixbuf) {
    self.bless(:$pixbuf);
  }
  multi method new (
    GdkColorspace $colorspace,
    gboolean $has_alpha,
    int $bits_per_sample,
    int $width,
    int $height
  ) {
    my $pixbuf = gdk_pixbuf_new(
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height
    );
    self.bless(:$pixbuf);
  }

  method new_from_bytes (
    GBytes $data,
    GdkColorspace $colorspace,
    gboolean $has_alpha,
    int $bits_per_sample,
    int $width,
    int $height,
    int $rowstride
  ) {
    my $pixbuf = gdk_pixbuf_new_from_bytes(
      $data,
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height,
      $rowstride
    );
    self.bless(:$pixbuf);
  }

  method new_from_data (
    guchar $data,
    GdkColorspace $colorspace,
    gboolean $has_alpha,
    int $bits_per_sample,
    int $width,
    int $height,
    int $rowstride,
    GdkPixbufDestroyNotify $destroy_fn,
    gpointer $destroy_fn_data
  ) {
    my $pixbuf = gdk_pixbuf_new_from_data(
      $data,
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height,
      $rowstride,
      $destroy_fn,
      $destroy_fn_data
    );
    self.bless(:$pixbuf);
  }

  method new_from_file (Str() $filename, GError $error) {
    my $pixbuf = gdk_pixbuf_new_from_file($filename, $error);
    self.bless(:$pixbuf);
  }

  method new_from_file_at_scale (
    Str() $filename,
    int $width,
    int $height,
    gboolean $preserve_aspect_ratio,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_file_at_scale(
      $filename,
      $width,
      $height,
      $preserve_aspect_ratio,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_file_at_scale_utf8 (
    Str() $filename,
    int $width,
    int $height,
    gboolean $preserve_aspect_ratio,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_file_at_scale_utf8(
      $filename,
      $width,
      $height,
      $preserve_aspect_ratio,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_file_at_size (
    Str() $filename,
    int $width,
    int $height,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_file_at_size(
      $filename,
      $width,
      $height,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_file_at_size_utf8 (
    Str() $filename,
    int $width,
    int $height,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_file_at_size_utf8(
      $filename,
      $width,
      $height,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_file_utf8 (Str() $filename, GError $error) {
    my $pixbuf = gdk_pixbuf_new_from_file_utf8($filename, $error);
    self.bless(:$pixbuf);
  }

  method new_from_inline (
    gint $length,
    guint8 $data,
    gboolean $copy_pixels,
    GError $error
  ) is DEPRECATED {
    my $pixbuf = gdk_pixbuf_new_from_inline(
      $length,
      $data,
      $copy_pixels,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_resource (Str() $resource_path, GError $error) {
    my $pixbuf = gdk_pixbuf_new_from_resource($resource_path, $error);
    self.bless(:$pixbuf);
  }

  method new_from_resource_at_scale (
    Str() $resource_path,
    int $width,
    int $height,
    gboolean $preserve_aspect_ratio,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_resource_at_scale(
      $resource_path,
      $width,
      $height,
      $preserve_aspect_ratio,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_stream (
    GInputStream $stream,
    GCancellable $cancellable,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_stream($stream, $cancellable, $error);
    self.bless(:$pixbuf);
  }

  method new_from_stream_async (
    GInputStream $stream,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
    my $pixbuf = gdk_pixbuf_new_from_stream_async(
      $stream,
      $cancellable,
      $callback,
      $user_data
    );
    self.bless(:$pixbuf);
  }

  method new_from_stream_at_scale (
    GInputStream $stream,
    gint $width,
    gint $height,
    gboolean $preserve_aspect_ratio,
    GCancellable $cancellable,
    GError $error
  ) {
    my $pixbuf = gdk_pixbuf_new_from_stream_at_scale(
      $stream,
      $width,
      $height,
      $preserve_aspect_ratio,
      $cancellable,
      $error
    );
    self.bless(:$pixbuf);
  }

  method new_from_stream_at_scale_async (
    GInputStream $stream,
    gint $width,
    gint $height,
    gboolean $preserve_aspect_ratio,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
    my $pixbuf = gdk_pixbuf_new_from_stream_at_scale_async(
      $stream,
      $width,
      $height,
      $preserve_aspect_ratio,
      $cancellable,
      $callback,
      $user_data
    );
    self.bless(:$pixbuf);
  }

  method new_from_stream_finish (GAsyncResult $result, GError $error) {
    my $pixbuf = gdk_pixbuf_new_from_stream_finish($result, $error);
    self.bless(:$pixbuf);
  }

  method new_from_xpm_data(CArray[Str] $data) {
    my $pixbuf = gdk_pixbuf_new_from_xpm_data($data);
    self.bless(:$pixbuf);
  }

  method new_subpixbuf (
    GdkPixbuf() $src,
    gint $src_x,
    gint $src_y,
    gint $width,
    gint $height
  ) {
    my $pixbuf = gdk_pixbuf_new_subpixbuf(
      $src,
      $src_x,
      $src_y,
      $width,
      $height
    );
    self.bless(:$pixbuf);
  }
  # ↑↑↑↑ OBJECT CREATION ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_alpha (
    gboolean $substitute_color,
    guchar $r,
    guchar $g,
    guchar $b
  ) {
    gdk_pixbuf_add_alpha($!p, $substitute_color, $r, $g, $b);
  }

  method apply_embedded_orientation {
    gdk_pixbuf_apply_embedded_orientation($!p);
  }

  method calculate_rowstride (
    GdkColorspace $colorspace,
    gboolean $has_alpha,
    int $bits_per_sample,
    int $width,
    int $height
  ) {
    gdk_pixbuf_calculate_rowstride(
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height
    );
  }

  method copy {
    gdk_pixbuf_copy($!p);
  }

  method copy_area (
    int $src_x,
    int $src_y,
    int $width,
    int $height,
    GdkPixbuf $dest_pixbuf,
    int $dest_x,
    int $dest_y
  ) {
    gdk_pixbuf_copy_area(
      $!p,
      $src_x,
      $src_y,
      $width,
      $height,
      $dest_pixbuf,
      $dest_x,
      $dest_y
    );
  }

  method copy_options (GdkPixbuf $dest_pixbuf) {
    gdk_pixbuf_copy_options($!p, $dest_pixbuf);
  }

  method error_quark {
    gdk_pixbuf_error_quark();
  }

  method fill (guint32 $pixel) {
    gdk_pixbuf_fill($!p, $pixel);
  }

  method get_bits_pe_sample {
    gdk_pixbuf_get_bits_per_sample($!p);
  }

  method get_byte_length {
    gdk_pixbuf_get_byte_length($!p);
  }

  method get_colorspace {
    gdk_pixbuf_get_colorspace($!p);
  }

  method get_has_alpha {
    gdk_pixbuf_get_has_alpha($!p);
  }

  method get_height {
    gdk_pixbuf_get_height($!p);
  }

  method get_n_channels {
    gdk_pixbuf_get_n_channels($!p);
  }

  method get_option (gchar $key) {
    gdk_pixbuf_get_option($!p, $key);
  }

  method get_options {
    gdk_pixbuf_get_options($!p);
  }

  method get_pixels {
    gdk_pixbuf_get_pixels($!p);
  }

  method get_pixels_with_length (guint $length) {
    gdk_pixbuf_get_pixels_with_length($!p, $length);
  }

  method get_rowstride {
    gdk_pixbuf_get_rowstride($!p);
  }

  method get_type {
    state $t;
    state $n = 0;

    return $t if $n > 0;
    repeat {
      $t = gdk_pixbuf_get_type();
      die "{ ::?CLASS.^name }.get_type could not get stable result"
        if $n++ > 20;
    } until $t == gdk_pixbuf_get_type();
    $t;
  }

  method get_width {
    gdk_pixbuf_get_width($!p);
  }

  method read_pixel_bytes {
    gdk_pixbuf_read_pixel_bytes($!p);
  }

  method read_pixels {
    gdk_pixbuf_read_pixels($!p);
  }

  method ref {
    gdk_pixbuf_ref($!p);
  }

  method remove_option (Str() $key) {
    gdk_pixbuf_remove_option($!p, $key);
  }

  method saturate_and_pixelate (
    GdkPixbuf $dest,
    gfloat $saturation,
    gboolean $pixelate
  ) {
    gdk_pixbuf_saturate_and_pixelate($!p, $dest, $saturation, $pixelate);
  }

  method save_to_bufferv (
    gchar $buffer,
    gsize $buffer_size,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GError $error
  ) {
    gdk_pixbuf_save_to_bufferv(
      $!p,
      $buffer,
      $buffer_size,
      $type,
      $option_keys,
      $option_values,
      $error
    );
  }

  method save_to_callbackv (
    GdkPixbufSaveFunc $save_func,
    gpointer $user_data,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GError $error
  ) {
    gdk_pixbuf_save_to_callbackv(
      $!p,
      $save_func,
      $user_data,
      $type,
      $option_keys,
      $option_values,
      $error
    );
  }

  method save_to_stream_finish (
    GAsyncResult, $result = GAsyncResult,
    GError $error = GError
  ) {
    gdk_pixbuf_save_to_stream_finish($result, $error);
  }

  method save_to_streamv (
    GOutputStream $stream,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GCancellable $cancellable,
    GError $error
  ) {
    gdk_pixbuf_save_to_streamv(
      $!p,
      $stream,
      $type,
      $option_keys,
      $option_values,
      $cancellable,
      $error
    );
  }

  method save_to_streamv_async (
    GOutputStream $stream,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
    gdk_pixbuf_save_to_streamv_async(
      $!p,
      $stream,
      $type,
      $option_keys,
      $option_values,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method savev (
    gchar $filename,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GError $error
  ) {
    gdk_pixbuf_savev(
      $!p,
      $filename,
      $type,
      $option_keys,
      $option_values,
      $error
    );
  }

  method savev_utf8 (
    gchar $filename,
    gchar $type,
    gchar $option_keys,
    gchar $option_values,
    GError $error
  ) {
    gdk_pixbuf_savev_utf8(
      $!p,
      $filename,
      $type,
      $option_keys,
      $option_values,
      $error
    );
  }

  method set_option (gchar $key, gchar $value) {
    gdk_pixbuf_set_option($!p, $key, $value);
  }

  method unref {
    gdk_pixbuf_unref($!p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
