use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Menu;
use GTK::MenuBar;
use GTK::MenuItem;

my $a = GTK::Application.new( title => 'org.genex.menus' );

$a.activate.tap({
  sub open-menu  { ... }
  sub close-menu { ... }
  sub help       { ... }

  sub option1   { &?ROUTINE.name.say; }
  sub option2   { &?ROUTINE.name.say; }
  sub option3   { &?ROUTINE.name.say; }
  sub quit      { say "Quit!"; $a.exit; }

  my $menubar = GTK::MenuBar.new(
    GTK::MenuItem.new('File',
      :submenu(
        GTK::Menu.new(
          GTK::MenuItem.new('Open',  :clicked(&open-menu)),
          GTK::MenuItem.new('Close', :clicked(&close-menu)),
          GTK::MenuItem.new('Quit',  :clicked(&quit))
        )
      ),
    ),
    GTK::MenuItem.new('Edit',
       :submenu(
         GTK::Menu.new(
           GTK::MenuItem.new('Option 1', :clicked(&option1)),
           GTK::MenuItem.new('Option 2', :clicked(&option2)),
           GTK::MenuItem.new('Option 3', :clicked(&option3))
         )
       )
    ),
    # Takes a double click, because... EXPEXTING SUBMENU!
    GTK::MenuItem.new('Help', :clicked(&help), :right)
  );

  sub open-menu {
    say "The 'Open' menu item was clicked.";
  }

  sub close-menu {
    say "The 'Closed' menu item was clicked.";
  }

  sub help {
    say "IT'S A DEMO! -- there's no help for you.";
  }

  my $vbox = GTK::Box.new-vbox;
  $menubar.show;
  $vbox.pack_start($menubar);

  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
