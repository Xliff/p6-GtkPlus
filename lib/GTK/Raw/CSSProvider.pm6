use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CSSProvider:ver<3.0.1146>;

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

sub gtk_css_provider_get_named (Str $name, Str $variant)
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
  GtkCSSProvider          $css_provider,
  Str                     $data,
  gssize                  $length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_css_provider_load_from_file (
  GtkCSSProvider          $css_provider,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_css_provider_load_from_path (
  GtkCSSProvider          $css_provider,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_css_provider_load_from_resource (
  GtkCSSProvider $css_provider,
  Str            $resource_path
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
  returns Str
  is native(gtk)
  is export
{ * }
