use v6.c;

use NativeCall;

use GTK::Raw::Types;
use GTK::Raw::Application;

use GTK::Window;

class GTK::Application is GTK::Window {
  also does GTK::Roles::Signals;

  has $!win; # GtkWindow
  has $!app; # GtkApplication

  has $!title;

  submethod BUILD(
    :$app,
    Str    :$title,
    uint32 :$flags = 0,
    Array  :$children
  ) {
    $!app = $app;
    $!title = $title;
    #gtk_init(Pointer, Nil);
  }

  #method p {
  #  nativecast(OpaquePointer, $!app);
  #}

  #method app {
  #  $!app;
  #}

  method title {
    $!title;
  }

  method width {
    $!width;
  }

  method height {
    $!height;
  }

  method init(GTK::Application:U: Int $ac, Str @av) {
    my int32 $argc = $ac;
    my CArray[Str] $argv = CArray[Str].new;

    my $i = 0;
    $argv[$i++] = $_ for @av;

    gtk_init($argc, $argv);
  }

  method new(
    Str :$title,
    Int :$flags = 0,
    Int :$width = 200,
    Int :$height = 200
  ) {
    my uint32 $f = $flags;
    my uint32 $w = $width;
    my uint32 $h = $height;

    die 'Application must have a title.' unless $title;

    my $app = gtk_application_new($title, $f);
    my $window = gtk_application_window_new($app);
    gtk_window_set_title($window, $title);
    gtk_window_set_default_size($window, $w, $h);

    self.bless(
      :$app,
      :$title,
      :flags($f),
      :width($w),
      :height($h),
      :$window,
      :bin($window),
      :container($window),
      :widget($window)
    );
  }

  method app_menu is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_application_get_app_menu($!app);
      },
      STORE => -> sub ($, $app_menu is copy) {
        gtk_application_set_app_menu($!app, $app_menu);
      }
    );
  }

  method menubar is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_application_get_menubar($!app);
      },
      STORE => -> sub ($, $menubar is copy) {
        gtk_application_set_menubar($!app, $menubar);
      }
    );
  }

  method run {
    #gtk_main();
    g_application_run($!app, Pointer[uint32], CArray[Str]);
  }

  method exit {
    gtk_main_quit();
  }

  method activate {
    self.connect($!app, 'activate');
  }

  method startup {
    self.connect($!app, 'startup');
  }

  method shutdown {
    self.connect($!app, 'shutdown');
  }

 method add_accelerator (gchar $accelerator, gchar $action_name, GVariant $parameter) {
    gtk_application_add_accelerator($!app, $accelerator, $action_name, $parameter);
  }

  method add_window (GtkWindow $window) {
    gtk_application_add_window($!app, $window);
  }

  method get_accels_for_action (gchar $detailed_action_name) {
    gtk_application_get_accels_for_action($!app, $detailed_action_name);
  }

  method get_actions_for_accel (gchar $accel) {
    gtk_application_get_actions_for_accel($!app, $accel);
  }

  method get_active_window (GtkApplication $!app) {
    gtk_application_get_active_window($!app);
  }

  method get_menu_by_id (gchar $id) {
    gtk_application_get_menu_by_id($!app, $id);
  }

  method get_type {
    gtk_application_get_type();
  }

  method get_window_by_id (guint $id) {
    gtk_application_get_window_by_id($!app, $id);
  }

  method get_windows {
    gtk_application_get_windows($!app);
  }

  # cw: Variant to accept a GTK::Window
  method inhibit (GtkWindow $window, GtkApplicationInhibitFlags $flags, gchar $reason) {
    gtk_application_inhibit($!app, $window, $flags, $reason);
  }

  method is_inhibited (GtkApplicationInhibitFlags $flags) {
    gtk_application_is_inhibited($!app, $flags);
  }

  method list_action_descriptions {
    gtk_application_list_action_descriptions($!app);
  }

  method prefers_app_menu {
    gtk_application_prefers_app_menu($!app);
  }

  method remove_accelerator (gchar $action_name, GVariant $parameter) {
    gtk_application_remove_accelerator($!app, $action_name, $parameter);
  }

  method remove_window (GtkWindow $window) {
    gtk_application_remove_window($!app, $window);
  }

  method uninhibit (guint $cookie) {
    gtk_application_uninhibit($!app, $cookie);
  }

}
