use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::Application;
use GTK::Raw::Window;

use GTK::Builder;
use GTK::CSSProvider;
use GTK::Window;

class GTK::Application {
  also does GTK::Roles::Signals;

  my $gapp;

  has $!app;    # GtkApplication
  has $!title;
  has $!width;
  has $!height;

  has $.builder;
  has $.window handles <show_all>;

  submethod BUILD(
    :$app,
    Str    :$title,
    uint32 :$flags = 0,
    uint32 :$width,
    uint32 :$height,
    :$pod,
    :$ui,
    :$window-name,
    :$style
  ) {
    $!app = $app;
    $!title = $title;

    my %sections;
    my ($ui-data, $style-data);
    with $pod {
      for $pod.grep( *.name eq <css ui>.any ).Array {
        # This may not always be true. Keep up with POD spec!
        %sections{ .name } //= $_.contents.map( *.contents[0] ).join("\n");
        last when %sections<css>.defined && %sections<ui>.defined;
      }
      ($ui-data, $style-data) = %sections<ui css>;
    } else {
         $ui-data = $_ with $ui;
      $style-data = $_ with $style;
    }

    with $ui-data {
      $!builder = GTK::Builder.new;
      $!builder.add_from_string($_);
      # Set $!title, $!width, $!height from application window, but
      # what would be the best way to get that from the builder?
      #
      # The answer: that information is REALLY NOT IMPORTANT in this stage of
      # GtkBuilder support!

      # MUST define an activate handler!!
      $!window = GTK::Window.new(
        :widget( $!builder.get_object($window-name) )
      );

      die qq:to/ERR/ unless $!window;
Application window '#application' was not found. Please do one of the following:
   - Rename the top-level window to 'application' in the .ui file
   OR
   - Specify the name of the top-level window using the named parameter
     :\$window-name in the constructor to GTK::Application
ERR

    } else {
      $!width = $width;
      $!height = $height;
    }

    with $style-data {
      my $cp = GTK::CSSProvider.new;
      $cp.load_from_data($_);
    }


    self.activate.tap({
      $!window //= GTK::Window.new(
        :window( gtk_application_window_new($!app) )
      );

      without $ui-data {
        self.window.title = $title;
        self.window.name = $window-name;
        self.window.set_default_size($width, $height);
      }
    });

  }

  method GTK::Raw::Types::GtkApplication {
    $!app;
  }

  method control(Str $name?) {
    without $name {
      return $!builder;
    }
    die "GTK::Application.controls only available if using GTK::Builder support."
      unless $!builder;
    $!builder{$name};
  }

  method init (GTK::Application:U: ) {
    my $argc = CArray[uint32].new;
    $argc[0] = 1;
    my $args = CArray[Str].new;
    $args[0] = $*PROGRAM.Str;
    my $argv = CArray[CArray[Str]].new;
    $argv[0] = $args;

    gtk_init($argc, $argv);
  }

  method new(
    Str :$title = 'org.genex.application',
    Int :$flags = 0,
    Int :$width = 200,
    Int :$height = 200,
    :$pod,
    :$ui,
    :$window-name = 'application',
    :$style
  ) {
    my uint32 $f = $flags;
    my uint32 $w = $width;
    my uint32 $h = $height;

    GTK::Application.init;

    # Use raw GTK calls here since the object model will be used by the callers.
    my $app = gtk_application_new($title, $f);

    self.bless(
      :$app,
      :$title,
      :flags($f),
      :width($w),
      :height($h)
      :$pod,
      :$ui,
      :$window-name,
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

  method app_menu is rw {
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

  multi method run (GTK::Application:D: ) {
    # Check to see if supply has already been tapped. If not, then:
    # self.window.destroy-signal.tap({ self.exit; });
    #gtk_main();

    with $!builder {
      gtk_main();
    } else {
      g_application_run($!app, OpaquePointer, OpaquePointer);
    }
  }
  multi method run(GTK::Application:U: ) {
    $gapp = gtk_application_new('Application', G_APPLICATION_FLAGS_NONE);

    g_application_run($gapp, OpaquePointer, OpaquePointer);
  }

  multi method exit(GTK::Application:D: ) {
    $.builder ?? gtk_main_quit() !! g_application_quit($!app);
  }
  multi method exit(GTK::Application:U: ) {
    $.builder ?? gtk_main_quit() !! g_application_quit($!app);
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

  method getWidget($name) {
    die "Application not initialized with Builder support!" unless $!builder;

    # Object resolution code needed here, as well.
    $!builder.get_object($name);
  }

  method add_accelerator (gchar $accelerator, gchar $action_name, GVariant $parameter) {
    gtk_application_add_accelerator($!app, $accelerator, $action_name, $parameter);
  }

  multi method add_window (GtkWindow $window) {
    gtk_application_add_window($!app, $window);
  }
  multi method add_window(GTK::Window $window) {
    samewith($window.window);
  }

  method get_accels_for_action (gchar $detailed_action_name) {
    gtk_application_get_accels_for_action($!app, $detailed_action_name);
  }

  method get_actions_for_accel (gchar $accel) {
    gtk_application_get_actions_for_accel($!app, $accel);
  }

  method get_active_window {
    gtk_application_get_active_window($!app);
  }

  method get_menu_by_id (gchar $id) {
    gtk_application_get_menu_by_id($!app, $id);
  }

  method get_type {
    gtk_application_get_type();
  }

  method get_window_by_id (Int() $id) {
    my guint $i = GTK::Window.RESOLVE-UINT($id);
    gtk_application_get_window_by_id($!app, $i);
  }

  method get_windows {
    gtk_application_get_windows($!app);
  }

  # cw: Variant to accept a GTK::Window
  multi method inhibit (
    GtkWindow $window,
    Int() $flags,               # GtkApplicationInhibitFlags $flags,
    gchar $reason
  ) {
    my guint $f = GTK::Window.RESOLVE-UINT($flags);
    gtk_application_inhibit($!app, $window, $f, $reason);
  }
  multi method inhibit (
    GTK::Window $window,
    Int() $flags,               # GtkApplicationInhibitFlags $flags,
    gchar $reason
  ) {
    samewith($window.window, $flags, $reason);
  }

  method is_inhibited (
    Int() $flags                # GtkApplicationInhibitFlags $flags
  ) {
    my guint $f = GTK::Window.RESOLVE-UINT($flags);
    gtk_application_is_inhibited($!app, $f);
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

  multi method remove_window (GtkWindow $window) {
    gtk_application_remove_window($!app, $window);
  }
  multi method remove_window (GTK::Window $window) {
    samewith($window.window);
  }

  method uninhibit (Int() $cookie) {
    my guint $c = GTK::Window.RESOLVE-UINT($cookie);
    gtk_application_uninhibit($!app, $c);
  }

}
