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
  my $hscale = GTK::Scale.new_with_range(0, 100, 1, :horizontal);
  my $vscale = GTK::Scale.new_with_range(0, 1, 0.05, :vertical);

   (my $mark = qq:to/MARK/) ~~ s:g/\n//;
 <span font="Chilanka 24" weight="bold" color="#993300">Scale Example</span>
 MARK

  $title.set_markup($mark);
  ($title.margin_top, $title.margin_bottom) = (20, 20);
  ($title.margin_left, $title.margin_right) = (30, 30);
  $hscale.add_mark(10, GTK_POS_TOP, Str);
  $hscale.add_mark(50, GTK_POS_BOTTOM, Str);
  $hscale.add_mark(90, GTK_POS_BOTTOM, Str);

  # Does not work properly, since current pattern does not return a value.
  $hscale.format-value.tap(
    sub ($, num64 $value, OpaquePointer $user_data --> Str) {
      "→ { $value } ←";
    }
  );
  $vscale.add_mark(0.1, GTK_POS_RIGHT, Str);
  $vscale.add_mark(0.5, GTK_POS_LEFT, Str);
  $vscale.add_mark(0.9, GTK_POS_LEFT, Str);
  $vscale.set_size_request(-1, 100);
  # Does not work properly, since current pattern does not return a value.
  $vscale.format-value.tap(
    -> $, num64 $value, OpaquePointer $user_data --> Str {
      "»{ $value }«";
    }
  );

  $vbox.pack_start($title, True, True, 0);
  $vbox.pack_start($vscale, True, True, 0);
  $vbox.pack_start($hscale, True, True, 4);

  $a.window.add($vbox);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.show_all;
});

$a.run;
