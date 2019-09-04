use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::CheckButton;
use GTK::ComboBoxText;
use GTK::Frame;
use GTK::Grid;
use GTK::Label;
use GTK::SizeGroup;
use GTK::Window;

sub create_combo_box (@strings) {
  my $c = GTK::ComboBoxText.new(@strings);
  $c.active = 0;
  $c;
}

sub add_row ($g, $r, $sg, $lt, @options) {
  my $cb = create_combo_box(@options);
  my $l = GTK::Label.new_with_mnemonic($lt);

  $l.halign = GTK_ALIGN_START;
  $l.valign = GTK_ALIGN_BASELINE;
  $l.hexpand = True;
  $g.attach($l, 0, $r, 1, 1);
  $l.mnemonic_widget = $cb;
  $sg.add_widget($cb);
  $g.attach($cb, 1, $r, 1, 1);
}

sub toggle_grouping($cb, $sg) {
  $sg.mode = $cb.active ?? GTK_SIZE_GROUP_HORIZONTAL !! GTK_SIZE_GROUP_NONE;
}

my $a = GTK::Application.new(
  title  => 'org.genex.sizegroup',
  width  => 235,
  height => 250,
  # pod    => $=pod
);

# Not working like the GTK demo... is there something off with
# the GTK::Grid?
$a.activate.tap({
  my @colors = <Red Green Blue>;
  my @dashes = <Solid Dashed Dotted>;
  my @ends = ('Square', 'Round', 'Double Arrow');

  my $vb = GTK::Box.new-vbox(5);
  $vb.border_width = 5;
  $a.window.add($vb);
  $a.window.resizable = False;

  my $sg = GTK::SizeGroup.new(:horizontal);
  my $f1 = GTK::Frame.new('Color Options');
  my $g1 = GTK::Grid.new;
  $vb.pack_start($f1, True, True);
  ($g1.border_width, $g1.row_spacing, $g1.column_spacing) = (5, 5, 10);
  $f1.add($g1);
  add_row($g1, 0, $sg, '_Foreground', @colors);
  add_row($g1, 1, $sg, '_Background', @colors);

  my $f2 = GTK::Frame.new('Line Options');
  my $g2 = GTK::Grid.new;
  $vb.pack_start($f2, True, True);
  ($g2.border_width, $g2.row_spacing, $g2.column_spacing) = (5, 5, 10);
  $f2.add($g2);
  add_row($g2, 0, $sg, '_Dashing', @dashes);
  add_row($g2, 1, $sg, '_Line ends', @ends);

  my $cb = GTK::CheckButton.new_with_mnemonic('_Enable groupping');
  $cb.active = True;
  $cb.toggled.tap({ toggle_grouping($cb, $sg) });
  $vb.pack_start($cb);

  $a.window.show_all;
});

$a.run;

# =begin css
# label { padding-bottom: 6px; }
# =end css
