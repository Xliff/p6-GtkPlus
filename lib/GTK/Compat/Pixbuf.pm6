use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Pixbuf;
use GTK::Compat::Pixbuf::Transforms;

use GTK::Raw::Utils;

class GTK::Compat::Pixbuf  {
  has GdkPixbuf $!p;

  submethod BUILD(:$pixbuf) {
    $!p = $pixbuf;
  }

  method GTK::Compat::Types::GdkPixbuf
    is also<
      GdkPixbuf
      pixbuf
    >
  {
    $!p;
  }

  # ↓↓↓↓ OBJECT CREATION ↓↓↓↓
  multi method new (GdkPixbuf $pixbuf) {
    self.bless(:$pixbuf);
  }
  multi method new (
    Int() $colorspace,
    Int() $has_alpha,
    Int() $bits_per_sample,
    Int() $width,
    Int() $height
  ) {
    my $ha = resolve-bool($has_alpha);
    my ($bps, $w, $h) = resolve-int($bits_per_sample, $width, $height);
    my guint $cs = resolve-uint($colorspace);
    my $pixbuf = gdk_pixbuf_new($cs, $ha, $bps, $w, $h);

    self.bless(:$pixbuf);
  }

  method new_from_bytes (
    GBytes() $data,
    Int() $colorspace,
    Int() $has_alpha,
    Int() $bits_per_sample,
    Int() $width,
    Int() $height,
    Int() $rowstride
  )
    is also<new-from-bytes>
  {
    my $ha = resolve-bool($has_alpha);
    my ($bps, $w, $h, $rs) =
      resolve-int($bits_per_sample, $width, $height, $rowstride);
    my guint $cs = resolve-uint($colorspace);
    my $pixbuf = gdk_pixbuf_new_from_bytes(
      $data, $cs, $ha, $bps, $w, $h, $rs
    );

    self.bless(:$pixbuf);
  }

  method new_from_data (
    Str() $data,
    Int() $colorspace,
    Int() $has_alpha,
    Int() $bits_per_sample,
    Int() $width,
    Int() $height,
    Int() $rowstride,
    GdkPixbufDestroyNotify $destroy_fn,
    gpointer $destroy_fn_data
  )
    is also<new-from-data>
  {
    my $ha = resolve-bool($has_alpha);
    my ($bps, $w, $h, $rs) =
      resolve-int($bits_per_sample, $width, $height, $rowstride);
    my guint $cs = resolve-uint($colorspace);
    my $pixbuf = gdk_pixbuf_new_from_data(
      $data, $cs, $ha, $bps, $w, $h, $rs,
      $destroy_fn,
      $destroy_fn_data
    );

    self.bless(:$pixbuf);
  }

