use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Menu;
use GTK::MenuBar;
use GTK::MenuItem;
use GTK::RecentChooserMenu;

my $a = GTK::Application.new( title => 'org.genex.recentchooser.menu' );

$a.activate.tap({
  sub quit      { say "Quit!"; $a.exit; }

  my $menubar = GTK::MenuBar.new(
    GTK::MenuItem.new('Recent',
      :submenu(
        GTK::RecentChooserMenu.new
      ),
    ),
    # Takes a double click, because... EXPEXTING SUBMENU!
    GTK::MenuItem.new('Quit', :clicked(&quit), :right)
  );

  my $vbox = GTK::Box.new-vbox;
  $menubar.show;
  $vbox.pack_start($menubar);

  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
