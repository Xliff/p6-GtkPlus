use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::RecentInfo;

use GLib::Roles::Object;
use GIO::Roles::Icon;

# STRUCT
class GTK::RecentInfo {
  has GtkRecentInfo $!ri is implementor;

  submethod BUILD (:$info) {
    $!ri = $info;
  }

  method new (GtkRecentInfo $info) {
    $info ?? self.bless( :$info ) !! Nil;
  }

  method create_app_info (
    Str() $app_name,
    CArray[Pointer[GError]] $error = gerror(),
    :$raw = False
  )
    is also<create-app-info>
  {
    clear_error;
    my $rc = gtk_recent_info_create_app_info($!ri, $app_name, $error);
    set_error($error);

    $rc ??
      ( $raw ?? $rc !! GLib::AppInfo.new($rc) )
      !!
      Nil;
  }

  method exists {
    so gtk_recent_info_exists($!ri);
  }

  method get_added
    is also<
      get-added
      added
    >
  {
    gtk_recent_info_get_added($!ri);
  }

  method get_age
    is also<
      get-age
      age
    >
  {
    gtk_recent_info_get_age($!ri);
  }

  method get_application_info (
    Str() $app_name,
    Str() $app_exec,
    Int() $count,
    Int() $time
  )
    is also<get-application-info>
  {
    my guint $c = $count;
    my uint64 $t = $time;

    gtk_recent_info_get_application_info($!ri, $app_name, $app_exec, $c, $t);
  }

  proto method get_application (|)
    is also<get-applications>
  { * }

  multi method get_applications is also<applications> {
    samewith($);
  }
  multi method get_applications ($length is rw) {
    my uint64 $l = 0;
    my CArray[Str] $apps = gtk_recent_info_get_applications($!ri, $l);

    CArrayToArray($apps, $length = $l)
  }

  method get_description
    is also<
      get-description
      description
    >
  {
    gtk_recent_info_get_description($!ri);
  }

  method get_display_name
    is also<
      get-display-name
      display_name
      display-name
    >
  {
    gtk_recent_info_get_display_name($!ri);
  }

  method get_gicon (:$raw = False)
    is also<
      get-gicon
      gicon
    >
  {
    my $icon = gtk_recent_info_get_gicon($!ri);

    $icon ??
      ( $raw ?? $icon !! GLib::Roles::Icon.new-icon-obj($icon) )
      !!
      Nil;
  }

  proto method get_groups (|)
    is also<get-groups>
  { * }

  multi method get_groups is also<groups> {
    samewith($);
  }
  multi method get_groups (Int() $length is rw)  {
    my gsize $l = 0;
    my CArray[Str] $g = gtk_recent_info_get_groups($!ri, $l);

    CStringArrayToArray($g, $length = $l);
  }

  method get_icon (Int() $size, :$raw = False) is also<get-icon> {
    my gint $s = $size;
    my $p = gtk_recent_info_get_icon($!ri, $s);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_mime_type
    is also<
      get-mime-type
      mime_type
      mime-type
    >
  {
    gtk_recent_info_get_mime_type($!ri);
  }

  method get_modified
    is also<
      get-modified
      modified
    >
  {
    gtk_recent_info_get_modified($!ri);
  }

  method get_private_hint
    is also<
      get-private-hint
      private_hint
      private-hint
    >
  {
    so gtk_recent_info_get_private_hint($!ri);
  }

  method get_short_name
    is also<
      get-short-name
      short_name
      short-name
    >
  {
    gtk_recent_info_get_short_name($!ri);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_info_get_type, $n, $t );
  }

  method get_uri
    is also<
      get-uri
      uri
    >
  {
    gtk_recent_info_get_uri($!ri);
  }

  method get_uri_display
    is also<
      get-uri-display
      uri_display
      uri-display
    >
  {
    gtk_recent_info_get_uri_display($!ri);
  }

  method get_visited
    is also<
      get-visited
      visited
    >
  {
    gtk_recent_info_get_visited($!ri);
  }

  method has_application (Str() $app_name) is also<has-application> {
    so gtk_recent_info_has_application($!ri, $app_name);
  }

  method has_group (Str() $group_name) is also<has-group> {
    so gtk_recent_info_has_group($!ri, $group_name);
  }

  method is_local is also<is-local> {
    so gtk_recent_info_is_local($!ri);
  }

  method last_application is also<last-application> {
    gtk_recent_info_last_application($!ri);
  }

  method match (GtkRecentInfo() $info_b) {
    gtk_recent_info_match($!ri, $info_b);
  }

  method ref is also<upref> {
    gtk_recent_info_ref($!ri);
  }

  method unref is also<downref> {
    gtk_recent_info_unref($!ri);
  }

}

multi sub infix:<eqv> (GTK::RecentInfo $a, GTK::RecentInfo $b) is export {
  $a.match($b);
}
multi sub infix:<eqv> (GtkRecentInfo $a, GtkRecentInfo $b) is export {
  so gtk_recent_info_match($a, $b);
}
