use v6.c;

use lib 'scripts';

use GTKScripts;
#use GTK::Widget;

my @files = find-files(
  'lib',
  extension => 'pm6',
  exclude   => rx/ 'Compat' | 'Raw' | 'Roles' /
);

my @widgets = @files
  .map( *.path );
  # .grep({
  #   require ::($_);
  #   return False if ::($_) ~~ Failure;
  #   ::($_) ~~ GTK::Widget;
  # });

say "use v6.c;\n";
say "need $_;" for @widgets
  .map({ S/ '.pm6' // })
  .map( *.split('/').Array[1..*].join('::') )
  .sort;

# for @widgets.sort {
#   my $m = .IO.open.slurp-rest ~~ / 'method' \s+ 'new' \s* '(GtkWidget' /;
#   say "No widget constructor for { $_.path }" unless $m;
# }
