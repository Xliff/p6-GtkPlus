use v6.c;

use Method::Also;
use NativeCall;

use GDK::Screen;
use GTK::Raw::CSSProvider;
use GTK::Raw::StyleContext;
use GTK::Raw::Types;

use GLib::Roles::Object;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::CSSProvider;
use GTK::Roles::StyleProvider;
use GTK::Roles::Types;

class GTK::CSSProvider {
  also does GLib::Roles::Object;

  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::CSSProvider;
  also does GTK::Roles::StyleProvider;
  also does GTK::Roles::Types;

  has GtkCSSProvider $!css is implementor;

  submethod BUILD(
    :$provider,
    :$priority is copy,
    :$pod,
    :$style
  ) {
    $priority //= GTK_STYLE_PROVIDER_PRIORITY_USER.Int;
    die q:to/D/ unless $priority.^can('Int').elems;
  Prority must be a GtkStyleProviderPriority or an integer compatible value
  D

    # GTK::Roles::StyleProvider
    $!sp = nativecast(GtkStyleProvider, $!css = $provider);
    # GLib::Roles::Object
    self!setObject($provider);

    my uint32 $p = $priority;
    my $screen = GDK::Screen.get_default.screen;
    gtk_style_context_add_provider_for_screen($screen, $!sp, $p);

    my %sections;
    my $css = $style;
    with $pod {
      for $pod.grep( *.name eq 'css' ).Array {
        # This may not always be true. Keep up with POD spec!
        %sections{ .name } //= $_.contents.map( *.contents[0] ).join("\n");
        last when %sections<css>.defined;
      }
      $css ~= %sections<css>;
    }
    self.load_from_data($css) if $css.defined;
  }

  submethod DESTROY {
    self.disconnect-all($_)  for %!signals-css;
  }

  multi method new (GtkCSSProvider $provider) {
    $provider ?? self.bless(:$provider) !! Nil;
  }
  multi method new(:$style, :$priority, :$pod) {
    my $provider = gtk_css_provider_new();

    $provider ?? self.bless(:$provider, :$priority, :$pod, :$style) !! Nil;
  }

  method get_named (Str() $name, Str() $variant) is also<get-named> {
    my $provider = gtk_css_provider_get_named($name, $variant);

    $provider ?? GTK::CSSProvider.new($provider) !! Nil;
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

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_css_provider_get_type, $n, $t );
  }

  method load_from_data (
    Str() $data,
    Int() $length = -1,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-data>
  {
    clear_error;
    my gssize $l = $length;
    my $rc = gtk_css_provider_load_from_data($!css, $data, $l, $error);
    set_error($error);
    $rc;
  }

  method load_from_file (
    GFile() $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-file>
  {
    clear_error;
    my $rc = so gtk_css_provider_load_from_file($!css, $file, $error);
    set_error($error);
    $rc;
  }

  method load_from_path (
    Str() $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-path>
  {
    clear_error;
    my $rc = so gtk_css_provider_load_from_path($!css, $path, $error);
    set_error($error);
    $rc;
  }

  method load_from_resource (Str() $resource_path)
    is also<load-from-resource>
  {
    so gtk_css_provider_load_from_resource($!css, $resource_path);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gtk_css_provider_to_string($!css);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
