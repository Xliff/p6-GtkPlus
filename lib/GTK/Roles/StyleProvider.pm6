use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::Object;

role GTK::Roles::StyleProvider:ver<3.0.1146> {
  has GtkStyleProvider $!sp is implementor;

  method roleInit-GtkStyleProvider {
    return if $!sp;

    my \i = findProperImplementor(self.^attributes);
    $!sp  = cast( GtkStyleProvider, i.get_value(self) )
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

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_style (GtkWidgetPath() $path)
    is DEPRECATED('GTK::StyleProvider.get_style_property')
  {
    gtk_style_provider_get_style($!sp, $path);
  }

  method get_style_property (
    GtkWidgetPath() $path,
    Int()           $state,
    GParamSpec()    $pspec,
    GValue()        $value
  ) {
    my guint $s = $state;

    gtk_style_provider_get_style_property($!sp, $path, $s, $pspec, $value);
  }

  method get_gtkstyleprovider_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_style_provider_get_type, $n, $t );
  }

  method get_icon_factory {
    die 'GTK::StyleProvider.get_icon_factory is no longer supported.';
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

our subset GtkStyleProviderAncestry is export of Mu
  where GtkStyleProvider | GObject;

class GTK::StyleProvider:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::StyleProvider;

  submethod BUILD ( :$gtk-style-provider ) {
    self.setGtkStyleProvider($gtk-style-provider) if $gtk-style-provider;
  }

  method setGtkStyleProvider (GtkStyleProviderAncestry $_) {
    my $to-parent;

    $!sp = do {
      when GtkStyleProvider {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkStyleProvider, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (GtkStyleProviderAncestry $gtk-style-provider, :$ref = True) {
    return Nil unless $gtk-style-provider;

    my $o = self.bless( :$gtk-style-provider );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.get_gtkstyleprovider_type;
  }

}

sub gtk_style_provider_get_style (
  GtkStyleProvider $provider,
  GtkWidgetPath    $path
)
  returns GtkStyleProperties
  is native(gtk)
  is export
{ * }

sub gtk_style_provider_get_style_property (
  GtkStyleProvider $provider,
  GtkWidgetPath    $path,
  uint32           $state,
  GParamSpec       $pspec,
  GValue           $value
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
