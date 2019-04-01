use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::IconTheme;
use GTK::Raw::Types;

use GTK::Compat::Pixbuf;

use GTK::Compat::Roles::Object;
use GTK::Roles::Types;

# Opaque struct

class GTK::IconInfo {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Types;

  has GtkIconInfo $!ii;

  submethod BUILD(:$info) {
    self!setObject($!ii = $info);             # GTK::Compat::Roles::Object
  }
  
  method GTK::Raw::Types::GtkIconInfo
    is also<IconInfo>
    { $!ii }

  method new (GtkIconInfo $info) {
    self.bless(:$info);
  }

  method new_for_pixbuf (
    GtkIconTheme() $theme,
    GdkPixbuf() $pixbuf
  )
    is also<new-for-pixbuf>
  {
    my $info = gtk_icon_info_new_for_pixbuf($theme, $pixbuf);
    self.bless(:$info);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # From gtkiconfactory.h which is now deprecated. This was the best fit.
  # It is a static method.
  proto method size_lookup (|) is also<size-lookup> { * }

  multi method size_lookup (Int() $size) {
    my Int ($w, $h);
    samewith($size, $w, $h);
    ($w, $h);
  }
  multi method size_lookup (
    Int() $size,
    Int() $width is rw,
    Int() $height is rw
  ) {
    my gint ($w, $h);
    my guint32 $s = self.RESOLVE-UINT($size);
    my $rc = gtk_icon_size_lookup($s, $w, $h);
    ($width, $height) = ($rc ?? $w !! Nil, $rc ?? $h !! Nil);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_icon_info_copy($!ii);
  }

  method free {
    gtk_icon_info_free($!ii);
  }

  method get_attach_points (GdkPoint $points, Int() $n_points)
    is also<get-attach-points>
  {
    my gint $np = self.RESOLVE-INT($n_points);
    gtk_icon_info_get_attach_points($!ii, $points, $np);
  }

  method get_base_scale is also<get-base-scale> {
    gtk_icon_info_get_base_scale($!ii);
  }

  method get_base_size is also<get-base-size> {
    gtk_icon_info_get_base_size($!ii);
  }

  method get_builtin_pixbuf is also<get-builtin-pixbuf> {
    GTK::Compat::Pixbuf.new( gtk_icon_info_get_builtin_pixbuf($!ii) );
  }

  method get_display_name is also<get-display-name> {
    gtk_icon_info_get_display_name($!ii);
  }

  method get_embedded_rect (GdkRectangle $rectangle)
    is also<get-embedded-rect>
  {
    gtk_icon_info_get_embedded_rect($!ii, $rectangle);
  }

  method get_filename is also<get-filename> {
    gtk_icon_info_get_filename($!ii);
  }

  method get_type is also<get-type> {
    gtk_icon_info_get_type();
  }

  method is_symbolic is also<is-symbolic> {
    gtk_icon_info_is_symbolic($!ii);
  }

  method load_icon (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-icon>
  {
    GTK::Compat::Pixbuf.new( gtk_icon_info_load_icon($!ii, $error) );
  }

  method load_icon_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<load-icon-async>
  {
    gtk_icon_info_load_icon_async(
      $!ii,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method load_icon_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-icon-finish>
  {
    $ERROR = Nil;
    my $o = gtk_icon_info_load_icon_finish($!ii, $res, $error);
    $ERROR = $error[0] with $error[0];
    # Throw exception if error.
    GTK::Compat::Pixbuf.new($o) without $ERROR;
  }

  method load_surface (
    GdkWindow() $for_window,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-surface>
  {
    $ERROR = Nil;
    my $s = gtk_icon_info_load_surface($!ii, $for_window, $error);
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    $s without $ERROR;
  }

  method load_symbolic (
    GdkRGBA $fg,
    GdkRGBA $s_color,
    GdkRGBA $w_color,
    GdkRGBA $e_color,
    Int() $was_symbolic = False,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-symbolic>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = self.RESOLVE-BOOL($was_symbolic);
    $ws = self.RESOLVE-BOOL($was_symbolic) with $was_symbolic;
    $ERROR = Nil;
    # Note use of CArray to provide initializable pointer to an uint32.
    my $s = gtk_icon_info_load_symbolic(
      $!ii, $fg, $s_color, $w_color, $e_color, $ws, $error
    );
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    GTK::Compat::Pixbuf.new($s) without $ERROR;
  }

  method load_symbolic_async (
    GdkRGBA $fg,
    GdkRGBA $success_color,
    GdkRGBA $warning_color,
    GdkRGBA $error_color,
    GCancellable $cancellable,
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

  method load_symbolic_finish (
    GAsyncResult $res,
    Int() $was_symbolic = False,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-symbolic-finish>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = self.RESOLVE-BOOL($was_symbolic);
    $ERROR = Nil;
    # Note use of CArray to provide initializable pointer to an uint32.
    my $s = gtk_icon_info_load_symbolic_finish($!ii, $res, $ws, $error);
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    GTK::Compat::Pixbuf.new($s) without $ERROR;
  }

  method load_symbolic_for_context (
    GtkStyleContext() $context,
    Int() $was_symbolic = False,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-symbolic-for-context>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = self.RESOLVE-BOOL($was_symbolic);
    $ERROR = Nil;
    my $s = gtk_icon_info_load_symbolic_for_context(
      $!ii, $context, $ws, $error
    );
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    GTK::Compat::Pixbuf.new($s) without $ERROR;
  }

  method load_symbolic_for_context_async (
    GtkStyleContext() $context,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<load-symbolic-for-context-async>
  {
    gtk_icon_info_load_symbolic_for_context_async(
      $!ii,
      $context,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method load_symbolic_for_context_finish (
    GAsyncResult $res,
    Int() $was_symbolic = False,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-symbolic-for-context-finish>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = self.RESOLVE-BOOL($was_symbolic);
    $ERROR = Nil;
    my $s = gtk_icon_info_load_symbolic_for_context_finish(
      $!ii, $res, $ws, $error
    );
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    GTK::Compat::Pixbuf.new($s) without $ERROR;
  }

  method load_symbolic_for_style (
    GtkStyle() $style,
    Int() $state,               # GtkStateType $state,
    Int() $was_symbolic,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<load-symbolic-for-style>
  {
    my $ws = CArray[uint32].new;
    $ws[0] = self.RESOLVE-BOOL($was_symbolic);
    my guint $s = self.RESOLVE-UINT($state);
    $ERROR = Nil;
    my $o = gtk_icon_info_load_symbolic_for_style(
      $!ii, $style, $s, $ws, $error
    );
    $ERROR = $error[0] with $error[0];
    # Throw exception if $ERROR
    GTK::Compat::Pixbuf.new($o) without $ERROR;
  }

  method set_raw_coordinates (Int() $raw_coordinates)
    is also<set-raw-coordinates>
  {
    my gboolean $rc = self.RESOLVE-BOOL($raw_coordinates);
    gtk_icon_info_set_raw_coordinates($!ii, $rc);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
