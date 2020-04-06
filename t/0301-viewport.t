use v6.c;

use GTK::Application;
use GTK::Label;
use GTK::Viewport;

my $title = 'org.genex.viewport';
my $a = GTK::Application.new(:$title);

$a.activate.tap({
  my $v = GTK::Viewport.new;
  my $l = GTK::Label.new;

  $l.set-markup(qq:to/MARKUP/);
    This is the Raku p6-GtkPlus Viewport example
    © 2020 by Clfton Wood
    Based on the example Python code found at:
      https://programtalk.com/python-examples/gtk.Viewport/

    Application title is <span color="blue">{$title}</span>
    MARKUP

  $v.add($l);
  $a.window.add($v);
  $a.window.show-all;
});

$a.run;
