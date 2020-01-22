use v6.c;

use Method::Also;
use NativeCall;

use GIO::Raw::Application;
use GTK::Raw::Types;
use GTK::Raw::Application;
use GTK::Raw::Main;
use GTK::Raw::Window;

use GLib::Roles::Object;
use GIO::Roles::ActionMap;

use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Application;

use GTK::ApplicationWindow;
use GTK::Window;

class GTK::Application is export {
  also does GLib::Roles::Object;
  also does GIO::Roles::ActionMap;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::Application;

  my $gapp;

  has $!app is implementor;  # GtkApplication
  has $!title;               # GtkWindow OR GtkApplicationWindow;
  has $!width;
  has $!height;
  has $!init;
  has $!wtype;

  has $.window handles <show_all>;

  submethod BUILD(
           :$app,
    Str    :$title,
    uint32 :$flags = 0,
    uint32 :$width,
    uint32 :$height,
           :$window-type,
           :$window_type,
           :$window
  ) {
    return unless $app;

    self!setObject($!app = $app);
    self.roleInit-ActionMap;

    $!title  = $title;
    $!width  = $width;
    $!height = $height;
    $!init   = Promise.new;
    $!wtype  = $window-type // $window_type // 'application';

    die qq:to/DIE/ unless $!wtype eq <application window custom>.any;
    Invalid window type '{ $window }'. Must be either 'window', 'custom',{
    } or 'application'
    DIE

    $DEBUG = so %*ENV<P6_GTKPLUS_DEBUG>;

    self.activate.tap({
      $!window = do given $!wtype {
        when 'application' {
          my $w = GTK::ApplicationWindow.new($!app);
          $w.set_size_request($width, $height) if $width && $height;
          $w;
        }
        when 'window' {
          GTK::Window.new(
            :$title,
            :$width,
            :$height
          );
        }
        when 'custom' {
          die "Invalid \$window of type '{ $window.^name }' specified!"
            unless $window.^can('GTK::Raw::Definitions::GtkWindow').elems;
          $window
        }
      };
      say "WindowType is { $!wtype }: { $!window }" if $DEBUG;
      $!window.destroy-signal.tap({ self.exit }) unless $!wtype eq 'custom';
      $!init.keep;
    });
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-app;
  }

  method GTK::Raw::Definitions::GtkApplication
    is also<
      GtkApplication
      Application
    >
  { $!app }

  method init (GTK::Application:U: ) {
    state $init-called = False;

    return if $init-called;

    my $args = CArray[Str].new;
    $args[0] = $*PROGRAM.Str;

    gtk_init(0, $args);
    $init-called = True;

    Nil;
  }

  method wait-for-init is also<wait_for_init> {
    await $!init;
  }

  multi method new (GtkApplication $app, :$ref = True) {
    return Nil unless $app;

    my $o = self.bless(:$app);
    $o.ref if $ref;
    $o;
  }
  multi method new(
    Str :$title   = 'org.genex.application',
    Int :$flags   = 0,
    Int :$width   = 200,
    Int :$height  = 200,
    :$pod,
    :$ui,
    :$window-type,
    :$window_type,
    :$window,
    :$style
  ) {
    my uint32 $f = $flags;
    my uint32 $w = $width;
    my uint32 $h = $height;

    GTK::Application.init;

    # Use raw GTK calls here since the object model will be used by the callers.
    my $app = gtk_application_new($title, $f);

    return Nil unless $app;

    self.bless(
      :$app,
      :$title,
      :flags($f),
      :width($w),
      :height($h)
      :$pod,
      :$ui,
      :$window,
      :$window-type,
      :$window_type,
      :$style
    );
  }

  method title {
    $!title;
  }

  method width {
    $!width;
  }

  method height {
    $!height;
  }

