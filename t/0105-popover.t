use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::ModelButton;
use GTK::Popover;

my $a = GTK::Application.new( title => 'org.genex.popover' );

$a.activate.tap({
  my $b  = GTK::Button.new-with-label('Click Me');
  my $ob = GTK::Box.new-vbox(6);
  my $p  = GTK::Popover.new;
  my $vb = GTK::Box.new-vbox;

  $p.position = GTK_POS_BOTTOM;
  $p.add($vb);
  $ob.add($b);

  my @vb-items = (
    GTK::ModelButton.new-with-label('Item 1'),
    GTK::Label.new('Item 2')
  );

  $vb.pack-start($_, False, True, 10) for @vb-items;

  $b.clicked.tap({
    $p.relative-to = $b;
    $p.show-all;
    $p.show;
  });

  @vb-items[0].clicked.tap({ say 'Item 1 was clicked' });

  $a.window.add($ob);
  $a.window.title = 'Popover Demo';
  $a.window.show-all;
});

$a.run;
