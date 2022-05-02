use v6.c;

use Method::Also;
use NativeCall;

use GIO::Raw::Application;
use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Application:ver<3.0.1146>;
use GTK::Raw::Main:ver<3.0.1146>;
use GTK::Raw::Window:ver<3.0.1146>;

use GIO::Application;
use GIO::MenuModel;
use GTK::ApplicationWindow:ver<3.0.1146>;
use GTK::Window:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;
use GTK::Roles::Signals::Application:ver<3.0.1146>;

our subset GtkApplicationAncestry is export of Mu
  where GtkApplication | GApplicationAncestry;

class GTK::Application:ver<3.0.1146> is GIO::Application {
  my $gapp;

  has GtkApplication $!app     is implementor; # GtkApplication
  has                $!title;                  # GtkWindow OR GtkApplicationWindow;
  has                $!width;
  has                $!height;
  has                $!init;
  has                $!build;
  has                $!wtype;

  has $.window handles <show_all>;

  has $!window-class;
  has $!application-window-class;

  submethod BUILD(
    :$app,
    :$title                        = Str,
    :$flags                        = 0,
    :$width                        = 200,
    :$height                       = 200,
    :window_type(:$window-type),
    :$window,
    :$application-window-class,
    :$window-class
  ) {
    say "{ self.^name }.{ &?ROUTINE.name } - ENTER";
    self.setGtkApplication($app, :$window) if $app;

    $!title                      = $title;
    $!width                      = $width;
    $!height                     = $height;
    $!init                       = Promise.new;
    $!wtype                      = $window-type // 'application';
    $!window-class               = $window-class;
    $!application-window-class   = $application-window-class;

    $!window = $window if $window;

    # die qq:to/DIE/ unless $!wtype eq <application window custom>.any;
    #   Invalid window type '{ $window }'. Must be either 'window', 'custom',{
    #   } or 'application'
    #   DIE

    $DEBUG = so %*ENV<P6_GTKPLUS_DEBUG>;
    say "{ self.^name }.{ &?ROUTINE.name } - LEAVE";
  }

  method setGtkApplication (GtkApplicationAncestry $_, :$window) {
    my $to-parent;

    $!app = do {
      when GtkApplication {
        $to-parent = cast(GApplication, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkApplication, $_);
      }
    }
    say "setGApp: { $to-parent }";
    self.setGApplication($to-parent);

    self!set-default-event($window);
  }

  method !set-default-event ($window) {
    self.activate.tap(-> *@a {
      unless $window {
        $!window = do given $!wtype {
          when 'application' {
            my $w = $!application-window-class.new($!app);
            $w.set_size_request($!width, $!height) if $!width && $!height;
            $w;
          }

          when 'window' {
            $!window-class.new(
              :$!title,
              :$!width,
              :$!height
            );
          }

          when 'custom' {
            die "Invalid \$window of type '{ $window.^name }' specified!"
              unless $window.^can('GTK::Raw::Definitions::GtkWindow').elems;
            $window
          }

        }
      }

      if $!window {
        say "WindowType is { $!wtype }: { $!window }" if $DEBUG;
        $!window.destroy-signal.tap( -> *@a { self.exit } )
          unless $!wtype eq 'custom';
      }
      $!init.keep;
    });
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

  multi method new (GtkApplication $app, :$ref = True, *%others) {
    return Nil unless $app;

    my $o = self.bless(:$app, |%others);
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
    :$style,
    *%others
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
      :$style,
      |%others
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

  method app_menu (:$raw = False) is rw is also<app-menu> {
    Proxy.new(
      FETCH => sub ($) {
        my $mm = gtk_application_get_app_menu($!app);

        $mm ??
          ( $raw ?? $mm !! GIO::MenuModel.new($mm) )
          !!
          Nil;
      },
      STORE => sub ($, GMenuModel() $app_menu is copy) {
        gtk_application_set_app_menu($!app, $app_menu);
      }
    );
  }

  method menubar (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $mm = gtk_application_get_menubar($!app);

        $mm ??
          ( $raw ?? $mm !! GIO::MenuModel.new($mm) )
          !!
          Nil;
      },
      STORE => sub ($, GMenuModel() $menubar is copy) {
        gtk_application_set_menubar($!app, $menubar);
      }
    );
  }

