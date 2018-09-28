use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Menu;
use GTK::MenuBar;
use GTK::MenuItem;

my $a = GTK::Application.new( title => 'org.genex.menus' );

$a.activate.tap({
  # For a lark... let's see if subs can be pre-defined.
  sub open-menu  { ... }
  sub close-menu { ... }

  # Normal inline defs.
  sub option1   { &?ROUTINE.name.say; }
  sub option2   { &?ROUTINE.name.say; }
  sub option3   { &?ROUTINE.name.say; }
  sub quit      { $a.exit; }

  my $menubar = GTK::MenuBar.new(
    GTK::MenuItem.new('File',
      :submenu(
        GTK::Menu.new.append(
          GTK::MenuItem.new('Open',  :clicked(&open-menu)),
          GTK::MenuItem.new('Close', :clicked(&close-menu))
        )
      ),
    ),
    GTK::MenuItem.new('Edit',
      :submenu(
        GTK::Menu.new.append(
          GTK::MenuItem.new('Option 1', :clicked(&option1)),
          GTK::MenuItem.new('Option 2', :clicked(&option2)),
          GTK::MenuItem.new('Option 3', :clicked(&option3))
        )
      )
    ),
    GTK::MenuItem.new('Quit', :clicked(&quit), :right)
  );

  sub open-menu {
    say "The 'Open' menu item was clicked.";
  }

  sub close-menu {
    say "The 'Closed' menu item was clicked.";
  }

  my $vbox = GTK::Box.new-vbox;
  $vbox.pack($menubar);
  $a.window.show_all;

});

$a.run;
