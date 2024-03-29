use v6.c;

use Method::Also;

use GTK::Raw::RecentFilter:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Buildable:ver<3.0.1146>;
use GLib::Roles::Object;

class GTK::RecentFilter:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::Buildable;

  has GtkRecentFilter $!rf is implementor;

  submethod BUILD(:$filter) {
    self!setObject($!rf = $filter);           # GLib::Roles::Object
    $!b  = cast(GtkBuildable, $!rf);    # GTK::Roles::Buildable
  }

  method GTK::Raw::Definitions::GtkRecentFilter
    is also<
      RecentFilter
      GtkRecentFilter
    >
  { $!rf }

  method new {
    my $filter = gtk_recent_filter_new();

    $filter ?? self.bless(:$filter) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_age (Int() $days) is also<add-age> {
    my gint $d = $days;

    gtk_recent_filter_add_age($!rf, $d);
  }

  method add_application (Str() $application) is also<add-application> {
    gtk_recent_filter_add_application($!rf, $application);
  }

  method add_custom (
    Int() $needed,
    &func,
    gpointer $data               = gpointer,
    GDestroyNotify $data_destroy = GDestroyNotify
  )
    is also<add-custom>
  {
    my guint $n = $needed;

    gtk_recent_filter_add_custom($!rf, $n, &func, $data, $data_destroy);
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

  method filter (GtkRecentFilterInfo() $filter_info) {
    gtk_recent_filter_filter($!rf, $filter_info);
  }

  method get_needed is also<get-needed> {
    gtk_recent_filter_get_needed($!rf);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_filter_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
