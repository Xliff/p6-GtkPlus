use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::TextBuffer;
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
  $t.wrap_mode = GTK_WRAP_WORD;
  ($f.margin_top, $f.margin_bottom, $f.margin_left, $f.margin_right) =
    (10 xx 4);
  ($t.margin_left, $t.margin_right) = (10 xx 2);
  ($t.margin_top, $t.margin_bottom) = (5 xx 2);
  $f.add($t);

  # Next steps:
  # - Resize elements to match new window size... IF NECESSARY
  $a.window.destroy-signal.tap({
    my $tb = GTK::TextBuffer.new($t.buffer);
    my ($s, $e) = $tb.get_bounds;
    my $text = $tb.get_text($s, $e, False);
    say $text;
  });

  $a.window.add($f);
  $a.window.show_all;
});

$a.run;
