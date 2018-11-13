use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::CheckButton;
use GTK::Frame;
use GTK::Grid;
use GTK::Label;
use GTK::Pane;

my @w;
my $a = GTK::Application.new( title => 'org.genex.pane-test' );

sub create_pane_options($pane, $flabel, $l1, $l2) {
  my %widgets;
  %widgets<frame table label1 label2> = (
    GTK::Frame.new($flabel),
    GTK::Grid.new,
    GTK::Label.new($l1),
    GTK::Label.new($l2)
  );
  my ($child1, $child2) = $pane.get_children;

  %widgets<frame>.border_width = 4;
  %widgets<frame>.add(%widgets<table>);
  for (0, 1) {
    my $num = $_ + 1;
    my ($cbutton1, $cbutton2) = (
      GTK::CheckButton.new_with_mnemonic('_Resize'),
      GTK::CheckButton.new_with_mnemonic('_Shrink')
    );

    $cbutton2.active = True;
    $cbutton1.active = so $num == 2;
    $cbutton1.toggled.tap(-> *@a {
      my $child = ::("\$child{$num}");
      $pane.remove($child);
      $num == 1 ??
        $pane.pack1($child, $cbutton1.active.not, $cbutton2.active)
        !!
        $pane.pack2($child, $cbutton1.active.not, $cbutton2.active)
    });

    $cbutton2.toggled.tap(-> *@a {
      my $child = ::("\$child{$num}");
      $pane.remove($child);
      $num == 1 ??
        $pane.pack1($child, $cbutton1.active, $cbutton2.active.not)
        !!
        $pane.pack2($child, $cbutton1.active, $cbutton2.active.not)
    });

    %widgets<table>.attach(%widgets{"label{$num}"}, $_, 0, 1, 1);
    %widgets<table>.attach($cbutton1              , $_, 1, 1, 1);
    %widgets<table>.attach($cbutton2              , $_, 2, 1, 1);
    @w.push: $cbutton1, $cbutton2;
  }
  @w.append: %widgets.values;

  %widgets<frame>;
}

$a.activate.tap({
  my ($frame1, $frame2, $frame3, $vpaned, $hpaned, $vbox, $button);
  $a.window.title = 'Paned Widgets';
  $a.window.border_width = 0;

  $vbox = GTK::Box.new-vbox(0);
  $hpaned = GTK::Pane.new-hpane;
  $vpaned = GTK::Pane.new-vpane;
  $vpaned.border_width = 5;
  $vpaned.add1($hpaned);

  $button = GTK::Button.new_with_mnemonic('_Hi there');
  $frame1 = GTK::Frame.new('');
  $frame1.shadow_type = GTK_SHADOW_IN;
  $button.set_size_request(60, 60);
  $frame1.add($button);
  $hpaned.add1($frame1);

  $frame2 = GTK::Frame.new('');
  $frame2.shadow_type = GTK_SHADOW_IN;
  $frame2.set_size_request(80, 60);
  $hpaned.add2($frame2);
  $frame3 = GTK::Frame.new('');
  $frame3.shadow_type = GTK_SHADOW_IN;
  $frame3.set_size_request(60, 80);
  $vpaned.add2($frame3);

  $vbox.pack_start($vpaned, True, True);
  $vbox.pack_start(
    create_pane_options($hpaned, 'Horizontal', 'Left', 'Right')
  );
  $vbox.pack_start(
    create_pane_options($vpaned, 'Vertical', 'Top', 'Bottom')
  );

  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
