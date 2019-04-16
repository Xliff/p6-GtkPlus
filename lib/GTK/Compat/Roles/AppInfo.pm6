use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::AppInfo;

class GTK::Compat::Roles::AppInfo {
  has GAppInfo $!ai;

  method GTK::Compat::Types::GAppInfo {
    $!ai;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Static methods
  method create_from_commandline (
    Str() $application_name,
    uint32 $flags,              # GAppInfoCreateFlags $flags,
    GError $error
  ) {
    g_app_info_create_from_commandline(
      $application_name,
      $flags,
      $error
    );
  }

  method get_all_for_type(Str() $content-type, :$raw) {
    my $at = GTK::Compat::List.new(
      g_app_info_get_all_for_type($content-type)
    ) but GTK::Compat::Roles::ListData[GAppInfo];
    $raw ?? $at.Array !! $at.Array.map({ self.new($_) });
  }

  method get_default_for_type (
    Str() $content-type,
    Int() $must_support_uris
  ) {
    my gboolean $m = self.RESOLVE-BOOL($must_support_uris);
    self.new(
      g_app_info_get_default_for_type($content-type, $must_support_uris)
    );
  }

  method get_default_for_uri_scheme(Str() $uri-scheme) {
    self.new(
      g_app_info_get_default_for_uri_scheme($uri-scheme)
    );
  }

  method get_fallback_for_type(Str() $content-type, :$raw) {
    my $f = GTK::Compat::List.new(
      g_app_info_get_fallback_for_type($content-type)
    ) but GTK::Compat::Roles::ListData[GAppInfo];
    $raw ?? $f.Array !! $f.Array.map({ self.new($_) });
  }

  method get_recommended_for_type(Str() $content-type, :$raw) {
    my $r = GTK::Compat::List.new(
      g_app_info_get_recommended_for_type($content-type)
    ) but GTK::Compat::Roles::ListData[GAppInfo];
    $raw ?? $r.Array !! $r.Array.map({ self.new($_) });
  }

  method launch_default_for_uri (
    Str $uri,
    GAppLaunchContext $context,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    g_app_info_launch_default_for_uri($uri, $context, $error);
  }

  method launch_default_for_uri_async (
    Str $uri,
    GAppLaunchContext $context,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
    g_app_info_launch_default_for_uri_async(
      $uri,
      $context,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method launch_default_for_uri_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror();
  ) {
    clear_error;
    my $rc = g_app_info_launch_default_for_uri_finish($result, $error);
    set_error($error);
    $rc;
  }

  method monitor_get {
    g_app_info_monitor_get();
  }

  method monitor_get_type {
    g_app_info_monitor_get_type();
  }

  method reset_type_associations(Str() $content-type) {
    g_app_info_reset_type_associations($content-type);
  }

  # Static methods

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_supports_type (
    Str() $content_type, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = g_app_info_add_supports_type($!ai, $content_type, $error);
    set_error($error);
    $rc;
  }

  method can_delete {
    so g_app_info_can_delete($!ai);
  }

  method can_remove_supports_type {
    so g_app_info_can_remove_supports_type($!ai);
  }

  method delete {
    so g_app_info_delete($!ai);
  }

  method dup {
    self.new( g_app_info_dup($!ai) );
  }

  method equal (GAppInfo() $appinfo2) {
    so g_app_info_equal($!ai, $appinfo2);
  }

  method get_all (:$raw) {
    my $a = GTK::Compat::List.new( g_app_info_get_all() ) 
      but GTK::Compat::Roles::ListData[GAppInfo];
    $raw ?? $a.Array !! $a.Array.map({ self.new($_) });
  }

  method get_commandline {
    g_app_info_get_commandline($!ai);
  }

  method get_description {
    g_app_info_get_description($!ai);
  }

  method get_display_name {
    g_app_info_get_display_name($!ai);
  }

  method get_executable {
    g_app_info_get_executable($!ai);
  }

  method get_icon {
    g_app_info_get_icon($!ai);
  }

  method get_id {
    g_app_info_get_id($!ai);
  }

  method get_name {
    g_app_info_get_name($!ai);
  }

  method get_supported_types {
    my CArray[Str] $t = g_app_info_get_supported_types($!ai);
    my ($i, @t);
    @t[$i] = $t[$i++] while $t[$i].defined;
    @t;
  }

  method launch (
    GList() $files,
    GAppLaunchContext() $context,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_app_info_launch($!ai, $files, $context, $error);
    set_error($error);
    $rc;
  }

  method launch_uris (
    GList() $uris,
    GAppLaunchContext() $context,
    CArray[Pointer[GError]] $error is rw
  ) {
    clear_error;
    my $rc = so g_app_info_launch_uris($!ai, $uris, $context, $error);
    set_error($error);
    $rc;
  }

  method remove_supports_type (
    Str() $content_type,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    g_app_info_remove_supports_type($!ai, $content_type, $error);
  }

  method set_as_default_for_extension (
    Str() $extension,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_app_info_set_as_default_for_extension(
      $!ai, 
      $extension, 
      $error
    );
    set_error($error);
    $rc;
  }

  method set_as_default_for_type (
    Str() $content_type,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_app_info_set_as_default_for_type(
      $!ai, 
      $content_type, 
      $error
    );
    set_error($error);
    $rc;
  }

  method set_as_last_used_for_type (
    Str() $content_type,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = g_app_info_set_as_last_used_for_type(
      $!ai, 
      $content_type, 
      $error
    );
    set_error($error);
    $rc;
  }

  method should_show {
    so g_app_info_should_show($!ai);
  }

  method supports_files {
    so g_app_info_supports_files($!ai);
  }

  method supports_uris {
    so g_app_info_supports_uris($!ai);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
