use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::CSSProvider;
use GTK::Raw::Types;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::CSSProvider;
use GTK::Roles::StyleProvider;
use GTK::Roles::Types;

class GTK::CSSProvider {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::CSSProvider;
  also does GTK::Roles::StyleProvider;
  also does GTK::Roles::Types;

  has GtkCSSProvider $!css;

  submethod BUILD(
    :$provider,
    :$priority is copy,
    :$pod,
    :$style-data
  ) {
    $priority //= GTK_STYLE_PROVIDER_PRIORITY_USER.Int;
    die q:to/D/ unless $priority.^can('Int').elems;
  Prority must be a GtkStyleProviderPriority or an integer compatible value
  D

    $!css = $provider;
    my uint32 $p = self.RESOLVE-UINT($priority);
    my $display = gdk_display_get_default();
    my $screen = gdk_display_get_default_screen($display);
    gtk_style_context_add_provider_for_screen($screen, $!css, $p);

    my %sections;
    my $css = $style-data;
    with $pod {
      for $pod.grep( *.name eq 'css' ).Array {
        # This may not always be true. Keep up with POD spec!
        %sections{ .name } //= $_.contents.map( *.contents[0] ).join("\n");
        last when %sections<css>.defined && %sections<ui>.defined;
      }
      $css ~= %sections<css>;
    }
    self.load_from_data($_) with $css;
    $!sp = nativecast(GtkStyleProvider, $!css);   # GTK::Roles::StyleProvider
  }

  submethod DESTROY {
    self.disconnect-all($_)  for %!signals-css;
  }

  method new(:$priority, :$pod) {
    my $provider = gtk_css_provider_new();
    self.bless(:$provider, :$priority, :$pod);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCssProvider, GtkCssSection, CArray[Pointer[GError]], gpointer --> void
  method parsing-error is also<parsing_error> {
    self.connect-parsing-error($!css);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method error_quark is also<error-quark> {
    gtk_css_provider_error_quark();
  }

  # method get_default {
  #   gtk_css_provider_get_default();
  # }

  method get_named (Str() $name, Str() $variant) is also<get-named> {
    gtk_css_provider_get_named($name, $variant);
  }

  method get_type is also<get-type> {
    gtk_css_provider_get_type();
  }

  method load_from_data (
    Str() $data,
    Int() $length = -1,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-data>
  {
    my gssize $l = $length;
    gtk_css_provider_load_from_data($!css, $data, $l, $error);
  }

  method load_from_file (
    GFile $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-file>
  {
    gtk_css_provider_load_from_file($!css, $file, $error);
  }

  method load_from_path (
    Str() $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-path>
  {
    gtk_css_provider_load_from_path($!css, $path, $error);
  }

  method load_from_resource (Str() $resource_path)
    is also<load-from-resource>
  {
    gtk_css_provider_load_from_resource($!css, $resource_path);
  }

  method to_string is also<to-string> {
    gtk_css_provider_to_string($!css);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
