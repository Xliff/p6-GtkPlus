use v6.c;

use GTK::Application;
use GTK::Dialog::About;
use GTK::Image;

my $a = GTK::Application.new( title => 'org.genex.about_dialog' );

$a.activate.tap({
  my $logo = './camelia-gtk.png';
  $logo = 't/camelia-gtk.png' unless $logo.IO.e;
  warn "Can't find proper logo" unless $logo.IO.e;
  my $i = GTK::Image.new_from_file($logo);
  my $d = GTK::Dialog::About.new;

  $d.transient_for = $a.window;
  $d.modal = True;
  $d.logo = $i;
  $d.artists = 'Xliff';
  $d.authors = 'Xliff';
  $d.documenters = "We don't need no steeking docuwentation!";
  $d.program_name = '23-about.t';
	$d.comments = 'We are testers... dun da dun dun dun dun dun...';
	$d.copyright = 'Copyright © 2018 by Xliff';
	$d.version = 'ε';

	$d.license = qq:to/L/;
Why would this piece of 💩 need a license? Why would this piece of 💩 need a license? Why would this piece of 💩 need a license?'
L

	$d.wrap_license = True;
	$d.website = "http://github.com/Xliff/p6-GtkPlus/";
	$d.website_label = "Perl6 GtkPlus";
  say "HI!";

  $d.run;
  $a.exit;
});

$a.run;
