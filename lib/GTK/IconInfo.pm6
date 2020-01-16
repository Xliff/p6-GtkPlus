use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::IconTheme;
use GTK::Raw::Types;

use GDK::RGBA;
use GDK::Pixbuf;

use GLib::Roles::Object;

# Opaque struct

class GTK::IconInfo {
  also does GLib::Roles::Object;

  has GtkIconInfo $!ii is implementor;

  submethod BUILD(:$info) {
    self!setObject($!ii = $info);             # GLib::Roles::Object
  }

  method GTK::Raw::Definitions::GtkIconInfo
    is also<
      IconInfo
      GtkIconInfo
    >
  { $!ii }

  method new (GtkIconInfo $info) {
    $info ?? self.bless(:$info) !! Nil;
  }

  method new_for_pixbuf (
    GtkIconTheme() $theme,
    GdkPixbuf() $pixbuf
  )
    is also<new-for-pixbuf>
  {
    my $info = gtk_icon_info_new_for_pixbuf($theme, $pixbuf);

    $info ?? self.bless(:$info) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # From gtkiconfactory.h which is now deprecated. This was the best fit.
  # It is a static method.
  proto method size_lookup (|)
    is also<size-lookup>
  { * }

  multi method size_lookup (Int() $size) {
    my @r = samewith($size, $, $, :all);

    @r[0] ?? @r[1, 2] !! Nil;
  }
  multi method size_lookup (
    Int() $size,
    $width is rw,
    $height is rw,
    :$all = False
  ) {
    my gint ($w, $h) = 0 xx 2;
    my guint32 $s = $size;
    my $rv = gtk_icon_size_lookup($s, $w, $h);

    ($width, $height) = ($w, $h);
    $all.not ?? $rv !! ($rv, $width, $height);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy (:$raw = False) {
    my $ii = gtk_icon_info_copy($!ii);

    $ii ??
      ( $raw ?? $ii !! GTK::IconInfo.new($ii) )
      !!
      Nil;
  }

  method free {
    gtk_icon_info_free($!ii);
  }

  method get_attach_points (GdkPoint $points, Int() $n_points)
    is also<get-attach-points>
  {
    my gint $np = $n_points;

    gtk_icon_info_get_attach_points($!ii, $points, $np);
  }

  method get_base_scale
    is also<
      get-base-scale
      base_scale
      base-scale
    >
  {
    gtk_icon_info_get_base_scale($!ii);
  }

  method get_base_size
    is also<
      get-base-size
      base_size
      base-size
    >
  {
    gtk_icon_info_get_base_size($!ii);
  }

  method get_builtin_pixbuf (:$raw = False)
    is also<
      get-builtin-pixbuf
      builtin_pixbuf
      builtin-pixbuf
    >
  {
    my $p = gtk_icon_info_get_builtin_pixbuf($!ii);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil
  }

  method get_display_name
    is also<
      get-display-name
      display_name
      display-name
    >
  {
    gtk_icon_info_get_display_name($!ii);
  }

  method get_embedded_rect (GdkRectangle() $rectangle)
    is also<get-embedded-rect>
  {
    gtk_icon_info_get_embedded_rect($!ii, $rectangle);
  }

  method get_filename
    is also<
      get-filename
      filename
    >
  {
    gtk_icon_info_get_filename($!ii);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_icon_info_get_type, $n, $t );
  }

  method is_symbolic is also<is-symbolic> {
    so gtk_icon_info_is_symbolic($!ii);
  }

  method load_icon (
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<load-icon>
  {
    clear_error;
    my $p = gtk_icon_info_load_icon($!ii, $error);
    set_error($error);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil
  }

  proto method load_icon_async (|)
    is also<load-icon-async>
  { * }

  multi method load_icon_async (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(GCancellable, $callback, $user_data);
  }
  multi method load_icon_async (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    gtk_icon_info_load_icon_async(
      $!ii,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method load_icon_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<load-icon-finish>
  {
    clear_error;
    my $p = gtk_icon_info_load_icon_finish($!ii, $res, $error);
    set_error($error);
    # Throw exception if error.

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil
  }

  method load_surface (
    GdkWindow() $for_window,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-surface>
  {
    clear_error;
    my $s = gtk_icon_info_load_surface($!ii, $for_window, $error);
    set_error($error);

    $s;
  }

  method load_symbolic (
    GdkRGBA $fg,
    GdkRGBA $s_color,
    GdkRGBA $w_color,
    GdkRGBA $e_color,
    $was_symbolic is rw,
    CArray[Pointer[GError]] $error = gerror(),
    :$raw = False
  )
    is also<load-symbolic>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = $was_symbolic;
    $ws = $was_symbolic with $was_symbolic;
    clear_error;
    # Note use of CArray to provide initializable pointer to an uint32.
    my $p = gtk_icon_info_load_symbolic(
      $!ii, $fg, $s_color, $w_color, $e_color, $ws, $error
    );
    set_error($error);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil
  }

  method load_symbolic_async (
    GdkRGBA $fg,
    GdkRGBA $success_color,
    GdkRGBA $warning_color,
    GdkRGBA $error_color,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<load-symbolic-async>
  {
    gtk_icon_info_load_symbolic_async(
      $!ii,
      $fg,
      $success_color,
      $warning_color,
      $error_color,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method load_symbolic_finish (|)
    is also<load-symbolic-finish>
  { * }

  multi method load_symbolic_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    samewith($res, $, $error, :$all, :$raw);
  }
  multi method load_symbolic_finish (
    GAsyncResult() $res,
    $was_symbolic is rw,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    my $ws = CArray[uint32].new;
    $ws[0] = 0;
    clear_error;
    # Note use of CArray to provide initializable pointer to an uint32.
    my $p = gtk_icon_info_load_symbolic_finish($!ii, $res, $ws, $error);
    set_error($error);
    $was_symbolic = $ws[0].so;

    $p = $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;

    $all.not ?? $p !! ($p, $was_symbolic);
  }

  proto method load_symbolic_for_context (|)
    is also<load-symbolic-for-context>
  { * }

  multi method load_symbolic_for_context (
    GtkStyleContext() $context,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False
  ) {
    samewith($context, $, $error, :$all, :$raw);
  }
  multi method load_symbolic_for_context (
    GtkStyleContext() $context,
    $was_symbolic is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False
  ) {
    my $ws = CArray[uint32].new;
    $ws[0] = 0;
    clear_error;
    my $p = gtk_icon_info_load_symbolic_for_context(
      $!ii, $context, $ws, $error
    );
    set_error($error);
    $was_symbolic = $ws[0].so;

    $p = $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;

    $all.not ?? $p !! ($p, $was_symbolic);
  }

  proto method load_symbolic_for_context_async (|)
    is also<load-symbolic-for-context-async>
  { * }

  multi method load_symbolic_for_context_async (
    GtkStyleContext() $context,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($context, GCancellable, $callback, $user_data)
  }
  multi method load_symbolic_for_context_async (
    GtkStyleContext() $context,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    gtk_icon_info_load_symbolic_for_context_async(
      $!ii,
      $context,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method load_symbolic_for_context_finish (|)
    is also<load-symbolic-for-context-finish>
  { * }

  multi method load_symbolic_for_context_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    samewith($res, $, $error, :$all, :$raw);
  }
  multi method load_symbolic_for_context_finish (
    GAsyncResult() $res,
    $was_symbolic is rw,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    my $ws = CArray[uint32].new;
    $ws[0] = 0;
    clear_error;
    my $p = gtk_icon_info_load_symbolic_for_context_finish(
      $!ii, $res, $ws, $error
    );
    set_error($error);
    $was_symbolic = $ws[0].so;

    $p = $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;

    $all.not ?? $p !! ($p, $was_symbolic);
  }

  proto method load_symbolic_for_style (|)
    is also<load-symbolic-for-style>
  { * }

  multi method load_symbolic_for_style (
    GtkStyle() $style,
    Int() $state,               # GtkStateType $state,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    samewith($style, $state, $, $error, :$all, :$raw);
  }
  multi method load_symbolic_for_style (
    GtkStyle() $style,
    Int() $state,               # GtkStateType $state,
    $was_symbolic is rw,
    CArray[Pointer[GError]] $error = gerror(),
    :$all = False,
    :$raw = False
  ) {
    my guint $s = $state;
    my $ws = CArray[uint32].new;

    $ws[0] = 0;
    clear_error;
    my $p = gtk_icon_info_load_symbolic_for_style(
      $!ii, $style, $s, $ws, $error
    );
    set_error($error);
    $was_symbolic = $ws[0].so;

    $p = $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;

    $all.not ?? $p !! ($p, $was_symbolic);
  }

  method set_raw_coordinates (Int() $raw_coordinates)
    is also<set-raw-coordinates>
  {
    my gboolean $rc = $raw_coordinates.so.Int;

    gtk_icon_info_set_raw_coordinates($!ii, $rc);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
