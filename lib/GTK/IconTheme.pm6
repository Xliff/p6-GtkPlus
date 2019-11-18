use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::GList;
use GTK::Compat::Pixbuf;
use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::IconTheme;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::IconInfo;

use GTK::Roles::Signals::Generic;
use GTK::Compat::Roles::ListData;   # Not to be composed in GTK::IconTheme
use GTK::Compat::Roles::Object;

class GTK::IconTheme {
  also does GTK::Roles::Signals::Generic;
  also does GTK::Compat::Roles::Object;

  has GtkIconTheme $!it is implementor;

  submethod BUILD(:$theme) {
    self!setObject($!it = $theme);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::GtkIconTheme
    is also<IconTheme>
    { $!it }

  multi method new (GtkIconTheme $theme) {
    my $o = self.bless(:$theme);
    $o.upref;
    $o;
  }
  multi method new {
    my $theme = gtk_icon_theme_new();
    self.bless(:$theme);
  }

  method get_for_screen(GdkScreen() $screen) is also<get-for-screen> {
    my $theme = gtk_icon_theme_get_for_screen($screen);
    self.bless(:$theme);
  }

  method get_default (GTK::IconTheme:U: ) is also<get-default> {
    self.bless( theme => gtk_icon_theme_get_default() );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkIconTheme, gpointer --> void
  method changed {
    self.connect($!it, 'changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_builtin_icon (Str $name, Int() $size, GdkPixbuf() $pixbuf)
    is also<add-builtin-icon>
  {
    my gint $s = resolve-int($size);
    gtk_icon_theme_add_builtin_icon($name, $s, $pixbuf);
  }

  method add_resource_path (Str() $path) is also<add-resource-path> {
    gtk_icon_theme_add_resource_path($!it, $path);
  }

  method append_search_path (Str() $path) is also<append-search-path> {
    gtk_icon_theme_append_search_path($!it, $path);
  }

  method error_quark is also<error-quark> {
    gtk_icon_theme_error_quark();
  }

  method get_example_icon_name is also<get-example-icon-name> {
    gtk_icon_theme_get_example_icon_name($!it);
  }

  method get_icon_sizes (Str() $icon_name) is also<get-icon-sizes> {
    gtk_icon_theme_get_icon_sizes($!it, $icon_name);
  }

  method has_icon (Str() $icon_name) is also<has-icon> {
    gtk_icon_theme_has_icon($!it, $icon_name);
  }

  method list_contexts is also<list-contexts> {
    GTK::Compat::GList.new( gtk_icon_theme_list_contexts($!it) )
      but GTK::Compat::Roles::ListData[Str];
  }

  method list_icons (Str() $context) is also<list-icons> {
    GTK::Compat::GList.new( gtk_icon_theme_list_icons($!it, $context) )
      but GTK::Compat::Roles::ListData[Str];
  }

  method load_icon (
    Str() $icon_name,
    Int() $size,
    Int() $flags = GTK_ICON_LOOKUP_GENERIC_FALLBACK,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-icon>
  {
    my gint $s = resolve-int($size);
    my guint $f = resolve-uint($flags);
    my $p = gtk_icon_theme_load_icon($!it, $icon_name, $s, $f, $error);
    $p.defined ?? GTK::Compat::Pixbuf.new($p) !! Nil;
  }

  method load_icon_for_scale (
    Str() $name,
    Int() $size,
    Int() $scale,
    Int() $flags,             # GtkIconLookupFlags $flags,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-icon-for-scale>
  {
    my @i = ($size, $scale);
    my gint ($si, $sc) = resolve-int(@i);
    my guint $f = resolve-uint($flags);
    GTK::Compat::Pixbuf.new(
      gtk_icon_theme_load_icon_for_scale($!it, $name, $si, $sc, $f, $error)
    )
  }

  method load_surface (
    Str() $name,
    Int() $size,
    Int() $scale,
    GdkWindow() $fw,
    Int() $flags,             # GtkIconLookupFlags $flags,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-surface>
  {
    my @i = ($size, $scale);
    my gint ($si, $sc) = resolve-int(@i);
    my guint $f = resolve-uint($flags);
    $ERROR = Nil;
    my $rc = gtk_icon_theme_load_surface(
      $!it, $name, $si, $sc, $fw, $f, $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method lookup_by_gicon (
    GIcon $icon,
    Int() $size,
    Int() $flags
  )
    is also<lookup-by-gicon>
  {
    my guint $f = resolve-int($flags);
    my gint $s = resolve-int($size);
    GTK::IconInfo.new(
      gtk_icon_theme_lookup_by_gicon($!it, $icon, $s, $f)
    );
  }

  method lookup_by_gicon_for_scale (
    GIcon $icon,
    Int() $size,
    Int() $scale,
    Int() $flags              # GtkIconLookupFlags $flags,
  )
    is also<lookup-by-gicon-for-scale>
  {
    my @i = ($size, $scale);
    my gint ($si, $sc) = resolve-int(@i);
    my guint $f = resolve-uint($flags);
    GTK::IconInfo.new(
      gtk_icon_theme_lookup_by_gicon_for_scale($!it, $icon, $si, $sc, $f)
    );
  }

  method lookup_icon (
    Str() $icon_name,
    Int() $size,
    Int() $flags              # GtkIconLookupFlags $flags,
  )
    is also<lookup-icon>
  {
    my gint $s = resolve-int($size);
    my guint $f = resolve-uint($flags);
    GTK::IconInfo.new(
      gtk_icon_theme_lookup_icon($!it, $icon_name, $s, $f)
    );
  }

  method lookup_icon_for_scale (
    Str() $icon_name,
    Int() $size,
    Int() $scale,
    Int() $flags              # GtkIconLookupFlags $flags,
  )
    is also<lookup-icon-for-scale>
  {
    my @i = ($size, $scale);
    my gint ($si, $sc) = resolve-int(@i);
    my guint $f = resolve-uint($flags);
    GTK::IconInfo.new(
      gtk_icon_theme_lookup_icon_for_scale($!it, $icon_name, $si, $sc, $f)
    );
  }

  method prepend_search_path (Str() $path) is also<prepend-search-path> {
    gtk_icon_theme_prepend_search_path($!it, $path);
  }

  method rescan_if_needed is also<rescan-if-needed> {
    gtk_icon_theme_rescan_if_needed($!it);
  }

  method set_custom_theme (Str() $theme_name) is also<set-custom-theme> {
    gtk_icon_theme_set_custom_theme($!it, $theme_name);
  }

  method set_screen (GdkScreen() $screen) is also<set-screen> {
    gtk_icon_theme_set_screen($!it, $screen);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
