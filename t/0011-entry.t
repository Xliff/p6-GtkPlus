use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Entry;
use GTK::Label;

my $a = GTK::Application.new( :title('org.genex.entry_example') );

sub exit-app($e) {
  say "Text in entry is '{ $e.text }'";
  $a.exit;
}

$a.activate.tap: SUB {
  my $title  = GTK::Label.new;
  my $vbox1  = GTK::Box.new-vbox(6);
  my $hbox   = GTK::Box.new-hbox(2);
  my $clear  = GTK::Button.new_with_label('Clear');
  my $quit   = GTK::Button.new_with_label('Quit');
  my $entry  = GTK::Entry.new;

  ($title.margin-top, $title.margin-bottom) = 20 xx 2;
  ($title.margin-left, $title.margin-right) = 15 xx 2;
  $title.set_markup(do { (my $mark = qq:to/MARK/) ~~ s:g/\n//; $mark });
<span font="Microgramma Bold 18" color="#224488">ENTRY EXAMPLE</span>
MARK

  $clear.clicked.tap({ $entry.text = '' });
  $quit.clicked.tap({ exit-app($entry) });

  $hbox.pack_start($_)  for $entry, $clear, $quit;
  $vbox1.pack_start($_) for $title, $hbox;
  $a.window.add($vbox1);
  $a.window.show-all;
}

$a.run;
