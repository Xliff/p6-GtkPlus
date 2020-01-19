use v6.c;

use GTK::Application;
use GTK::Builder;

my $ui-file = 't/shortcuts-builder.ui';
$ui-file = "t/$ui-file" unless $ui-file.IO.e;
die "Cannot find Builder definition UI file '{$ui-file}'" unless $ui-file.IO.e;

my $a = GTK::Application.new(
  title       => 'org.genex.gtk_builder_shortcuts',
  window-name => 'shortcuts-builder'
);
my $b = GTK::Builder.new( ui => $ui-file.IO.slurp );

$b<shortcuts-builder>.view-name = Str;
$b<shortcuts-builder>.set-default-size(800, 600);
$b<shortcuts-builder>.destroy-signal.tap({ $a.exit });
$b<shortcuts-builder>.show;
$a.run;
