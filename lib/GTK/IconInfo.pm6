use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::IconTheme;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::IconInfo {
  also does GTK::Roles::Types;

  has GtkIconInfo $!ii;

  submethod BUILD(:$info) {
    $!ii = $info;
  }

  method new (GtkIconInfo $info) {
    self.bless(:$info);
  }

  method new_for_pixbuf (GtkIconTheme() $theme, GdkPixbuf() $pixbuf) {
    my $info = gtk_icon_info_new_for_pixbuf($theme, $pixbuf);
    self.bless(:$info);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gtk_icon_info_copy($!ii);
  }

  method free {
    gtk_icon_info_free($!ii);
  }

  method get_attach_points (GdkPoint $points, gint $n_points) {
    gtk_icon_info_get_attach_points($!ii, $points, $n_points);
  }

  method get_base_scale {
    gtk_icon_info_get_base_scale($!ii);
  }

  method get_base_size {
    gtk_icon_info_get_base_size($!ii);
  }

  method get_builtin_pixbuf {
    gtk_icon_info_get_builtin_pixbuf($!ii);
  }

  method get_display_name {
    gtk_icon_info_get_display_name($!ii);
  }

  method get_embedded_rect (GdkRectangle() $rectangle) {
    gtk_icon_info_get_embedded_rect($!ii, $rectangle);
  }

  method get_filename {
    gtk_icon_info_get_filename($!ii);
  }

  method get_type {
    gtk_icon_info_get_type();
  }

  method is_symbolic {
    gtk_icon_info_is_symbolic($!ii);
  }

  method load_icon (
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_icon($!ii, $error);
  }

  method load_icon_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
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
  ) {
    gtk_icon_info_load_icon_finish($!ii, $res, $error);
  }

  method load_surface (
    GdkWindow $for_window,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_surface($!ii, $for_window, $error);
  }

  method load_symbolic (
    GdkRGBA $fg,
    GdkRGBA $success_color,
    GdkRGBA $warning_color,
    GdkRGBA $error_color,
    gboolean $was_symbolic,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_symbolic(
      $!ii,
      $fg,
      $success_color,
      $warning_color,
      $error_color,
      $was_symbolic,
      $error
    );
  }

  method load_symbolic_async (
    GdkRGBA $fg,
    GdkRGBA $success_color,
    GdkRGBA $warning_color,
    GdkRGBA $error_color,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
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
    gboolean $was_symbolic,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_symbolic_finish($!ii, $res, $was_symbolic, $error);
  }

  method load_symbolic_for_context (
    GtkStyleContext $context,
    gboolean $was_symbolic,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_symbolic_for_context(
      $!ii,
      $context,
      $was_symbolic,
      $error
    );
  }

  method load_symbolic_for_context_async (
    GtkStyleContext $context,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
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
    gboolean $was_symbolic,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gtk_icon_info_load_symbolic_for_context_finish(
      $!ii,
      $res,
      $was_symbolic,
      $error
    );
  }

  method load_symbolic_for_style (
    GtkStyle() $style,
    Int() $state,               # GtkStateType $state,
    gboolean $was_symbolic,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $s = self.RESOLVE-UINT($state);
    gtk_icon_info_load_symbolic_for_style(
      $!ii,
      $style,
      $s,
      $was_symbolic,
      $error
    );
  }

  method set_raw_coordinates (gboolean $raw_coordinates) {
    gtk_icon_info_set_raw_coordinates($!ii, $raw_coordinates);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
