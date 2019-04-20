use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Raw::ApplicationWindow;

use GTK::Compat::Roles::ActionMap;

use GTK::Window;

our subset ApplicationWindowAncestry is export
  where GtkApplicationWindow | GActionMap | WindowAncestry;

class GTK::ApplicationWindow is GTK::Window {
  also does GTK::Compat::Roles::ActionMap;

  has GtkApplicationWindow $!aw;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$appwindow) {
    given $appwindow {
      when ApplicationWindowAncestry {
        self.setApplicationWindow($appwindow);
      }
      when GTK::ApplicationWindow {
      }
      default {
      }
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
        $!actmap = $_;                          # GTK::Compat::Roles::ActionMap
        $to-parent = cast(GtkWindow, $_);
        cast(GtkApplication, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkApplication, $_);
      }
    };
    $!actmap //= cast(GActionMap, $appwindow);  # GTK::Compat::Roles::ActionMap
    self.setWindow($to-parent);
  }

  method GTK::Raw::Types::GtkApplicationWindow
    is also<ApplicationWindow>
  { $!aw }

  multi method new (GtkApplicationWindow $appwindow) {
    my $o = self.bless(:$appwindow);
    $o.upref;
  }
  multi method new (GtkApplication() $app) {
    self.bless( appwindow => gtk_application_window_new($app) );
  }

  method help_overlay is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::ShortcutsWindow.new(
          gtk_application_window_get_help_overlay($!aw)
        );
      },
      STORE => sub ($, GtkShortcutsWindow() $help_overlay is copy) {
        gtk_application_window_set_help_overlay($!aw, $help_overlay);
      }
    );
  }

  method show_menubar is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_application_window_get_show_menubar($!aw);
      },
      STORE => sub ($, Int() $show_menubar is copy) {
        my gboolean $s = self.RESOLVE-BOOL($show_menubar);
        gtk_application_window_set_show_menubar($!aw, $s);
      }
    );
  }


  method get_id {
    gtk_application_window_get_id($!aw);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_application_window_get_type, $n, $t );
  }

}
