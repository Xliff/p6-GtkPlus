use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::;
use GTK::Raw::Types;

use GTK::;

class GTK:: is GTK:: {
  has Gtk $!c;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::');
    $o;
  }

  submethod BUILD(:$ ) {
    my $to-parent;
    given $ {
      when Gtk | GtkWidget {
        $! = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(Gtk , $_);
          }
          when Gtk  {
            $to-parent = nativecast(Gtk, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK:: {
      }
      default {
      }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_alpha (gboolean $substitute_color, guchar $r, guchar $g, guchar $b) {
    gdk_pixbuf_add_alpha($!p, $substitute_color, $r, $g, $b);
  }

  method apply_embedded_orientation () {
    gdk_pixbuf_apply_embedded_orientation($!p);
  }

  method calculate_rowstride (gboolean $has_alpha, int $bits_per_sample, int $width, int $height) {
    gdk_pixbuf_calculate_rowstride($!p, $has_alpha, $bits_per_sample, $width, $height);
  }

  method copy () {
    gdk_pixbuf_copy($!p);
  }

  method copy_area (int $src_x, int $src_y, int $width, int $height, GdkPixbuf $dest_pixbuf, int $dest_x, int $dest_y) {
    gdk_pixbuf_copy_area($!p, $src_x, $src_y, $width, $height, $dest_pixbuf, $dest_x, $dest_y);
  }

  method copy_options (GdkPixbuf $dest_pixbuf) {
    gdk_pixbuf_copy_options($!p, $dest_pixbuf);
  }

  method error_quark () {
    gdk_pixbuf_error_quark($!p);
  }

  method fill (guint32 $pixel) {
    gdk_pixbuf_fill($!p, $pixel);
  }

  method get_bits_per_sample () {
    gdk_pixbuf_get_bits_per_sample($!p);
  }

  method get_byte_length () {
    gdk_pixbuf_get_byte_length($!p);
  }

  method get_colorspace () {
    gdk_pixbuf_get_colorspace($!p);
  }

  method get_has_alpha () {
    gdk_pixbuf_get_has_alpha($!p);
  }

  method get_height () {
    gdk_pixbuf_get_height($!p);
  }

  method get_n_channels () {
    gdk_pixbuf_get_n_channels($!p);
  }

  method get_option (gchar $key) {
    gdk_pixbuf_get_option($!p, $key);
  }

  method get_options () {
    gdk_pixbuf_get_options($!p);
  }

  method get_pixels () {
    gdk_pixbuf_get_pixels($!p);
  }

  method get_pixels_with_length (guint $length) {
    gdk_pixbuf_get_pixels_with_length($!p, $length);
  }

  method get_rowstride () {
    gdk_pixbuf_get_rowstride($!p);
  }

  method get_type () {
    gdk_pixbuf_get_type($!p);
  }

  method get_width () {
    gdk_pixbuf_get_width($!p);
  }

  method new (gboolean $has_alpha, int $bits_per_sample, int $width, int $height) {
    gdk_pixbuf_new($!p, $has_alpha, $bits_per_sample, $width, $height);
  }

  method new_from_bytes (GdkColorspace $colorspace, gboolean $has_alpha, int $bits_per_sample, int $width, int $height, int $rowstride) {
    gdk_pixbuf_new_from_bytes($!p, $colorspace, $has_alpha, $bits_per_sample, $width, $height, $rowstride);
  }

  method new_from_data (GdkColorspace $colorspace, gboolean $has_alpha, int $bits_per_sample, int $width, int $height, int $rowstride, GdkPixbufDestroyNotify $destroy_fn, gpointer $destroy_fn_data) {
    gdk_pixbuf_new_from_data($!p, $colorspace, $has_alpha, $bits_per_sample, $width, $height, $rowstride, $destroy_fn, $destroy_fn_data);
  }

  method new_from_file (GError $error) {
    gdk_pixbuf_new_from_file($!p, $error);
  }

  method new_from_file_at_scale (int $width, int $height, gboolean $preserve_aspect_ratio, GError $error) {
    gdk_pixbuf_new_from_file_at_scale($!p, $width, $height, $preserve_aspect_ratio, $error);
  }

  method new_from_file_at_scale_utf8 (int $width, int $height, gboolean $preserve_aspect_ratio, GError $error) {
    gdk_pixbuf_new_from_file_at_scale_utf8($!p, $width, $height, $preserve_aspect_ratio, $error);
  }

  method new_from_file_at_size (int $width, int $height, GError $error) {
    gdk_pixbuf_new_from_file_at_size($!p, $width, $height, $error);
  }

  method new_from_file_at_size_utf8 (int $width, int $height, GError $error) {
    gdk_pixbuf_new_from_file_at_size_utf8($!p, $width, $height, $error);
  }

  method new_from_file_utf8 (GError $error) {
    gdk_pixbuf_new_from_file_utf8($!p, $error);
  }

  method new_from_inline (guint8 $data, gboolean $copy_pixels, GError $error) {
    gdk_pixbuf_new_from_inline($!p, $data, $copy_pixels, $error);
  }

  method new_from_resource (GError $error) {
    gdk_pixbuf_new_from_resource($!p, $error);
  }

  method new_from_resource_at_scale (int $width, int $height, gboolean $preserve_aspect_ratio, GError $error) {
    gdk_pixbuf_new_from_resource_at_scale($!p, $width, $height, $preserve_aspect_ratio, $error);
  }

  method new_from_stream (GCancellable $cancellable, GError $error) {
    gdk_pixbuf_new_from_stream($!p, $cancellable, $error);
  }

  method new_from_stream_async (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    gdk_pixbuf_new_from_stream_async($!p, $cancellable, $callback, $user_data);
  }

  method new_from_stream_at_scale (gint $width, gint $height, gboolean $preserve_aspect_ratio, GCancellable $cancellable, GError $error) {
    gdk_pixbuf_new_from_stream_at_scale($!p, $width, $height, $preserve_aspect_ratio, $cancellable, $error);
  }

  method new_from_stream_at_scale_async (gint $width, gint $height, gboolean $preserve_aspect_ratio, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    gdk_pixbuf_new_from_stream_at_scale_async($!p, $width, $height, $preserve_aspect_ratio, $cancellable, $callback, $user_data);
  }

  method new_from_stream_finish (GError $error) {
    gdk_pixbuf_new_from_stream_finish($!p, $error);
  }

  method new_from_xpm_data () {
    gdk_pixbuf_new_from_xpm_data($!p);
  }

  method new_subpixbuf (int $src_x, int $src_y, int $width, int $height) {
    gdk_pixbuf_new_subpixbuf($!p, $src_x, $src_y, $width, $height);
  }

  method read_pixel_bytes () {
    gdk_pixbuf_read_pixel_bytes($!p);
  }

  method read_pixels () {
    gdk_pixbuf_read_pixels($!p);
  }

  method ref () {
    gdk_pixbuf_ref($!p);
  }

  method remove_option (gchar $key) {
    gdk_pixbuf_remove_option($!p, $key);
  }

  method saturate_and_pixelate (GdkPixbuf $dest, gfloat $saturation, gboolean $pixelate) {
    gdk_pixbuf_saturate_and_pixelate($!p, $dest, $saturation, $pixelate);
  }

  method save_to_bufferv (gchar $buffer, gsize $buffer_size, char $type, char $option_keys, char $option_values, GError $error) {
    gdk_pixbuf_save_to_bufferv($!p, $buffer, $buffer_size, $type, $option_keys, $option_values, $error);
  }

  method save_to_callbackv (GdkPixbufSaveFunc $save_func, gpointer $user_data, char $type, char $option_keys, char $option_values, GError $error) {
    gdk_pixbuf_save_to_callbackv($!p, $save_func, $user_data, $type, $option_keys, $option_values, $error);
  }

  method save_to_stream_finish (GError $error) {
    gdk_pixbuf_save_to_stream_finish($!p, $error);
  }

  method save_to_streamv (GOutputStream $stream, char $type, char $option_keys, char $option_values, GCancellable $cancellable, GError $error) {
    gdk_pixbuf_save_to_streamv($!p, $stream, $type, $option_keys, $option_values, $cancellable, $error);
  }

  method save_to_streamv_async (GOutputStream $stream, gchar $type, gchar $option_keys, gchar $option_values, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    gdk_pixbuf_save_to_streamv_async($!p, $stream, $type, $option_keys, $option_values, $cancellable, $callback, $user_data);
  }

  method savev (char $filename, char $type, char $option_keys, char $option_values, GError $error) {
    gdk_pixbuf_savev($!p, $filename, $type, $option_keys, $option_values, $error);
  }

  method savev_utf8 (char $filename, char $type, char $option_keys, char $option_values, GError $error) {
    gdk_pixbuf_savev_utf8($!p, $filename, $type, $option_keys, $option_values, $error);
  }

  method set_option (gchar $key, gchar $value) {
    gdk_pixbuf_set_option($!p, $key, $value);
  }

  method unref () {
    gdk_pixbuf_unref($!p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
