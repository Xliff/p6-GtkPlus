use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Raw::Utils;

use GIO::Raw::DesktopAppInfo;

use GIO::Roles::AppInfo;

use GTK::Compat::Roles::Object;

class GIO::DesktopAppInfo {
  also does GTK::Compat::Roles::Object;

  has GDesktopAppInfo $!dai is implementor;

  submethod BUILD (:$desktop-info) {
    $!dai = $desktop-info;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDesktopAppInfo
    is also<GDesktopAppInfo>
  { $!dai }

  multi method new (GDesktopAppInfo $desktop-info) {
    my $o = self.bless( :$desktop-info );
    $o;
  }
  multi method new (Str $desktop_id) {
    my $di = g_desktop_app_info_new($desktop_id);
    $di ?? self.bless( desktop-info => $di ) !! Nil;
  }

  method new_from_filename (Str() $filename) is also<new-from-filename> {
    my $di = g_desktop_app_info_new_from_filename($filename);
    $di ?? self.bless( desktop-info => $di ) !! Nil;
  }

  method new_from_keyfile (GKeyFile() $keyfile) is also<new-from-keyfile> {
    my $di = g_desktop_app_info_new_from_keyfile($keyfile);
    $di ?? self.bless( desktop-info => $di ) !! Nil;
  }

  method get_action_name (Str() $action_name) is also<get-action-name> {
    g_desktop_app_info_get_action_name($!dai, $action_name);
  }

  method get_boolean (Str() $key) is also<get-boolean> {
    so g_desktop_app_info_get_boolean($!dai, $key);
  }

  method get_categories is also<get-categories> {
    g_desktop_app_info_get_categories($!dai);
  }

  method get_filename is also<get-filename> {
    g_desktop_app_info_get_filename($!dai);
  }

  method get_generic_name is also<get-generic-name> {
    g_desktop_app_info_get_generic_name($!dai);
  }

  method get_implementations (
    GIO::DesktopAppInfo:U:
    Str() $interface,
    :$glist = False,
    :$raw = False
  )
    is also<get-implementations>
  {
    my $il = g_desktop_app_info_get_implementations($interface);

    return Nil unless $il;
    return $il if     $glist;

    $il = $il but GTK::Compat::Roles::ListData[GDesktopAppInfo];
    $raw ?? $il.Array !! $il.Array.map({ GIO::DesktopAppInfo.new($_) });
  }

  method get_is_hidden is also<get-is-hidden> {
    so g_desktop_app_info_get_is_hidden($!dai);
  }

  method get_keywords is also<get-keywords> {
    CStringArrayToArray( g_desktop_app_info_get_keywords($!dai) );
  }

  method get_locale_string (Str() $key) is also<get-locale-string> {
    g_desktop_app_info_get_locale_string($!dai, $key);
  }

  method get_nodisplay is also<get-nodisplay> {
    so g_desktop_app_info_get_nodisplay($!dai);
  }

  method get_show_in (Str() $desktop_env) is also<get-show-in> {
    g_desktop_app_info_get_show_in($!dai, $desktop_env);
  }

  method get_startup_wm_class is also<get-startup-wm-class> {
    g_desktop_app_info_get_startup_wm_class($!dai);
  }

  method get_string (Str() $key) is also<get-string> {
    g_desktop_app_info_get_string($!dai, $key);
  }

  method get_string_list (Str() $key, Int() $length) is also<get-string-list> {
    my gsize $l = $length;

    g_desktop_app_info_get_string_list($!dai, $key, $l);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_desktop_app_info_get_type, $n, $t );
  }

  method has_key (Str() $key) is also<has-key> {
    so g_desktop_app_info_has_key($!dai, $key);
  }

  method launch_action (
    Str() $action_name,
    GAppLaunchContext() $launch_context
  )
    is also<launch-action>
  {
    g_desktop_app_info_launch_action($!dai, $action_name, $launch_context);
  }

  proto method launch_uris_as_manager (|)
      is also<launch-uris-as-manager>
  { * }