  method app_menu is rw is also<app-menu> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_application_get_app_menu($!app);
      },
      STORE => sub ($, $app_menu is copy) {
        gtk_application_set_app_menu($!app, $app_menu);
      }
    );
  }

  method menubar is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_application_get_menubar($!app);
      },
      STORE => sub ($, $menubar is copy) {
        gtk_application_set_menubar($!app, $menubar);
      }
    );
  }

  # Static methods for main loop invocation and termination
  method main (GTK::Application:U:) {
    gtk_main();
  }

  method quit (GTK::Application:U:) {
    gtk_main_quit();
  }

  # Non static main loop start.
  method run {
    # Check to see if the destroy signal has already been tapped. If not, then
    # add the default.
    #
    # Cannot be done here as the activate signal has NOT occurred, yet.

    # Application Startup Process
    # Init
    #   -- Builder init here.
    # Application.startup
    # Application.activate
    #   -- Window must exist here.

    my gint $z = 0;
    g_application_run($!app, $z, Pointer);
  }
  # multi method run(GTK::Application:U: ) {
  #   $gapp = gtk_application_new('Application', G_APPLICATION_FLAGS_NONE);
  #
  #   g_application_run($gapp, OpaquePointer, OpaquePointer);
  # }

  # Non static main loop terminate.
  method exit {
    g_application_quit($!app);
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

  # Is originally:
  # GtkApplication, GtkWindow, gpointer --> void
  method window-added is also<window_added> {
    self.connect-application-signal($!app, 'window-added');
  }

  # Is originally:
  # GtkApplication, GtkWindow, gpointer --> void
  method window-removed is also<window_removed> {
    self.connect-application-signal($!app, 'window-removed');
  }


  method add_accelerator (
    Str() $accelerator,
    Str() $action_name,
    GVariant() $parameter
  )
    is also<add-accelerator>
  {
    gtk_application_add_accelerator(
      $!app,
      $accelerator,
      $action_name,
      $parameter
    );
  }

  method add_window (GtkWindow() $window) is also<add-window> {
    gtk_application_add_window($!app, $window);
  }

  method get_accels_for_action (Str() $detailed_action_name)
    is also<get-accels-for-action>
  {
    gtk_application_get_accels_for_action($!app, $detailed_action_name);
  }

  method get_actions_for_accel (Str() $accel) is also<get-actions-for-accel> {
    gtk_application_get_actions_for_accel($!app, $accel);
  }

  method get_active_window is also<get-active-window> {
    gtk_application_get_active_window($!app);
  }

  method get_menu_by_id (Str() $id) is also<get-menu-by-id> {
    gtk_application_get_menu_by_id($!app, $id);
  }

  method get_type is also<get-type> {
    gtk_application_get_type();
  }

  method get_window_by_id (Int() $id) is also<get-window-by-id> {
    my guint $i = self.RESOLVE-UINT($id);
    gtk_application_get_window_by_id($!app, $i);
  }

  method get_windows is also<get-windows> {
    gtk_application_get_windows($!app);
  }

  # cw: Variant to accept a GTK::Window
  method inhibit (
    GtkWindow $window,
    Int() $flags,               # GtkApplicationInhibitFlags $flags,
    Str() $reason
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_application_inhibit($!app, $window, $f, $reason);
  }

  method is_inhibited (
    Int() $flags                # GtkApplicationInhibitFlags $flags
  )
    is also<is-inhibited>
  {
    my guint $f = self.RESOLVE-UINT($flags);
    gtk_application_is_inhibited($!app, $f);
  }

  method list_action_descriptions
    is also<list-action-descriptions>
  {
    gtk_application_list_action_descriptions($!app);
  }

  method prefers_app_menu is also<prefers-app-menu> {
    gtk_application_prefers_app_menu($!app);
  }

  method remove_accelerator (Str() $action_name, GVariant() $parameter)
    is also<remove-accelerator>
  {
    gtk_application_remove_accelerator($!app, $action_name, $parameter);
  }

  method remove_window (GtkWindow() $window) is also<remove-window> {
    gtk_application_remove_window($!app, $window);
  }

  method uninhibit (Int() $cookie) {
    my guint $c = self.RESOLVE-UINT($cookie);
    gtk_application_uninhibit($!app, $c);
  }

}