  method main {
    gtk_main();
  }

  # Static methods for main loop termination
  multi method quit {
    gtk_main_quit();
  }
  # To use g_application_quit, you must have an invocant!
  multi method quit (GTK::Application:D: :$gio is required ) {
    nextsame;
  }

  # Non static main loop start.
  # method run {
  #   # Check to see if the destroy signal has already been tapped. If not, then
  #   # add the default.
  #   #
  #   # Cannot be done here as the activate signal has NOT occurred, yet.
  #
  #   # Application Startup Process
  #   # Init
  #   #   -- Builder init here.
  #   # Application.startup
  #   # Application.activate
  #   #   -- Window must exist here.
  #
  #   my gint $z = 0;
  #   g_application_run($!app, $z, Pointer);
  # }
  # multi method run(GTK::Application:U: ) {
  #   $gapp = gtk_application_new('Application', G_APPLICATION_FLAGS_NONE);
  #
  #   g_application_run($gapp, OpaquePointer, OpaquePointer);
  # }

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
    my $a = gtk_application_get_accels_for_action(
      $!app,
      $detailed_action_name
    );

    $a[0] ?? CArrayToArray($a[0]) !! Nil;
  }

  method get_actions_for_accel (Str() $accel) is also<get-actions-for-accel> {
    gtk_application_get_actions_for_accel($!app, $accel);
  }

  method get_active_window (
    :$raw                  = False,
    :$window               = False,
    :$base-widget          = False,
    :$base        is copy  = GTK::Window
  )
    is also<
      get-active-window
      active_window
      active-window
    >
  {
    # cw: Window overrides $base and $base-widget to return a GTK::Window
    if $window {
      $base-widget = True;
      $base        = GTK::Window;
    }

    # cw: Return as close to the original object as parameters allow.
    ReturnWidget(
       gtk_application_get_active_window($!app),
       $raw,
      :$base,
      :$base-widget
    );
  }

  method get_menu_by_id (Str() $id) is also<get-menu-by-id> {
    gtk_application_get_menu_by_id($!app, $id);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_application_get_type, $n, $t );
  }

  method get_window_by_id (Int() $id) is also<get-window-by-id> {
    my guint $i = $id;

    gtk_application_get_window_by_id($!app, $i);
  }

  method get_windows (:$glist = False, :$raw = False) is also<get-windows> {
    my $wl = gtk_application_get_windows($!app);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GLib::Roles::ListData[GtkWindow];
    $raw ?? $wl.Array !! $wl.Array.map({ GTK::Window.new($_) });
  }

  # cw: Variant to accept a GTK::Window
  method inhibit (
    GtkWindow $window,
    Int()     $flags,               # GtkApplicationInhibitFlags $flags,
    Str()     $reason
  ) {
    my guint $f = $flags;

    gtk_application_inhibit($!app, $window, $f, $reason);
  }

  method is_inhibited (
    Int() $flags                # GtkApplicationInhibitFlags $flags
  )
    is also<is-inhibited>
  {
    my guint $f = $flags;

    so gtk_application_is_inhibited($!app, $f);
  }

  method list_action_descriptions
    is also<list-action-descriptions>
  {
    gtk_application_list_action_descriptions($!app);
  }

  method prefers_app_menu is also<prefers-app-menu> {
    my $l = gtk_application_prefers_app_menu($!app);

    $l[0] ?? CArrayToArray($l[0]) !! Nil;
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
    my guint $c = $cookie;

    gtk_application_uninhibit($!app, $c);
  }

}
