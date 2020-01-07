use v6.c;

use NativeCall;


use GTK::Raw::Types;

use GTK::Roles::RecentChooser;

use GTK::Box;

our subset RecentChooserWidgetAncestry is export
  where GtkRecentChooserWidget | GtkRecentChooser | BoxAncestry;

class GTK::RecentChooserWidget is GTK::Box {
  also does GTK::Roles::RecentChooser;

  has GtkRecentChooserWidget $!rcw is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$recentwidget) {
    given $recentwidget {
      when RecentChooserWidgetAncestry {
        my $to-parent;
        $!rcw = do {
          when GtkRecentChooserWidget {
            $to-parent = cast(GtkBox, $_);
            $_;
          }
          when GtkRecentChooser {
            $!rc = $_;                                    # GTK::Roles::RecentChooser
            $to-parent = cast(GtkBox, $_);
            cast(GtkRecentChooserWidget, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkRecentChooserWidget, $_);
          }
        }
        self.setBox($to-parent);
        $!rc //= cast(GtkRecentChooser, $recentwidget);   # GTK::Roles::RecentChooser
      }
      when GTK::RecentChooserWidget {
      }
      default {
      }
    }
  }

  method new {
    self.bless( recentwidget => gtk_recent_chooser_widget_new() );
  }

  method new_for_manager (GtkRecentManager() $manager) {
    self.bless(
      recentwidget => gtk_recent_chooser_widget_new_for_manager($manager)
    );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type(
      self.^name,
      &gtk_recent_chooser_widget_get_type,
      $n,
      $t
    );
  }

}

sub gtk_recent_chooser_widget_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_widget_new ()
  returns GtkRecentChooserWidget
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_widget_new_for_manager (GtkRecentManager $manager)
  returns GtkRecentChooserWidget
  is native(gtk)
  is export
  { * }
