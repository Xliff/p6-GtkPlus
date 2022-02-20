use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Raw::RecentChooserMenu:ver<3.0.1146>;

use GTK::Roles::RecentChooser:ver<3.0.1146>;

use GTK::Menu:ver<3.0.1146>;

our subset RecentChooserMenuAncestry
  where GtkRecentChooserMenu | GtkRecentChooser | MenuAncestry;

class GTK::RecentChooserMenu:ver<3.0.1146> is GTK::Menu {
  also does GTK::Roles::RecentChooser;

  has GtkRecentChooserMenu $!rcm is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$recentmenu) {
    given $recentmenu {
      when RecentChooserMenuAncestry {
        my $to-parent;
        $!rcm = do {
          when GtkRecentChooserMenu {
            $to-parent = cast(GtkMenu, $_);
            $_;
          }
          when GtkRecentChooser {
            $to-parent = cast(GtkMenu, $_);
            $!rc = $_;
            cast(GtkRecentChooserMenu, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkRecentChooserMenu, $_);
          }
        }
        self.setMenu($to-parent);
        self.roleInit-RecentChooser unless $!rc;
      }
      when GTK::RecentChooserMenu {
      }
      default {
      }
    }

  }

  multi method new (RecentChooserMenuAncestry $recentmenu, :$ref = True) {
    return Nil unless $recentmenu;

    my $o = self.bless(:$recentmenu);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $recentmenu = gtk_recent_chooser_menu_new();

    $recentmenu ?? self.bless( :$recentmenu ) !! Nil;
  }

  method new_for_manager (GtkRecentManager() $manager)
    is also<new-for-manager>
  {
    my $recentmenu = gtk_recent_chooser_menu_new_for_manager($manager);

    $recentmenu ?? self.bless( :$recentmenu ) !! Nil;
  }

  method GTK::Raw::Definitions::GtkRecentChooserMenu
    is also<
      RecentChooserMenu
      GtkRecentChooserMenu
    >
  { $!rcm }

  method show_numbers is rw is also<show-numbers> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_recent_chooser_menu_get_show_numbers($!rcm);
      },
      STORE => sub ($, Int() $show_numbers is copy) {
        my gboolean $s = $show_numbers.so.Int;
        gtk_recent_chooser_menu_set_show_numbers($!rcm, $s);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_chooser_menu_get_type, $n, $t );
  }

}
