use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Button;
use GTK::CheckButton;
use GTK::Frame;
use GTK::Grid;
use GTK::Label;
use GTK::Notebook;

# Ported from https://developer.gnome.org/gtk-tutorial/stable/x1450.html

my $a = GTK::Application.new( :title<org.genex.textview_example> );

$a.activate.tap({
  $a.window.border_width = 10;

  my $g = GTK::Grid.new;
  my $n = GTK::Notebook.new;

  $g.attach($n, 1, 1, 6, 1);
  $a.window.add($g);
  $n.tab_pos = GTK_POS_TOP;

  my $l;
  for (1..5).list {
    my $bf = "Append Frame $_";
    my $f = GTK::Frame.new($bf);

    $l = GTK::Label.new($bf);
    $f.add($l);
    $f.border_width = 10;
    $f.set_size_request(100, 75);

    $l = GTK::Label.new("Page $_");
    $n.append_page($f, $l);
  }

  my $cb = GTK::CheckButton.new_with_label("Check me please!");
  $cb.set_size_request(100, 75);
  $l = GTK::Label.new("Add Page");
  $n.insert_page($cb, $l, 2);

  for (1..5).list {
    my $bf = "Prepend Frame $_";
    my $f = GTK::Frame.new($bf);

    $l = GTK::Label.new($bf);
    $f.add($l);
    $f.border_width = 10;
    $f.set_size_request(100, 75);

    $l = GTK::Label.new("PPage $_");
    $n.prepend_page($f, $l)
  }

  # Sets current page to Page 4
  $n.current_page = 3;

  my $b = GTK::Button.new_with_label("close");
  $b.clicked.tap({ $a.exit; });
  $g.attach($b, 1, 2, 1, 1);

  $b = GTK::Button.new_with_label("next page");
  $b.clicked.tap({ $n.next_page; });
  $g.attach($b, 2, 2, 1, 1);

  $b = GTK::Button.new_with_label("prev page");
  $b.clicked.tap({ $n.prev_page; });
  $g.attach($b, 3, 2, 1, 1);

  $b = GTK::Button.new_with_label("tab position");
  $b.clicked.tap({
    $n.tab_pos = $n.tab_pos == GTK_POS_BOTTOM ??
      GTK_POS_LEFT !! $n.tab_pos.succ;
  });
  $g.attach($b, 4, 2, 1, 1);

  $b = GTK::Button.new_with_label("tabs/borders on/off");
  $b.clicked.tap({
      $n.show_tabs = !$n.show_tabs;
      $n.show_border = !$n.show_border;
  });
  $g.attach($b, 5, 2, 1, 1);

  $b = GTK::Button.new_with_label("remove page");
  $b.clicked.tap({
    my $p = $n.current_page;
    say "Removing page $p";
    $n.remove_page($p);
    $n.queue_draw;
  });
  $g.attach($b, 6, 2, 1, 1);

  $a.window.show_all;
});

$a.run;
