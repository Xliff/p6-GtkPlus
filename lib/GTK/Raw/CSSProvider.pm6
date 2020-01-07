use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::CSSProvider;

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
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_file (
  GtkCSSProvider $css_provider,
  GFile $file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_css_provider_load_from_path (
  GtkCSSProvider $css_provider,
  gchar $path,
  CArray[Pointer[GError]] $error
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
