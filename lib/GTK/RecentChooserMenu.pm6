use v6.c;

use Method::Also;


use GTK::Raw::Types;

use GTK::Raw::RecentChooserMenu;

use GTK::Roles::RecentChooser;

use GTK::Menu;

our subset RecentChooserMenuAncestry
  where GtkRecentChooserMenu | GtkRecentChooser | MenuAncestry;

class GTK::RecentChooserMenu is GTK::Menu {
  also does GTK::Roles::RecentChooser;

  has GtkRecentChooserMenu $!rcm is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
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

  method new {
    self.bless( recentmenu => gtk_recent_chooser_menu_new() );
  }

  method new_for_manager (GtkRecentManager() $manager)
    is also<new-for-manager>
  {
    self.bless(
      recentmenu => gtk_recent_chooser_menu_new_for_manager($manager)
    );
  }

  method GTK::Raw::Types::GtkRecentChooserMenu
    is also<RecentChooserMenu>
  { $!rcm }

  method show_numbers is rw is also<show-numbers> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_recent_chooser_menu_get_show_numbers($!rcm);
      },
      STORE => sub ($, Int() $show_numbers is copy) {
        my gboolean $s = self.RESOLVE-BOOL($show_numbers);
        gtk_recent_chooser_menu_set_show_numbers($!rcm, $s);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_recent_chooser_menu_get_type, $n, $t );
  }

}
