use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::IconTheme;

sub gtk_icon_theme_add_builtin_icon (
  gchar $icon_name,
  gint $size,
  GdkPixbuf $pixbuf
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_add_resource_path (GtkIconTheme $icon_theme, gchar $path)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_append_search_path (GtkIconTheme $icon_theme, gchar $path)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_error_quark ()
  returns GQuark
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_get_default ()
  returns GtkIconTheme
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_get_example_icon_name (GtkIconTheme $icon_theme)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_get_for_screen (GdkScreen $screen)
  returns GtkIconTheme
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_get_icon_sizes (
  GtkIconTheme $icon_theme,
  gchar $icon_name
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_copy (GtkIconInfo $icon_info)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_free (GtkIconInfo $icon_info)
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_attach_points (
  GtkIconInfo $icon_info,
  GdkPoint $points,
  gint $n_points
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_base_scale (GtkIconInfo $icon_info)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_base_size (GtkIconInfo $icon_info)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_builtin_pixbuf (GtkIconInfo $icon_info)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_display_name (GtkIconInfo $icon_info)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_embedded_rect (
  GtkIconInfo $icon_info,
  GdkRectangle $rectangle
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_filename (GtkIconInfo $icon_info)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_is_symbolic (GtkIconInfo $icon_info)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_icon (
  GtkIconInfo $icon_info,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_icon_async (
  GtkIconInfo $icon_info,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_icon_finish (
  GtkIconInfo $icon_info,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_surface (
  GtkIconInfo $icon_info,
  GdkWindow $for_window,
  CArray[Pointer[GError]] $error
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic (
  GtkIconInfo $icon_info,
  GdkRGBA $fg,
  GdkRGBA $success_color,
  GdkRGBA $warning_color,
  GdkRGBA $error_color,
  gboolean $was_symbolic is rw,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_null (
  GtkIconInfo $icon_info,
  GdkRGBA $fg,
  GdkRGBA $success_color,
  GdkRGBA $warning_color,
  GdkRGBA $error_color,
  Pointer,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is symbol('gtk_icon_info_load_symbolic_null')
  is export
  { * }


sub gtk_icon_info_load_symbolic_async (
  GtkIconInfo $icon_info,
  GdkRGBA $fg,
  GdkRGBA $success_color,
  GdkRGBA $warning_color,
  GdkRGBA $error_color,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_finish (
  GtkIconInfo $icon_info,
  GAsyncResult $res,
  gboolean $was_symbolic,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_for_context (
  GtkIconInfo $icon_info,
  GtkStyleContext $context,
  gboolean $was_symbolic,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_for_context_null (
  GtkIconInfo $icon_info,
  GtkStyleContext $context,
  Pointer,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is symbol('gtk_icon_info_load_symbolic_for_context')
  is export
  { * }

sub gtk_icon_info_load_symbolic_for_context_async (
  GtkIconInfo $icon_info,
  GtkStyleContext $context,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_for_context_finish (
  GtkIconInfo $icon_info,
  GAsyncResult $res,
  gboolean $was_symbolic,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_load_symbolic_for_style (
  GtkIconInfo $icon_info,
  GtkStyle $style,
  uint32 $state,                # GtkStateType $state,
  gboolean $was_symbolic,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_new_for_pixbuf (
  GtkIconTheme $icon_theme,
  GdkPixbuf $pixbuf
)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_info_set_raw_coordinates (
  GtkIconInfo $icon_info,
  gboolean $raw_coordinates
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_has_icon (GtkIconTheme $icon_theme, gchar $icon_name)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_list_contexts (GtkIconTheme $icon_theme)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_list_icons (GtkIconTheme $icon_theme, gchar $context)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_load_icon (
  GtkIconTheme $icon_theme,
  gchar $icon_name,
  gint $size,
  uint32 $flags,                # GtkIconLookupFlags $flags,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_load_icon_for_scale (
  GtkIconTheme $icon_theme,
  gchar $icon_name,
  gint $size,
  gint $scale,
  uint32 $flags,                # GtkIconLookupFlags $flags,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_load_surface (
  GtkIconTheme $icon_theme,
  gchar $icon_name,
  gint $size,
  gint $scale,
  GdkWindow $for_window,
  uint32 $flags,                # GtkIconLookupFlags $flags,
  CArray[Pointer[GError]] $error
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_lookup_by_gicon (
  GtkIconTheme $icon_theme,
  GIcon $icon,
  gint $size,
  uint32 $flags                 # GtkIconLookupFlags $flags
)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_lookup_by_gicon_for_scale (
  GtkIconTheme $icon_theme,
  GIcon $icon,
  gint $size,
  gint $scale,
  uint32 $flags                 # GtkIconLookupFlags $flags
)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_lookup_icon (
  GtkIconTheme $icon_theme,
  gchar $icon_name,
  gint $size,
  uint32 $flags                 # GtkIconLookupFlags $flags
)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_lookup_icon_for_scale (
  GtkIconTheme $icon_theme,
  gchar $icon_name,
  gint $size,
  gint $scale,
  uint32 $flags                 # GtkIconLookupFlags $flags
)
  returns GtkIconInfo
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_new ()
  returns GtkIconTheme
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_prepend_search_path (
  GtkIconTheme $icon_theme,
  gchar $path
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_rescan_if_needed (GtkIconTheme $icon_theme)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_set_custom_theme (
  GtkIconTheme $icon_theme,
  gchar $theme_name
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_theme_set_screen (GtkIconTheme $icon_theme, GdkScreen $screen)
  is native(gtk)
  is export
  { * }

# Rescued from deprecated gtkiconfactory.h
sub gtk_icon_size_lookup (
  uint32 $size,                 # GtkIconSize $size,
  gint $width is rw,
  gint $height is rw
)
  is native(gtk)
  is export
  { * }
