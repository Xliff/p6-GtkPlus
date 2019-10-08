use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::AppInfo;

use GTK::Compat::Roles::Object;
use GTK::Roles::Signals::Generic;

class GIO::Roles::AppInfo {
  has GAppInfo $!ai;

  submethod BUILD (:$appinfo) {
    $!ai = $appinfo;
  }

  method GTK::Compat::Types::GAppInfo
    is also<GAppInfo>
  { $!ai }

  method new_appinfo_obj (GAppInfo $appinfo) is also<new-appinfo-obj> {
    self.bless(:$appinfo);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Static methods
  method create_from_commandline (
    Str() $application_name,
    Int() $flags,              # GAppInfoCreateFlags $flags,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<create-from-commandline>
  {
    my GAppInfoCreateFlags $f = $flags;

    clear_error;
    my $ai = g_app_info_create_from_commandline(
      $application_name,
      $f,
      $error
    );
    set_error($error);

    $ai ??
      ( $raw ?? $ai !! self.bless( appinfo => $ai ) )
      !!
      Nil;
  }

  method get_all_for_type(Str() $content-type, :$glist = False, :$raw = False)
    is also<get-all-for-type>
  {
    my $at = g_app_info_get_all_for_type($content-type);

    return Nil unless $at;
    return $at if     $glist;

    my $atl = GTK::Compat::List.new($at)
      but GTK::Compat::Roles::ListData[GAppInfo];

    $raw ?? $atl.Array !!
            $atl.Array.map({ GIO::Roles::AppInfo.new_appinfo_obj($_) });
  }

  method get_default_for_type (
    Str() $content-type,
    Int() $must_support_uris,
    :$raw = False
  )
    is also<get-default-for-type>
  {
    my gboolean $m = $must_support_uris;
    my $ai = g_app_info_get_default_for_type(
      $content-type,
      $must_support_uris
    );

    $ai ??
      ( $raw ?? $ai !! GIO::Roles::AppInfo.new_appinfo_obj($ai) )
      !!
      Nil;
  }

  method get_default_for_uri_scheme(Str() $uri-scheme, :$raw = False)
    is also<get-default-for-uri-scheme>
  {
    my $ai = g_app_info_get_default_for_uri_scheme($uri-scheme);

    $ai ??
      ( $raw ?? $ai !! GIO::Roles::AppInfo.new_appinfo_obj($ai) )
      !!
      Nil;
  }

  method get_fallback_for_type(
    Str() $content-type,
    :$glist = False,
    :$raw   = False
  )
    is also<get-fallback-for-type>
  {
    my $f = g_app_info_get_fallback_for_type($content-type);

    return Nil unless $f;
    return $f if      $glist;

    my $fl = GTK::Compat::List.new($f)
      but GTK::Compat::Roles::ListData[GAppInfo];

    $raw ?? $fl.Array !!
            $fl.Array.map({ GIO::Roles::AppInfo.new_appinfo_obj($_) });
  }

  method get_recommended_for_type(
    Str() $content-type,
    :$glist = False,
    :$raw   = False
  )
    is also<get-recommended-for-type>
  {
    my $r = g_app_info_get_recommended_for_type($content-type);

    return Nil unless $r;
    return $r  if     $glist;

    my $rl = GTK::Compat::List.new($r)
      but GTK::Compat::Roles::ListData[GAppInfo];

    $raw ?? $rl.Array !!
            $rl.Array.map({ GIO::Roles::AppInfo.new_appinfo_obj($_) });
  }

  method launch_default_for_uri (
    Str() $uri,
    GAppLaunchContext() $context,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<launch-default-for-uri>
  {
    clear_error;
    my $rv = so g_app_info_launch_default_for_uri($uri, $context, $error);
    set_error($error);
    $rv;
  }

  proto method launch_default_for_uri_async (|)
    is also<launch-default-for-uri-async>
  { * }

  multi launch_default_for_uri_async (
    Str() $uri,
    GAppLaunchContext() $context,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($uri, $context, GCancellable, $callback, $user_data)
  }
  multi method launch_default_for_uri_async (
    Str() $uri,
    GAppLaunchContext() $context,
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
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror();
  )
    is also<launch-default-for-uri-finish>
  {
    clear_error;
    my $rc = so g_app_info_launch_default_for_uri_finish($result, $error);
    set_error($error);
    $rc;
  }

  method reset_type_associations(Str() $content-type)
    is also<reset-type-associations>
  {
    g_app_info_reset_type_associations($content-type);
  }

  # Static methods

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_supports_type (
    Str() $content_type,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<add-supports-type>
  {
    clear_error;
    my $rc = so g_app_info_add_supports_type($!ai, $content_type, $error);
    set_error($error);
    $rc;
  }

  method can_delete is also<can-delete> {
    so g_app_info_can_delete($!ai);
  }

  method can_remove_supports_type is also<can-remove-supports-type> {
    so g_app_info_can_remove_supports_type($!ai);
  }

  method delete {
    so g_app_info_delete($!ai);
  }

  method dup (:$raw = False) {
    my $ai = g_app_info_dup($!ai);

    $ai ??
      ( $raw ?? $ai !! GIO::Roles::AppInfo.new_appinfo_obj($ai) )
      !!
      Nil;
  }

  method equal (GAppInfo() $appinfo2) {
    so g_app_info_equal($!ai, $appinfo2);
  }

  method get_all (:$glist = False, :$raw = False)
    is also<
      get-all
      all
    >
  {
    my $a = g_app_info_get_all();

    return Nil unless $a;
    return $a  if     $glist;

    $raw ?? $a.Array !!
            $a.Array.map({ GIO::Roles::AppInfo.new_appinfo_obj($_) });
  }

  method get_commandline
    is also<
      get-commandline
      commandline
    >
  {
    g_app_info_get_commandline($!ai);
  }

  method get_description
    is also<
      get-description
      description
    >
  {
    g_app_info_get_description($!ai);
  }

  method get_display_name
    is also<
      get-display-name
      display_name
      display-name
    >
  {
    g_app_info_get_display_name($!ai);
  }

  method get_executable
    is also<
      get-executable
      executable
    >
  {
    g_app_info_get_executable($!ai);
  }

  method get_icon (:$raw = False) is also<get-icon> {
    my $i = g_app_info_get_icon($!ai);

    $i ??
      ( $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i) )
      !!
      Nil;
  }

  method get_id
    is also<
      get-id
      id
    >
  {
    g_app_info_get_id($!ai);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    g_app_info_get_name($!ai);
  }

  method get_supported_types
    is also<
      get-supported-types
      supported_types
      supported-types
    >
  {
    CStringArrayToArray( g_app_info_get_supported_types($!ai) );
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
  )
    is also<launch-uris>
  {
    clear_error;
    my $rc = so g_app_info_launch_uris($!ai, $uris, $context, $error);
    set_error($error);
    $rc;
  }

  method remove_supports_type (
    Str() $content_type,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<remove-supports-type>
  {
    g_app_info_remove_supports_type($!ai, $content_type, $error);
  }

  method set_as_default_for_extension (
    Str() $extension,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-as-default-for-extension>
  {
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
  )
    is also<set-as-default-for-type>
  {
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
  )
    is also<set-as-last-used-for-type>
  {
    clear_error;
    my $rc = so g_app_info_set_as_last_used_for_type(
      $!ai,
      $content_type,
      $error
    );
    set_error($error);
    $rc;
  }

  method should_show is also<should-show> {
    so g_app_info_should_show($!ai);
  }

  method supports_files is also<supports-files> {
    so g_app_info_supports_files($!ai);
  }

  method supports_uris is also<supports-uris> {
    so g_app_info_supports_uris($!ai);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

# A bit small for its own compunit?
class GIO::AppInfoMonitor {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has GAppInfoMonitor $!aim;

  submethod BUILD (:$monitor) {
    $!aim = $monitor;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GAppInfoMonitor
    is also<GAppInfoMonitor>
  { $!aim }

  method new_appinfomonitor_obj (GAppInfoMonitor $monitor)
    is also<new-appinfomonitor-obj>
  {
    self.bless( :$monitor );
  }

  method monitor_get (:$raw = False) is also<monitor-get> {
    my $m = g_app_info_monitor_get();

    return Nil unless $m;
    return $m  if     $raw;

    GIO::AppInfoMonitor.new-appinfomonitor($m);
  }

  # Is originally:
  # GAppInfoMonitor, gpointer --> void
  method changed {
    self.connect($!aim, 'changed');
  }

  method monitor_get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_app_info_monitor_get_type, $n, $t );
  }

}
