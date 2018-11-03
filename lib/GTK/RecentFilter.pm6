use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::RecentFilter;
use GTK::Raw::Types;

use GTK::Roles::Buildable;

class GTK::RecentFilter {
  also does GTK::Roles::Buildable;

  has GtkRecentFilter $!rf;

  submethod BUILD(:$filter) {
    $!rf = $filter;
    $!b  = nativecast(GtkBuildable, $!rf); # GTK::Roles::Buildable
  }

  method new {
    my $filter = gtk_recent_filter_new();
    self.bless(:$filter);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_age (Int() $days) is also<add-age> {
    my gint $d = self.RESOLVE-INT($days);
    gtk_recent_filter_add_age($!rf, $d);
  }

  method add_application (Str() $application) is also<add-application> {
    gtk_recent_filter_add_application($!rf, $application);
  }

  method add_custom (
    GtkRecentFilterFlags $needed,
    GtkRecentFilterFunc $func,
    gpointer $data = gpointer,
    GDestroyNotify $data_destroy = GDestroyNotify
  ) is also<add-custom> {
    gtk_recent_filter_add_custom($!rf, $needed, $func, $data, $data_destroy);
  }

  method add_group (Str() $group) is also<add-group> {
    gtk_recent_filter_add_group($!rf, $group);
  }

  method add_mime_type (Str() $mime_type) is also<add-mime-type> {
    gtk_recent_filter_add_mime_type($!rf, $mime_type);
  }

  method add_pattern (Str() $pattern) is also<add-pattern> {
    gtk_recent_filter_add_pattern($!rf, $pattern);
  }

  method add_pixbuf_formats is also<add-pixbuf-formats> {
    gtk_recent_filter_add_pixbuf_formats($!rf);
  }

  method filter (GtkRecentFilterInfo $filter_info) {
    gtk_recent_filter_filter($!rf, $filter_info);
  }

  method get_needed is also<get-needed> {
    gtk_recent_filter_get_needed($!rf);
  }

  method get_type is also<get-type> {
    gtk_recent_filter_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

