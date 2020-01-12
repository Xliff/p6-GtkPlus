use v6.c;

use Method::Also;
use NativeCall;

use GLib::GList;
use GDK::Pixbuf;
use GDK::RGBA;

use GTK::Raw::IconTheme;
use GTK::Raw::Types;

use GTK::IconInfo;

use GTK::Roles::Signals::Generic;
use GLib::Roles::ListData;   # Not to be composed in GTK::IconTheme
use GLib::Roles::Object;

class GTK::IconTheme {
  also does GTK::Roles::Signals::Generic;
  also does GLib::Roles::Object;

  has GtkIconTheme $!it is implementor;

  submethod BUILD(:$theme) {
    self!setObject($!it = $theme);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::GtkIconTheme
    is also<
      GtkIconTheme
      IconTheme
    >
  { $!it }

  multi method new (GtkIconTheme $theme) {
    return unless $theme;
    my $o = self.bless(:$theme);
    $o.upref;
    $o;
  }
  multi method new {
    my $theme = gtk_icon_theme_new();

    $theme ?? self.bless(:$theme) !! Nil;
  }

  method get_for_screen(GdkScreen() $screen) is also<get-for-screen> {
    my $theme = gtk_icon_theme_get_for_screen($screen);

    $theme ?? self.bless(:$theme) !! Nil;
  }

  method get_default (GTK::IconTheme:U: ) is also<get-default> {
    my $theme = gtk_icon_theme_get_default()l

    $theme ?? self.bless(:$theme) !! Nil;
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
    my gint $s = $size;

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
    so gtk_icon_theme_has_icon($!it, $icon_name);
  }

  method list_contexts (:$glist = False) is also<list-contexts> {
    my $sl = gtk_icon_theme_list_contexts($!it);

    return Nil unless $sl;
    return $sl if $glist;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[Str];
    $sl.Array;
  }

  method list_icons (Str() $context, :$glist = False) is also<list-icons> {
    my $sl = gtk_icon_theme_list_icons($!it, $context);

    return Nil unless $sl;
    return $sl if $glist;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[Str];
    $sl.Array;
  }

  method load_icon (
    Str() $icon_name,
    Int() $size,
    Int() $flags = GTK_ICON_LOOKUP_GENERIC_FALLBACK,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<load-icon>
  {
    my gint $s = $size;
    my guint $f = $flags;
    clear_error;
    my $p = gtk_icon_theme_load_icon($!it, $icon_name, $s, $f, $error);
    set_error($error);

    $p.defined ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method load_icon_for_scale (
    Str() $name,
    Int() $size,
    Int() $scale,
    Int() $flags,             # GtkIconLookupFlags $flags,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<load-icon-for-scale>
  {
    my gint ($si, $sc) = ($size, $scale);
    my guint $f = $flags;
    clear_error;
    my $p = gtk_icon_theme_load_icon_for_scale(
      $!it,
      $name,
      $si,
      $sc,
      $f,
      $error
    );
    set_error($error);

    $p.defined ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
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
    my gint ($si, $sc) = ($size, $scale);
    my guint $f = $flags;

    clear_error;
    my $rc = gtk_icon_theme_load_surface(
      $!it, $name, $si, $sc, $fw, $f, $error
    );
    set_error($error);

    $rc;
  }

  method lookup_by_gicon (
    GIcon $icon,
    Int() $size,
    Int() $flags,
    :$raw = False
  )
    is also<lookup-by-gicon>
  {
    my guint $f = $flags;
    my gint $s = $size;
    my $ii = gtk_icon_theme_lookup_by_gicon($!it, $icon, $s, $f);

    $ii ??
      ( $raw ?? $ii !! GTK::IconInfo.new($ii) )
      !!
      Nil;
  }

  method lookup_by_gicon_for_scale (
    GIcon() $icon,
    Int() $size,
    Int() $scale,
    Int() $flags,              # GtkIconLookupFlags $flags,
    :$raw = False
  )
    is also<lookup-by-gicon-for-scale>
  {
    my gint ($si, $sc) = ($size, $scale);
    my guint $f = $flags;

    my $ii = gtk_icon_theme_lookup_by_gicon_for_scale(
      $!it,
      $icon,
      $si,
      $sc,
      $f
    );

    $ii ??
      ( $raw ?? $ii !! GTK::IconInfo.new($ii) )
      !!
      Nil;
  }

  method lookup_icon (
    Str() $icon_name,
    Int() $size,
    Int() $flags,              # GtkIconLookupFlags $flags,
    :$raw = False
  )
    is also<lookup-icon>
  {
    my gint $s = $size;
    my guint $f = $flags;

    my $ii = gtk_icon_theme_lookup_icon($!it, $icon_name, $s, $f);

    $ii ??
      ( $raw ?? $ii !! GTK::IconInfo.new($ii) )
      !!
      Nil;
  }

  method lookup_icon_for_scale (
    Str() $icon_name,
    Int() $size,
    Int() $scale,
    Int() $flags,              # GtkIconLookupFlags $flags,
    :$raw = False
  )
    is also<lookup-icon-for-scale>
  {
    my gint ($si, $sc) = ($size, $scale);
    my guint $f = $flags;

    my $ii = gtk_icon_theme_lookup_icon_for_scale(
      $!it,
      $icon_name,
      $si,
      $sc,
      $f
    );

    $ii ??
      ( $raw ?? $ii !! GTK::IconInfo.new($ii) )
      !!
      Nil;
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
