use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CSSProvider;

sub gdk_display_get_default()
  returns GdkDisplay
  is native('gdk-3')
  is export
  { * }

sub gdk_display_get_default_screen(GdkDisplay $display)
  returns GdkScreen
  is native('gdk-3')
  is export
  { * }

sub gtk_style_context_add_provider_for_screen(
  GdkScreen $screen,
  GdkStyleProvider $provider,
  guint $priority
)
  is native(gtk)
  is export
  { * }


sub gtk_css_provider_error_quark ()
  returns GQuark
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_get_default ()
  returns GtkCSSProvider
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_get_named (gchar $name, gchar $variant)
  returns GtkCSSProvider
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_data (
  GtkCSSProvider $css_provider,
  gchar $data,
  gssize $length,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_file (
  GtkCSSProvider $css_provider,
  GFile $file,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_path (
  GtkCSSProvider $css_provider,
  gchar $path,
  GError $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_resource (
  GtkCSSProvider $css_provider,
  gchar $resource_path
)
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_new ()
  returns GtkCSSProvider
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_to_string (GtkCSSProvider $provider)
  returns gchar
  is native(gtk)
  is export
  { * }