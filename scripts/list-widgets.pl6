use v6.c;

use File::Find;

my @files = find
  dir => 'lib',
  name => /'.pm6' $/,
  exclude => / 'Compat' | 'Raw' | 'Roles' /;

say "use v6.c;\n";
my @widgets = @files
  .map( *.path )
  .grep(
    * ne <
      lib/GTK.pm6
      lib/GTK/Application.pm6
      lib/GTK/Builder.pm6
      lib/GTK/ListStore.pm6
    >.any
   );

say "need $_;" for @widgets
  .map({ S/ '.pm6' // })
  .map( *.split('/').Array[1..*].join('::') )
  .sort;

# for @widgets.sort {
#   my $m = .IO.open.slurp-rest ~~ / 'method' \s+ 'new' \s* '(GtkWidget' /;
#   say "No widget constructor for { $_.path }" unless $m;
# }
