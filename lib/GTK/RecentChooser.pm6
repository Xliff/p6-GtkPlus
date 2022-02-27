use v6.c;

use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::RecentChooser:ver<3.0.1146>;

use GTK::Box:ver<3.0.1146>;

our subset RecentChooserWidgetAncestry is export
  where GtkRecentChooserWidget | GtkRecentChooser | GtkBoxAncestry;

class GTK::RecentChooser:ver<3.0.1146> is GTK::Box {
  also does GTK::Roles::RecentChooser;

  has GtkRecentChooserWidget $!rcw is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
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
        self.roleInit-RecentChooser; # GTK::Roles::RecentChooser
      }

      when GTK::RecentChooser {
      }

      default {
      }
    }
  }

  multi method new (RecentChooserWidgetAncestry $recentwidget, :$ref = True) {
    return Nil unless $recentwidget;

    my $o = self.bless( :$recentwidget );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $recentwidget = gtk_recent_chooser_widget_new();

    $recentwidget ?? self.bless( :$recentwidget ) !! Nil;
  }

  multi method new_for_manager (GtkRecentManager() $manager) {
    my $recentwidget = gtk_recent_chooser_widget_new_for_manager($manager);

    $recentwidget ?? self.bless( :$recentwidget ) !! Nil;
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
