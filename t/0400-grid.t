use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Button;
use GTK::Grid;

my $app = GTK::Application.new( title => 'org.genex.grid' );

# Ported from the Python example found in section 6.2.1 from:
# https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html

$app.activate.tap: SUB {
  my @b = gather for 'Button ' «~« (1...6) {
    take GTK::Button.new-with-label($_);
  }

  given (my $g = GTK::Grid.new) {
    .add(@b[0]);
    .attach(@b[1], 1, 0, 2, 1);
    .attach-adj-to(@b[0], @b[2], GTK_POS_BOTTOM, 1, 2);
    .attach-adj-to(@b[2], @b[3], GTK_POS_RIGHT, 2, 1);
    .attach(@b[4], 1, 2, 1, 1);
    .attach-adj-to(@b[4], @b[5], GTK_POS_RIGHT, 1, 1);
  }

  $app.window.add($g);
  $app.window.show_all;
}

$app.run;
