use v6.c;

use Method::Also;

use GTK::Raw::Types;

use GTK::Raw::ApplicationWindow;

use GIO::Roles::ActionMap;

use GTK::Window;

our subset ApplicationWindowAncestry is export
  where GtkApplicationWindow | GActionMap | WindowAncestry;

class GTK::ApplicationWindow is GTK::Window {
  also does GIO::Roles::ActionMap;

  has GtkApplicationWindow $!aw is implementor;

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
        $!actmap = $_;                          # GDK::Roles::ActionMap
        $to-parent = cast(GtkWindow, $_);
        cast(GtkApplication, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkApplication, $_);
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

  multi method new (GtkApplicationWindow $appwindow, :$ref = True) {
    return unless $appwindow;
    
    my $o = self.bless(:$appwindow);
    $o.ref if $ref;
    $o;
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
