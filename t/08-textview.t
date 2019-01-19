use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Frame;
use GTK::TextBuffer;
use GTK::TextView;

my $a = GTK::Application.new(
  :title('org.genex.textview_example'),
  :width(200),
  :height(400)
);

$a.activate.tap({
  my $t = GTK::TextView.new();
  my $v = GTK::Box.new-vbox;
  my $f = GTK::Frame.new(' TextView ');
  my $tb = GTK::Button.new_with_label('Add Sample text as Str');
  my $bb = GTK::Button.new_with_label('Add Sample text as Buf');
  $t.set_size_request(200, 300);
  .margins = 10 for $tb, $bb;
  $t.wrap_mode = GTK_WRAP_WORD;
  ($f.margin_top, $f.margin_bottom, $f.margin_left, $f.margin_right) =
    (10 xx 4);
  ($t.margin_left, $t.margin_right) = (10 xx 2);
  ($t.margin_top, $t.margin_bottom) = (5 xx 2);
  $f.add($t);
  $v.add($_) for $f, $tb, $bb;

  $bb.clicked.tap({
    $t.buffer.append("Every good boy deserves fudge!\n".encode);
  });
  $tb.clicked.tap({
    $t.buffer.append(qq:to/T/);
Now is the time for all good men to come to the aid of their country!
T
  });

  $a.window.destroy-signal.tap({
    say $t.text;
  });

  $a.window.add($v);
  $a.window.show_all;
});

$a.run;
