use v6.c;

use GTK::Application;
use GTK::Frame;
use GTK::TextView;

my $a = GTK::Application.new(
  :title('org.genex.textview_example'),
  :width(200),
  :height(400)
);

$a.activate.tap({
  my $t = GTK::TextView.new();
  my $f = GTK::Frame.new(' TextView ');
  ($f.margin_top, $f.margin_bottom, $f.margin_left, $f.margin_right) =
    (10 xx 4);
  ($t.margin_left, $t.margin_right) = (10 xx 2);
  ($t.margin_top, $t.margin_bottom) = (5 xx 2);
  $f.add($t);

  # Next steps:
  # - Turn on word-wrap
  # - Resize elements to match new window size... IF NECESSARY
  # - Get the text buffer on exit and output it to console BEFORE
  #   closing the app.

  $a.window.add($f);
  $a.window.show_all;
});

$a.run;
