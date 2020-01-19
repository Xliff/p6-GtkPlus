use v6.c;

use Method::Also;

use GTK::Raw::Types;

role GTK::Roles::StyleProvider {
  has GtkStyleProvider $!sp;

  submethod BUILD(:$style) {
    $!sp = $style;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  method GTK::Raw::Definitions::GtkStyleProvider
    is also<GtkStyleProvider>
  { $!sp }

  method new-styleprovider-obj (GtkStyleProvider $style) {
    $style ?? self.bless( :$style ) !! Nil;
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_style (GtkWidgetPath() $path)
    is DEPRECATED('GTK::StyleProvider.get_style_property')
  {
    gtk_style_provider_get_style($!sp, $path);
  }

  method get_style_property (
    GtkWidgetPath() $path,
    Int() $state,
    GParamSpec() $pspec,
    GValue() $value
  ) {
    my guint $s = $state;

    gtk_style_provider_get_style_property($!sp, $path, $s, $pspec, $value);
  }

  method get_styleprovider_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_style_provider_get_type, $n, $t );
  }

  method get_icon_factory {
    die 'GTK::StyleProvider.get_icon_factory is no longer supported.';
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}


sub gtk_style_provider_get_style (
  GtkStyleProvider $provider,
  GtkWidgetPath $path
)
  returns GtkStyleProperties
  is native(gtk)
  is export
{ * }

sub gtk_style_provider_get_style_property (
  GtkStyleProvider $provider,
  GtkWidgetPath $path,
  uint32 $state,
  GParamSpec $pspec,
  GValue $value
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_style_provider_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }
