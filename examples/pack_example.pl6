use v6.c;

use GTK::Application;
use GTK::Button;
use GTK::Box;
use GTK::Label;
use GTK::Separator;
use GTK::Window;

use GTK::Raw::Types;

sub USAGE {
    use nqp;
		say nqp::getlexcaller(q|$*USAGE|) ~ qq:to/USAGE/;
    \n\nWHERE
        <num> should be an integer from 1 to 3
    USAGE
}

sub make_box($h, $s, $e, $f, $p) {
  my $box = GTK::Box.new-hbox($s);
  $box.homogeneous = $h;
  my $b0 = GTK::Button.new_with_label( "gtk_box_pack" );
  my $b1 = GTK::Button.new_with_label( "(box," );
  my $b2 = GTK::Button.new_with_label(  "button, " );
  my $b3 = GTK::Button.new_with_label(  "{ $e.Str.uc }, " );
  my $b4 = GTK::Button.new_with_label(  "{ $f.Str.uc }, " );
  my $b5 = GTK::Button.new_with_label(  "$p);" );

  $box.pack_start($_, $e, $f, $p) for ($b0, $b1, $b2, $b3, $b4, $b5);
  $box;
}

sub setup1 {
  my $label = GTK::Label.new( 'gtk_hbox_new (FALSE, 0)' );
  my $box2 = make_box(False, 0, False, False, 0);
  my $box3 = make_box(False, 0, True, False, 0);
  my $box4 = make_box(False, 0, True, True, 0);
  my $sep1 = GTK::Separator.new(:horizontal);

  $*box1.pack_start($_, False, False, 0) for ($label, $box2, $box3, $box4);
  $*box1.pack_start($sep1, False, True, 5);

  my $label2 = GTK::Label.new( 'gtk_hbox_new(TRUE, 0)' );
  my $box5 = make_box(True, 0, True, False, 0);
  my $box6 = make_box(True, 0, True, True, 0);
  my $sep2 = GTK::Separator.new(:horizontal);

  $*box1.pack_start($_, False, False, 0) for ($label2, $box5, $box6);
  $*box1.pack_start($sep2, False, True, 5);
}

sub setup2 {
  my $label = GTK::Label.new( 'gtk_hbox_new(FALSE, 10)' );
  my $box2 = make_box(False, 10, True, False, 0);
  my $box3 = make_box(False, 10, True, True, 0);
  my $sep1 = GTK::Separator.new(:horizontal);

  $*box1.pack_start($_, False, False, 0) for ($label, $box2, $box3);
  $*box1.pack_start($sep1, False, True, 5);

  #gtk_misc_set_alignment (GTK_MISC (label), 0, 0);
  my $label2 = GTK::Label.new( 'gtk_hbox_new(FALSE, 0)' );
  my $box4 = make_box(False, 0, True, False, 10);
  my $box5 = make_box(False, 0, True, True, 10);
  my $sep2 = GTK::Separator.new(:horizontal);

  $*box1.pack_start($_, False, False, 0) for ($label2, $box4, $box5);
  $*box1.pack_start($sep2, False, True, 5);
}

sub setup3 {
  my $box2 = make_box(False, 0, False, False, 0);
  my $label = GTK::Label.new('end');

  $box2.pack_end($label, False, False, 0);
  $*box1.pack_start($box2, False, False, 0);

  my $sep1 = GTK::Separator.new(:horizontal);
  $sep1.set_size_request(400, 5); # Replacement for set_usize
  $*box1.pack_start($sep1, False, True, 0);
}

sub MAIN(Int $num where 1..3) {

  GTK::Application.init;

  my $app = GTK::Application.new(
    :title('org.genex.pack_example'),
  );

  my $*box1 = GTK::Box.new-vbox(10);
  my $*window = GTK::Window.new(
    GTK_WINDOW_TOPLEVEL, :title('Pack Example'), :width(600)
  );

  $*window.border_width = 10;

  &::("setup{$num}")();

  my ($qb, $qbox) = (
    GTK::Button.new_with_label("Quit"),
    GTK::Box.new-hbox(0)
  );
  $qb.clicked.tap({ $app.exit });
  $qbox.pack_start($qb, False, False, 0);
  $*box1.pack_start($qbox, False, False, 0);

  $*window.add($*box1);
  $*window.show_all;

  $app.add_window($*window);

  $app.run;
}