  method new_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file>
  {
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file($filename, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_file_at_scale (
    Str() $filename,
    Int() $width,
    Int() $height,
    Int() $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file-at-scale>
  {
    my ($w, $h) = resolve-int($width, $height);
    my $prs = resolve-bool($preserve_aspect_ratio);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file_at_scale(
      $filename, $w, $h, $prs, $error
    );
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_file_at_scale_utf8 (
    Str() $filename,
    Int() $width,
    Int() $height,
    Int() $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file-at-scale-utf8>
  {
    my ($w, $h) = resolve-int($width, $height);
    my $prs = resolve-bool($preserve_aspect_ratio);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file_at_scale_utf8(
      $filename, $w, $h, $prs, $error
    );
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_file_at_size (
    Str() $filename,
    Int() $width,
    Int() $height,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file-at-size>
  {
    my ($w, $h) = resolve-int($width, $height);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file_at_size($filename, $w, $h, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_file_at_size_utf8 (
    Str() $filename,
    Int() $width,
    Int() $height,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file-at-size-utf8>
  {
    my ($w, $h) = resolve-int($width, $height);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file_at_size_utf8(
      $filename, $w, $h, $error
    );
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_file_utf8 (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-file-utf8>
  {
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_file_utf8($filename, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_inline (
    Int() $length,
    Int() $data,
    Int() $copy_pixels,
    CArray[Pointer[GError]] $error = gerror()
  )
    is DEPRECATED
    is also<new-from-inline>
  {
    my $l = resolve-int($length);
    my $d = resolve-int($data);
    my $cp = resolve-bool($copy_pixels);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_inline($l, $d, $cp, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_resource (
    Str() $resource_path,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-resource>
  {
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_resource($resource_path, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_resource_at_scale (
    Str() $resource_path,
    Int() $width,
    Int() $height,
    Int() $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-resource-at-scale>
  {
    my ($w, $h) = resolve-int($width, $height);
    my $prs = resolve-bool($preserve_aspect_ratio);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_resource_at_scale(
      $resource_path, $w, $h, $prs, $error
    );
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_stream (
    GInputStream() $stream,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-stream>
  {
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_stream($stream, $cancellable, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_stream_async (
    GInputStream() $stream,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<new-from-stream-async>
  {
    my $pixbuf = gdk_pixbuf_new_from_stream_async(
      $stream,
      $cancellable,
      $callback,
      $user_data
    );
    self.bless(:$pixbuf);
  }

  method new_from_stream_at_scale (
    GInputStream() $stream,
    Int() $width,
    Int() $height,
    Int() $preserve_aspect_ratio,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-stream-at-scale>
  {
    my ($w, $h) = resolve-int($width, $height);
    my $prs = resolve-bool($preserve_aspect_ratio);
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_stream_at_scale(
      $stream, $w, $h, $prs, $cancellable, $error
    );
    set_error($error);

    self.bless(:$pixbuf);
  }

  method new_from_stream_at_scale_async (
    GInputStream() $stream,
    Int() $width,
    Int() $height,
    Int() $preserve_aspect_ratio,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<new-from-stream-at-scale-async>
  {
    my ($w, $h) = resolve-int($width, $height);
    my $prs = resolve-bool($preserve_aspect_ratio);
    my $pixbuf = gdk_pixbuf_new_from_stream_at_scale_async(
      $stream, $w, $h, $prs, $cancellable, $callback, $user_data
    );

    self.bless(:$pixbuf);
  }

  method new_from_stream_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<new-from-stream-finish>
  {
    clear_error;
    my $pixbuf = gdk_pixbuf_new_from_stream_finish($result, $error);
    set_error($error);

    self.bless(:$pixbuf);
  }

  proto method new_from_xpm_data(|c)
    is also<new-from-xpm-data>
  { * }

  multi method new_from_xpm_data(Str $data is copy) {
    #my $ca = CArray[Str].new( $data.lines );
    my $ca = CArray[Str].new( $data.lines.map({
      "{ $_ }\0" unless .ends-with("\0");
    }) );
    samewith($ca);
  }
  multi method new_from_xpm_data(CArray[Str] $data) {
    my $pixbuf = gdk_pixbuf_new_from_xpm_data($data);
    self.bless(:$pixbuf);
  }

  method new_subpixbuf (
    GdkPixbuf() $src,
    Int() $src_x,
    Int() $src_y,
    Int() $width,
    Int() $height
  )
    is also<new-subpixbuf>
  {
    my ($sx, $sy, $w, $h) = resolve-int($src_x, $src_y, $width, $height);
    my $pixbuf = gdk_pixbuf_new_subpixbuf($src, $sx, $sy, $w, $h);

    self.bless(:$pixbuf);
  }
  # ↑↑↑↑ OBJECT CREATION ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_alpha (
    Int() $substitute_color,
    Int() $r,
    Int() $g,
    Int() $b
  )
    is also<add-alpha>
  {
    my ($rr, $gg, $bb) = resolve-ushort($r, $g, $b);
    my $sc = resolve-bool($substitute_color);
    gdk_pixbuf_add_alpha($!p, $sc, $rr, $gg, $bb);
  }

  method apply_embedded_orientation is also<apply-embedded-orientation> {
    gdk_pixbuf_apply_embedded_orientation($!p);
  }

  method calculate_rowstride (
    Int() $colorspace,
    Int() $has_alpha,
    Int() $bits_per_sample,
    Int() $width,
    Int() $height
  )
    is also<calculate-rowstride>
  {
    my $ha = resolve-bool($has_alpha);
    my ($bps, $w, $h) = resolve-int($bits_per_sample, $width, $height);
    my guint $cs = resolve-uint($colorspace);

    gdk_pixbuf_calculate_rowstride($cs, $ha, $bps, $w, $h);
  }

  method copy {
    gdk_pixbuf_copy($!p);
  }

  method copy_area (
    Int() $src_x,
    Int() $src_y,
    Int() $width,
    Int() $height,
    GdkPixbuf() $dest_pixbuf,
    Int() $dest_x,
    Int() $dest_y
  )
    is also<copy-area>
  {
    my @i = ();
    my ($sx, $sy, $w, $h, $dx, $dy) =
      resolve-int($src_x, $src_y, $width, $height, $dest_x, $dest_y);

    gdk_pixbuf_copy_area($!p, $sx, $sy, $w, $h, $dest_pixbuf, $dx, $dy);
  }

  method copy_options (GdkPixbuf() $dest_pixbuf) is also<copy-options> {
    gdk_pixbuf_copy_options($!p, $dest_pixbuf);
  }

  method error_quark is also<error-quark> {
    gdk_pixbuf_error_quark();
  }

  method fill (Int() $pixel) {
    my guint $p = resolve-int($pixel);
    gdk_pixbuf_fill($!p, $p);
  }

  method get_bits_per_sample
    is also<
      get-bits-per-sample
      bits_per_sample
      bits-per-sample
    >
  {
    gdk_pixbuf_get_bits_per_sample($!p);
  }

  method get_byte_length
    is also<
      get-byte-length
      byte_length
      byte-length
    >
  {
    gdk_pixbuf_get_byte_length($!p);
  }

  method get_colorspace
    is also<
      get-colorspace
      colorspace
    >
  {
    gdk_pixbuf_get_colorspace($!p);
  }

  method get_has_alpha
    is also<
      get-has-alpha
      has_alpha
      has-alpha
    >
  {
    so gdk_pixbuf_get_has_alpha($!p);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    gdk_pixbuf_get_height($!p);
  }

  method get_n_channels
    is also<
      get-n-channels
      n_channels
      n-channels
    >
  {
    gdk_pixbuf_get_n_channels($!p);
  }

  method get_option (Str() $key) is also<get-option> {
    gdk_pixbuf_get_option($!p, $key);
  }

  method get_options
    is also<
      get-options
      options
    >
  {
    gdk_pixbuf_get_options($!p);
  }

  method get_pixels
    is also<
      get-pixels
      pixels
    >
  {
    gdk_pixbuf_get_pixels($!p);
  }

  method get_pixels_with_length (Int() $length)
    is also<get-pixels-with-length>
  {
    my guint $l = resolve-uint($length);
    gdk_pixbuf_get_pixels_with_length($!p, $l);
  }

  method get_rowstride
    is also<
      get-rowstride
      rowstride
    >
  {
    gdk_pixbuf_get_rowstride($!p);
  }

  method get_type is also<get-type> {
    state ($t, $n);
    unstable_get_type( self.^name, &gdk_pixbuf_get_type, $n, $t );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    gdk_pixbuf_get_width($!p);
  }

  method read_pixel_bytes is also<read-pixel-bytes> {
    gdk_pixbuf_read_pixel_bytes($!p);
  }

  method read_pixels is also<read-pixels> {
    gdk_pixbuf_read_pixels($!p);
  }

  method ref is also<upref> {
    gdk_pixbuf_ref($!p);
    self;
  }

  method remove_option (Str() $key) is also<remove-option> {
    gdk_pixbuf_remove_option($!p, $key);
  }

  method saturate_and_pixelate (
    GdkPixbuf() $dest,
    Num() $saturation,
    Int() $pixelate
  )
    is also<saturate-and-pixelate>
  {
    my gfloat $s = $saturation;
    my gboolean $p = resolve-bool($pixelate);
    gdk_pixbuf_saturate_and_pixelate($!p, $dest, $s, $p);
  }

  method !PREP_OPTIONS(@option_keys, @option_values) {
    my ($ok, $ov) = (CArray[Str].new xx 2);

    for ( [$ok, @option_keys], [$ov, @option_values] ) -> $d {
      my $idx = 0;
      $d[0][$idx++] = $_ for $d[1];
      $d[0][$idx] = Str;
    }

    ($ok, $ov);
  }

  method save_to_bufferv (
    $buffer,
    Int $buffer_size is rw,
    Str() $type,
    @option_keys,
    @option_values,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<save-to-bufferv>
  {
    my $b = do given $buffer {
      when Str { .encode }
      when Buf { $_      }
      default  { die "Do not know how to handle '{ .^name }'" }
    }
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my $cb = CArray[uint8].new($b);
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    clear_error;
    my $rc = gdk_pixbuf_save_to_bufferv(
      $!p, $cb, $buffer_size, $type, $ok, $ov, $error
    );
    set_error($error);
    $rc;
  }

  method save_to_callbackv (
    GdkPixbufSaveFunc $save_func,
    gpointer $user_data,
    Str() $type,
    @option_keys,
    @option_values,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<save-to-callbackv>
  {
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    clear_error;
    my $rc = gdk_pixbuf_save_to_callbackv(
      $!p, $save_func, $user_data, $type, $ok, $ov, $error
    );
    set_error($error);
    $rc;
  }

  method save_to_stream_finish (
    GAsyncResult, $result = GAsyncResult,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<save-to-stream-finish>
  {
    clear_error;
    my $rc = gdk_pixbuf_save_to_stream_finish($result, $error);
    set_error($error);
    $rc;
  }

  method save_to_streamv (
    GOutputStream() $stream,
    Str() $type,
    @option_keys,
    @option_values,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<save-to-streamv>
  {
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    clear_error;
    my $rc = gdk_pixbuf_save_to_streamv(
      $!p, $stream, $type, $ok, $ov, $cancellable, $error
    );
    set_error($error);
    $rc;
  }

  method save_to_streamv_async (
    GOutputStream() $stream,
    Str() $type,
    @option_keys,
    @option_values,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<save-to-streamv-async>
  {
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    gdk_pixbuf_save_to_streamv_async(
      $!p, $stream, $type, $ok, $ov, $cancellable, $callback, $user_data
    );
  }

  method savev (
    Str() $filename,
    Str() $type,
    @option_keys,
    @option_values,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    clear_error;
    my $rc = gdk_pixbuf_savev($!p, $filename, $type, $ok, $ov, $error);
    set_error($error);
    $rc;
  }

  method savev_utf8 (
    Str() $filename,
    Str() $type,
    @option_keys,
    @option_values,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<savev-utf8>
  {
    warn "Format '$type' may not be supported"
      unless $type eq <jpeg tiff png ico bmp>.any;
    my ($ok, $ov) = self!PREP_OPTIONS(@option_keys, @option_values);

    clear_error;
    my $rc = gdk_pixbuf_savev_utf8($!p, $filename, $type, $ok, $ov, $error);
    set_error($error);
    $rc;
  }

  method set_option (Str() $key, Str() $value) is also<set-option> {
    gdk_pixbuf_set_option($!p, $key, $value);
  }

  method size {
    (self.get_width, self.get_height);
  }

  method unref is also<downref> {
    gdk_pixbuf_unref($!p);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  # ↑↑↑↑ TRANSFORM METHODS ↑↑↑↑

  # Due to the nature of these mthods, they are passthru's to
  # GTK::Compat::Pixbuf::Transforms
  method composite(*@a) {
    GTK::Compat::Pixbuf::Transforms.composite($!p, |@a);
  }

  method composite_color(*@a) is also<composite-color> {
    GTK::Compat::Pixbuf::Transforms.composite_color($!p, |@a);
  }

  method composite_color_simple(*@a) is also<compsite-color-simple> {
    GTK::Compat::Pixbuf::Transforms.composite_color_simple($!p, |@a);
  }

  method flip (*@a) {
    GTK::Composite::Pixbuf::Transforms.flip($!p, |@a);
  }

  method scale (*@a) {
    GTK::Composite::Pixbuf::Transforms.scale($!p, |@a);
  }

  method scale_simple(*@a) is also<scale-simple> {
    GTK::Composite::Pixbuf::Transforms.scale_simple($!p, |@a);
  }

}
