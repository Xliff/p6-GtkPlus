use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::BookmarkFile;

class GTK::Compat::BookmarkFile {
  has GBookmarkFile $!bp;
  
  submethod BUILD (:$bookmark) {
    $!bp = $bookmark;
  }
  
  method new {
    self.bless( bookmark => g_bookmark_file_new() );
  }
  
  method add_application (Str() $uri, Str() $name, Str() $exec) {
    g_bookmark_file_add_application($!bp, $uri, $name, $exec);
  }

  method add_group (Str() $uri, Str() $group) {
    g_bookmark_file_add_group($!bp, $uri, $group);
  }

  method error_quark ( GTK::Compat::BookmarkFile:U: ) {
    g_bookmark_file_error_quark();
  }

  method free {
    g_bookmark_file_free($!bp);
  }

  method get_added (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_added($!bp, $uri, $error);
  }

  method get_app_info (
    Str() $uri, 
    Str() $name, 
    Str() $exec, 
    Int() $count, 
    Int() $stamp, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $c = resolve-uint($count);
    my uint64 $s = resolve-uint64($stamp);
    clear_error;
    my $rc = g_bookmark_file_get_app_info(
      $!bp, $uri, $name, $exec, $c, $s, $error
    );
    set_error($error);
    so $rc;
  }

  method get_applications (
    Str() $uri, 
    $length is rw, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $l = 0;
    my $a = g_bookmark_file_get_applications($!bp, $uri, $l, $error);
    my @a;
    @a.push: $a[$_] for ^$l;
    $length = $l;
    @a;
  }

  method get_description (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_description($!bp, $uri, $error);
  }

  method get_groups (
    Str() $uri, 
    $length is rw, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $l = 0;
    my $g = g_bookmark_file_get_groups($!bp, $uri, $l, $error);
    my @g;
    @g.push: $g[$_] for ^$l;
    $length = $l;
    @g;
  }

  method get_icon (
    Str() $uri, 
    Str() $href, 
    Str() $mime_type, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_icon($!bp, $uri, $href, $mime_type, $error);
  }

  method get_is_private (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_is_private($!bp, $uri, $error);
  }

  method get_mime_type (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_mime_type($!bp, $uri, $error);
  }

  method get_modified (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_modified($!bp, $uri, $error);
  }

  method get_size {
    g_bookmark_file_get_size($!bp);
  }

  method get_title (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_title($!bp, $uri, $error);
  }

  method get_uris ($length is rw) {
    my gsize $l = 0;
    my $u = g_bookmark_file_get_uris($!bp, $l);
    my @u;
    @u.push: $u[$_] for ^$l;
    $length = $l;
    @u;
  }

  method get_visited (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_get_visited($!bp, $uri, $error);
  }

  method has_application (
    Str() $uri, 
    Str() $name, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_has_application($!bp, $uri, $name, $error);
  }

  method has_group (
    Str() $uri, 
    Str() $group, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_has_group($!bp, $uri, $group, $error);
  }

  method has_item (Str() $uri) {
    so g_bookmark_file_has_item($!bp, $uri);
  }

  method load_from_data (
    Str() $data, 
    Int() $length, 
    CArray[Pointer[GError]] $error = gerror  
  ) {
    my gsize $l = resolve-uint64($length);
    clear_error;
    my $rc = g_bookmark_file_load_from_data($!bp, $data, $l, $error);
    set_error($error);
    so $rc;
  }

  method load_from_data_dirs (
    Str() $file, 
    Str() $full_path, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_load_from_data_dirs($!bp, $file, $full_path, $error);
  }

  method load_from_file (
    Str() $filename, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_load_from_file($!bp, $filename, $error);
  }

  method move_item (
    Str() $old_uri, 
    Str() $new_uri, 
    CArray[Pointer[GError]] $error) 
  {
    g_bookmark_file_move_item($!bp, $old_uri, $new_uri, $error);
  }

  method remove_application (
    Str() $uri, 
    Str() $name, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_bookmark_file_remove_application($!bp, $uri, $name, $error);
  }

  method remove_group (
    Str() $uri, 
    Str() $group, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_bookmark_file_remove_group($!bp, $uri, $group, $error);
    set_error($error);
    $rc;
  }

  method remove_item (
    Str() $uri, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_bookmark_file_remove_item($!bp, $uri, $error);
    set_error($error);
    $rc;
  }

  method set_added (Str() $uri, Int() $added) {
    my uint64 $a = resolve-uint64($added);
    g_bookmark_file_set_added($!bp, $uri, $a);
  }

  method set_app_info (
    Str() $uri, 
    Str() $name, 
    Str() $exec, 
    Int() $count, 
    Int() $stamp, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $c = resolve-int($count);
    my uint64 $s = resolve-uint64($stamp);
    clear_error;
    my $rc = g_bookmark_file_set_app_info(
      $!bp, 
      $uri, 
      $name, 
      $exec, 
      $c, 
      $s, 
      $error
    );
    set_error($error);
    $rc;
  }

  method set_description (Str() $uri, Str() $description) {
    g_bookmark_file_set_description($!bp, $uri, $description);
  }

  method set_groups (Str() $uri, CArray[Str] $groups, Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_bookmark_file_set_groups($!bp, $uri, $groups, $l);
  }

  method set_icon (Str() $uri, Str() $href, Str() $mime_type) {
    g_bookmark_file_set_icon($!bp, $uri, $href, $mime_type);
  }

  method set_is_private (Str() $uri, gboolean $is_private) {
    g_bookmark_file_set_is_private($!bp, $uri, $is_private);
  }

  method set_mime_type (Str() $uri, Str() $mime_type) {
    g_bookmark_file_set_mime_type($!bp, $uri, $mime_type);
  }

  method set_modified (Str() $uri, Int() $modified) {
    my uint64 $m = resolve-uint64($modified);
    g_bookmark_file_set_modified($!bp, $uri, $m);
  }

  method set_title (Str() $uri, Str() $title) {
    g_bookmark_file_set_title($!bp, $uri, $title);
  }

  method set_visited (Str() $uri, Int() $visited) {
    my uint64 $v = resolve-uint64($visited);
    g_bookmark_file_set_visited($!bp, $uri, $v);
  }

  method to_data (
    $length is rw, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $l = 0;
    clear_error;
    my $rc = g_bookmark_file_to_data($!bp, $l, $error);
    set_error($error);
    $length = $l;
    $rc;
  }

  method to_file (
    Str() $filename, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_bookmark_file_to_file($!bp, $filename, $error);
    set_error($error);
    so $rc;
  }

}
