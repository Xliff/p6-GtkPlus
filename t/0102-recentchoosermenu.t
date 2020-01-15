use v6.c;

use GTK::Raw::Types;

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
      # Need a block because the recent menu items don't do any thing!
      :submenu(do {
        my $rim = GTK::RecentChooserMenu.new;
        $rim.show_numbers = True;
        $rim.item-activated.tap({ say "Selected item: { $rim.get_current_uri }" });
        $rim;
      }),
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
