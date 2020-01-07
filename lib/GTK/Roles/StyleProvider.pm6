use v6.c;

use NativeCall;


use GTK::Raw::Types;

sub gtk_style_provider_get_style (GtkStyleProvider $provider, GtkWidgetPath $path)
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

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_style (GtkWidgetPath() $path)
    is DEPRECATED('GTK::StyleProvider.get_style_property')
  {
    gtk_style_provider_get_style($!sp, $path);
  }

  method get_style_property (
    GtkWidgetPath() $path,
    Int() $state,
    GParamSpec $pspec,
    GValue() $value
  ) {
    my guint $s = self.RESOLVE-UINT($state);
    gtk_style_provider_get_style_property($!sp, $path, $s, $pspec, $value);
  }

  method get_type {
    gtk_style_provider_get_type();
  }

  method get_icon_factory {
    die 'GTK::StyleProvider.get_icon_factory is no longer supported.';
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