  multi method launch_uris_as_manager (
    GList() $uris,
    GAppLaunchContext() $launch_context,
    GSpawnFlags $spawn_flags,
    GDesktopAppLaunchCallback &pid_callback = Callable,
    gpointer $pid_callback_data             = gpointer,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    samewith(
      $uris,
      $launch_context,
      $spawn_flags,
      Callable,
      gpointer,
      &pid_callback,
      $pid_callback_data,
      $error
    );
  }
  multi method launch_uris_as_manager (
    GList() $uris,
    GAppLaunchContext() $launch_context,
    GSpawnFlags $spawn_flags,
    GSpawnChildSetupFunc &user_setup        = Callable,
    gpointer $user_setup_data               = gpointer,
    GDesktopAppLaunchCallback &pid_callback = Callable,
    gpointer $pid_callback_data             = gpointer,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = so g_desktop_app_info_launch_uris_as_manager(
      $!dai,
      $uris,
      $launch_context,
      $spawn_flags,
      &user_setup,
      $user_setup_data,
      &pid_callback,
      $pid_callback_data,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method launch_uris_as_manager_with_fds (|)
      is also<launch-uris-as-manager-with-fds>
  { * }

  multi method launch_uris_as_manager_with_fds (
    GList() $uris,
    GAppLaunchContext() $launch_context,
    GSpawnFlags $spawn_flags,
    GDesktopAppLaunchCallback &pid_callback,
    Int() $stdin_fd                = -1,
    Int() $stdout_fd               = -1,
    Int() $stderr_fd               = -1,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(
      $uris,
      $launch_context,
      $spawn_flags,
      &pid_callback,
      gpointer,
      $stdin_fd,
      $stdout_fd,
      $stderr_fd,
      $error
    );
  }
  multi method launch_uris_as_manager_with_fds (
    GList() $uris,
    GAppLaunchContext() $launch_context,
    GSpawnFlags $spawn_flags,
    GDesktopAppLaunchCallback &pid_callback,
    gpointer $pid_callback_data,
    Int() $stdin_fd                = -1,
    Int() $stdout_fd               = -1,
    Int() $stderr_fd               = -1,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(
      $uris,
      $launch_context,
      $spawn_flags,
      Callable,
      gpointer,
      &pid_callback,
      $pid_callback_data,
      $stdin_fd,
      $stdout_fd,
      $stderr_fd,
      $error
    );
  }
  multi method launch_uris_as_manager_with_fds (
    GList() $uris,
    GAppLaunchContext() $launch_context,
    GSpawnFlags $spawn_flags,
    GSpawnChildSetupFunc $user_setup,
    gpointer $user_setup_data,
    GDesktopAppLaunchCallback &pid_callback,
    gpointer $pid_callback_data,
    Int() $stdin_fd                = -1,
    Int() $stdout_fd               = -1,
    Int() $stderr_fd               = -1,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint ($si, $so, $se) = ($stdin_fd, $stdout_fd, $stderr_fd);

    clear_error;
    my $rv = so g_desktop_app_info_launch_uris_as_manager_with_fds(
      $!dai,
      $uris,
      $launch_context,
      $spawn_flags,
      $user_setup,
      $user_setup_data,
      &pid_callback,
      $pid_callback_data,
      $si,
      $so,
      $se,
      $error
    );
    set_error($error);
    $rv;
  }

  method list_actions is also<list-actions> {
    CStringArrayToArray( g_desktop_app_info_list_actions($!dai) );
  }

  method lookup_get_default_for_uri_scheme (
    GIO::DesktopAppInfo:U:
    Str() $uri_scheme,
    :$raw = False
  )
    is also<lookup-get-default-for-uri-scheme>
  {
    my $ai = g_desktop_app_info_lookup_get_default_for_uri_scheme($uri_scheme);

    $ai ??
      ( $raw ?? $ai !! GIO::Roles::AppInfo.new-appinfo-obj($ai) )
      !!
      Nil;
  }

  method lookup_get_type (GIO::DesktopAppInfo:U: ) is also<lookup-get-type> {
    g_desktop_app_info_lookup_get_type();
  }

  method search (GIO::DesktopAppInfo:U: Str() $search_string) {
    CStringArrayToArray( g_desktop_app_info_search($search_string) );
  }

  # method set_desktop_env {
  #   g_desktop_app_info_set_desktop_env($!dai);
  # }

}
