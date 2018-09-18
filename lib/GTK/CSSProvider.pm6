use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CSSProvider;
use GTK::Raw::Types;

class GTK::CSSProvider {
  has GtkCSSProvider $!css;

  submethod BUILD(
    :$provider,
    :$priority
  ) {
    my uint32 $p = do given $priority {
      when GtkStyleProviderPriority { .Int; }
      when Int                      { $_;   }
      when not .defined             { GTK_STYLE_PROVIDER_PRIORITY_APPLICATION.Int; }
      default {
        die "Invalid type passed as \$priority: { .^name }. Must be Int or GtkStyleProviderPriority";
      }
    } +& 0xffff;

    $!css = $provider;
    my $display = gdk_display_get_default();
    my $screen = gdk_display_get_default_screen($display);
    gtk_style_context_add_provider_for_screen($screen, $!css, $p);
  }

  method new(:$priority) {
    my $provider = gtk_css_provider_new();
    self.bless(:$provider, :$priority);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  # method error_quark {
  #   gtk_css_provider_error_quark($!css);
  # }

  # method get_default {
  #   gtk_css_provider_get_default();
  # }

  method get_named (gchar $name, gchar $variant) {
    gtk_css_provider_get_named($name, $variant);
  }

  method get_type {
    gtk_css_provider_get_type();
  }

  method load_from_data (
    gchar $data,
    Int() $length = -1,
    GError $error = GError
  ) {
    my gssize $l = $length;
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
