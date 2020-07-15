use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::ApplicationWindow;

use GTK::ShortcutsWindow;
use GTK::Window;

use GIO::Roles::ActionMap;

our subset ApplicationWindowAncestry is export
  where GtkApplicationWindow | GActionMap | WindowAncestry;

class GTK::ApplicationWindow is GTK::Window {
  also does GIO::Roles::ActionMap;

  has GtkApplicationWindow $!aw is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$appwindow) {
    given $appwindow {
      when ApplicationWindowAncestry { self.setApplicationWindow($appwindow) }
      when GTK::ApplicationWindow    { }
      default                        { }
    }
  }

  method setApplicationWindow(ApplicationWindowAncestry $appwindow) {
    self.IS-PROTECTED;

    my $to-parent;
    $!aw = do given $appwindow {
      when GtkApplicationWindow {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      when GActionMap {
        $!actmap = $_;                          # GDK::Roles::ActionMap
        $to-parent = cast(GtkWindow, $_);
        cast(GtkApplication, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkApplicationWindow, $_);
      }
    };
    self.roleInit-ActionMap unless $!actmap;
    self.setWindow($to-parent);
  }

  method GTK::Raw::Definitions::GtkApplicationWindow
    is also<
      ApplicationWindow
      GtkApplicationWindow
    >
  { $!aw }

  proto method new (|)
  { * }

  multi method new (GtkApplicationWindow $appwindow, :$ref = True, *%others) {
    return Nil unless $appwindow;

    my $o = self.bless(:$appwindow, |%others);
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkApplication() $app, *%others) {
    my $appwindow = gtk_application_window_new($app);

    $appwindow ?? self.bless( :$appwindow, |%others ) !! Nil;
  }

  method help_overlay (:$raw = False) is rw is also<help-overlay> {
    Proxy.new(
      FETCH => sub ($) {
        my $aw = gtk_application_window_get_help_overlay($!aw);

        $aw ??
          ( $raw ?? $aw !! GTK::ShortcutsWindow.new($aw) )
          !!
          Nil;
      },
      STORE => sub ($, GtkShortcutsWindow() $help_overlay is copy) {
        gtk_application_window_set_help_overlay($!aw, $help_overlay);
      }
    );
  }

  method show_menubar is rw is also<show-menubar> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_application_window_get_show_menubar($!aw);
      },
      STORE => sub ($, Int() $show_menubar is copy) {
        my gboolean $s = $show_menubar;

        gtk_application_window_set_show_menubar($!aw, $s);
      }
    );
  }


  method get_id is also<get-id> {
    gtk_application_window_get_id($!aw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_application_window_get_type, $n, $t );
  }

}
