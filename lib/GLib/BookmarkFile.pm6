use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Raw::BookmarkFile;

class GLib::BookmarkFile {
  has GBookmarkFile $!bp;

  submethod BUILD (:$bookmark) {
    $!bp = $bookmark;
  }

  method GLib::Types::GBookmarkFile
    is also<GBookmarkFile>
  { $!bp }

  method new {
    my $b = g_bookmark_file_new();

    $b ?? self.bless( bookmark => $b ) !! Nil;
  }

  method add_application (Str() $uri, Str() $name, Str() $exec)
    is also<add-application>
  {
    g_bookmark_file_add_application($!bp, $uri, $name, $exec);
  }

  method add_group (Str() $uri, Str() $group) is also<add-group> {
    g_bookmark_file_add_group($!bp, $uri, $group);
  }

  method error_quark ( GLib::BookmarkFile:U: ) is also<error-quark> {
    g_bookmark_file_error_quark();
  }

  method free {
    g_bookmark_file_free($!bp);
  }

  method get_added (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-added>
  {
    g_bookmark_file_get_added($!bp, $uri, $error);
  }

  method get_app_info (
    Str() $uri,
    Str() $name,
    Str() $exec,
    Int() $count,
    Int() $stamp,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-app-info>
  {
    my guint $c = $count;
    my uint64 $s = $stamp;

    clear_error;
    my $rv = g_bookmark_file_get_app_info(
      $!bp, $uri, $name, $exec, $c, $s, $error
    );
    set_error($error);
    so $rv;
  }

  proto method get_appplications (|)
    is also<get-applications>
  { * }

  multi method get_applications (
    Str() $uri,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($uri, $, $error, :$all);
  }
  multi method get_applications (
    Str() $uri,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = CStringArrayToArray(
      g_bookmark_file_get_applications($!bp, $uri, $l, $error)
    );
    set_error($error);
    $length = $l;
    $all.not ?? $rv !! ($rv, $length);
  }

  method get_description (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-description>
  {
    clear_error;
    my $rv = g_bookmark_file_get_description($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  proto method get_groups (|)
    is also<get-groups>
  { * }

  multi method get_groups (
    Str() $uri,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($uri, $, $error, :$all);
  }
  multi method get_groups (
    Str() $uri,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False;
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = CStringArrayToArray(
      g_bookmark_file_get_groups($!bp, $uri, $l, $error)
    );
    set_error($error);
    $length = $l;
    $all.not ?? $rv !! ($rv, $length);
  }

  method get_icon (
    Str() $uri,
    Str() $href,
    Str() $mime_type,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-icon>
  {
    clear_error;
    my $rv = g_bookmark_file_get_icon($!bp, $uri, $href, $mime_type, $error);
    set_error($error);
    $rv;
  }

  method get_is_private (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-is-private>
  {
    clear_error;
    my $rv = so g_bookmark_file_get_is_private($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method get_mime_type (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-mime-type>
  {
    clear_error;
    my $rv = g_bookmark_file_get_mime_type($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method get_modified (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-modified>
  {
    clear_error;
    my $rv = g_bookmark_file_get_modified($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method get_size
    is also<
      get-size
      elems
    >
  {
    g_bookmark_file_get_size($!bp);
  }

  method get_title (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-title>
  {
    clear_error;
    my $rv = g_bookmark_file_get_title($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method get_uris ($length is rw) is also<get-uris> {
    my gsize $l = 0;

    CStringArrayToArray(
      g_bookmark_file_get_uris($!bp, $l)
    );
  }

  method get_visited (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-visited>
  {
    clear_error;
    my $rv = g_bookmark_file_get_visited($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method has_application (
    Str() $uri,
    Str() $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<has-application>
  {
    clear_error;
    my $rv = so g_bookmark_file_has_application($!bp, $uri, $name, $error);
    set_error($error);
    $rv;
  }

  method has_group (
    Str() $uri,
    Str() $group,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<has-group>
  {
    clear_error;
    my $rv = so g_bookmark_file_has_group($!bp, $uri, $group, $error);
    set_error($error);
    $rv;
  }

  method has_item (Str() $uri) is also<has-item> {
    so g_bookmark_file_has_item($!bp, $uri);
  }

  method load_from_data (
    Str() $data,
    Int() $length,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-data>
  {
    my gsize $l = $length;
    clear_error;
    my $rv = g_bookmark_file_load_from_data($!bp, $data, $l, $error);
    set_error($error);
    so $rv;
  }

  method load_from_data_dirs (
    Str() $file,
    Str() $full_path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-data-dirs>
  {
    clear_error;
    my $rv = so g_bookmark_file_load_from_data_dirs(
      $!bp,
      $file,
      $full_path,
      $error
    );
    set_error($error);
    $rv;
  }

  method load_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-file>
  {
    clear_error;
    my $rv = so g_bookmark_file_load_from_file($!bp, $filename, $error);
    set_error($error);
    $rv;
  }

  method move_item (
    Str() $old_uri,
    Str() $new_uri,
    CArray[Pointer[GError]] $error
  )
    is also<move-item>
  {
    clear_error;
    my $rv = so g_bookmark_file_move_item($!bp, $old_uri, $new_uri, $error);
    set_error($error);
    $rv;
  }

  method remove_application (
    Str() $uri,
    Str() $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-application>
  {
    clear_error;
    my $rv = so g_bookmark_file_remove_application($!bp, $uri, $name, $error);
    set_error($error);
    $rv;
  }

  method remove_group (
    Str() $uri,
    Str() $group,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-group>
  {
    clear_error;
    my $rv = so g_bookmark_file_remove_group($!bp, $uri, $group, $error);
    set_error($error);
    $rv;
  }

  method remove_item (
    Str() $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-item>
  {
    clear_error;
    my $rv = so g_bookmark_file_remove_item($!bp, $uri, $error);
    set_error($error);
    $rv;
  }

  method set_added (Str() $uri, Int() $added) is also<set-added> {
    my uint64 $a = $added;

    g_bookmark_file_set_added($!bp, $uri, $a);
  }

  method set_app_info (
    Str() $uri,
    Str() $name,
    Str() $exec,
    Int() $count,
    Int() $stamp,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-app-info>
  {
    my gint $c = $count;
    my uint64 $s = $stamp;

    clear_error;
    my $rv = so g_bookmark_file_set_app_info(
      $!bp,
      $name,
      $exec,
      $c,
      $s,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_description (Str() $uri, Str() $description)
    is also<set-description>
  {
    g_bookmark_file_set_description($!bp, $uri, $description);
  }

  method set_groups (Str() $uri, CArray[Str] $groups, Int() $length)
    is also<set-groups>
  {
    my uint64 $l = $length;

    g_bookmark_file_set_groups($!bp, $uri, $groups, $l);
  }

  method set_icon (Str() $uri, Str() $href, Str() $mime_type)
    is also<set-icon>
  {
    g_bookmark_file_set_icon($!bp, $uri, $href, $mime_type);
  }

  method set_is_private (Str() $uri, Int() $is_private)
    is also<set-is-private>
  {
    my gboolean $i = so $is_private;

    g_bookmark_file_set_is_private($!bp, $uri, $is_private);
  }

  method set_mime_type (Str() $uri, Str() $mime_type) is also<set-mime-type> {
    g_bookmark_file_set_mime_type($!bp, $uri, $mime_type);
  }

  method set_modified (Str() $uri, Int() $modified) is also<set-modified> {
    my uint64 $m = $modified;

    g_bookmark_file_set_modified($!bp, $uri, $m);
  }

  method set_title (Str() $uri, Str() $title) is also<set-title> {

    g_bookmark_file_set_title($!bp, $uri, $title);
  }

  method set_visited (Str() $uri, Int() $visited) is also<set-visited> {
    my uint64 $v = $visited;

    g_bookmark_file_set_visited($!bp, $uri, $v);
  }

  method to_data (
    $length is rw,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<to-data>
  {
    my gsize $l = 0;

    clear_error;
    my $rv = g_bookmark_file_to_data($!bp, $l, $error);
    set_error($error);
    $length = $l;
    $rv;
  }

  method to_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<to-file>
  {
    clear_error;
    my $rv = so g_bookmark_file_to_file($!bp, $filename, $error);
    set_error($error);
    so $rv;
  }

}
