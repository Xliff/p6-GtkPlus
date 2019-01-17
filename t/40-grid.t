use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Grid;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }

  my GTK::Button $exit .= new_with_label: <exit>;
  my GTK::Button $hello .= new_with_label: <hello>;
  my GTK::Button $world .= new_with_label: <world>;
  my GTK::Button $walking  .= new_with_label: 'Walking';
  my GTK::Button $on       .= new_with_label: 'On';
  my GTK::Button $sunshine .= new_with_label: 'Sunshine';
  my GTK::Button $a        .= new_with_label: 'a';
  my GTK::Button $b        .= new_with_label: 'b';
  my GTK::Button $c        .= new_with_label: 'c';
  my GTK::Button $d        .= new_with_label: 'd';
  my GTK::Button $well     .= new_with_label: '...Well';

  $exit.clicked.tap: { $app.exit  };

  my GTK::Grid $grid .= new;

  my $t = 0;
  my $l = 0;
  $grid.attach: $a, $l++, $t++, 1, 1;
  $grid.attach: $b, $l++, $t++, 1, 1;
  $grid.attach: $c, $l++, $t++, 1, 1;
  $grid.attach: $d, $l++, $t++, 1, 1;

  $grid.attach: $hello,    0, $t++, 1, 1;
  $grid.attach: $world,    1, $t++, 1, 1;
  $grid.attach: $sunshine, 2, $t++, 2, 2;

  # (2, 5) coordinate are where the LL corner is added.
  # GTK automatically expands this up one row row, since
  # it will fit, so actual coordinates become (2, 4)
  $grid.attach-next-to: $walking, $sunshine, GTK_POS_TOP, 1, 1;
  
  #$grid.attach-next-to: $on, $walking, GTK_POS_RIGHT, 1, 1;
  #$grid.insert_next_to: $hello, GTK_POS_TOP;
  #$grid.insert_next_to: $hello, GTK_POS_LEFT;
  #$grid.insert_next_to: $hello, GTK_POS_RIGHT;
  #$grid.insert_next_to: $hello, GTK_POS_BOTTOM;

  #$grid.attach_next_to: $well, $world, GTK_POS_BOTTOM, 1, 1;

  my @c = $grid.get-children();
  for @c {
    say '»' x 10;
    say $_.label;
    say $grid.get-child-info($_)<l t w h>.gist;
  }


  my $box = GTK::Box.new-vbox(4);

  $box.pack_start($grid, False, True, 0);
  $box.pack_start($exit, False, True, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;
