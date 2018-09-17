use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CSSProvider;

sub gtk_css_provider_error_quark ()
  returns GQuark
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_get_default ()
  returns GtkCssProvider
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_get_named (gchar $name, gchar $variant)
  returns GtkCssProvider
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_load_from_data (
  GtkCssProvider $css_provider,
  gchar $data,
  gssize $length,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_load_from_file (
  GtkCssProvider $css_provider,
  GFile $file,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_load_from_path (
  GtkCssProvider $css_provider,
  gchar $path,
  GError $error
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_load_from_resource (
  GtkCssProvider $css_provider,
  gchar $resource_path
)
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_new ()
  returns GtkCssProvider
  is native('gtk-3')
  is export
  { * }

sub gtk_css_provider_to_string (GtkCssProvider $provider)
  returns char
  is native('gtk-3')
  is export
  { * }
