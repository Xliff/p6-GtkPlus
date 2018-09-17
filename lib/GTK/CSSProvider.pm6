use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CSSProvider;
use GTK::Raw::Types

class GTK::CSSProvider {
  has GtkProvider $!css;

  submethod BUILD(:$provider) {
    $!css = $provider;
  }

  method new {
    my $provider = gtk_css_provider_new();
    self.bless(:$provider);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method error_quark {
    gtk_css_provider_error_quark($!css);
  }

  method get_default {
    gtk_css_provider_get_default($!css);
  }

  method get_named (gchar $variant) {
    gtk_css_provider_get_named($!css, $variant);
  }

  method get_type {
    gtk_css_provider_get_type();
  }

  method load_from_data (gchar $data, Int() $length, GError $error) {
    my guint $l = $length;
    gtk_css_provider_load_from_data($!css, $data, $l, $error);
  }

  method load_from_file (GFile $file, GError $error) {
    gtk_css_provider_load_from_file($!css, $file, $error);
  }

  method load_from_path (gchar $path, GError $error) {
    gtk_css_provider_load_from_path($!css, $path, $error);
  }

  method load_from_resource (gchar $resource_path) {
    gtk_css_provider_load_from_resource($!css, $resource_path);
  }

  method to_string {
    gtk_css_provider_to_string($!css);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
