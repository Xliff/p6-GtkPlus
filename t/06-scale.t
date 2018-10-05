v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Label;
use GTK::Scale;

use NativeCall;

my $a = GTK::Application.new( :title('org.genex.scale_example') );

$a.activate.tap({
  my $title  = GTK::Label.new;
  my $vbox   = GTK::Box.new-vbox(6);
  my $hscale = GTK::Scale.new_with_range(GTK_ORIENTATION_HORIZONTAL, 0, 100, 1);
  my $vscale = GTK::Scale.new_with_range(GTK_ORIENTATION_VERTICAL, 0, 1, 0.05);

   (my $mark = qq:to/MARK/) ~~ s:g/\n//;
 <span font="Chilanka 24" weight="bold" color="#993300">Scale Example</span>
 MARK

  $title.set_markup($mark);
  ($title.margin_top, $title.margin_bottom) = (20, 20);
  ($title.margin_left, $title.margin_right) = (30, 30);
  $hscale.add_mark(10, GTK_POS_TOP, Str);
  $hscale.add_mark(50, GTK_POS_BOTTOM, Str);
  $hscale.add_mark(90, GTK_POS_BOTTOM, Str);

  # Formatting stops working after a while. Bug in GTK?
  $hscale.format-value(:!supply).tap(-> $, $v, $ --> Str {
    "→ { $v } ←";
  });

  $vscale.add_mark(0.1, GTK_POS_RIGHT, Str);
  $vscale.add_mark(0.5, GTK_POS_LEFT, Str);
  $vscale.add_mark(0.9, GTK_POS_LEFT, Str);
  $vscale.set_size_request(-1, 100);
  $vscale.format-value(:!supply).tap(-> $, $v, $ --> Str {
    "»{ $v }«";
  });

  $vbox.pack_start($title, True, True, 0);
  $vbox.pack_start($vscale, True, True, 0);
  $vbox.pack_start($hscale, True, True, 4);

  $a.window.add($vbox);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.show_all;
});

$a.run;
