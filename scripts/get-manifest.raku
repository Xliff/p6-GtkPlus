use v6.c;

use JSON::Fast;

my %existing-modules;

sub get-modules ($p is copy) {
  $p = %existing-modules{ $p } if $p.contains('/').not;
  $p = $p.head if $p ~~ Positional;

  return Nil unless $p;

  $*ERR.say: "Reading { $p } ...";
  my $pio = $p.IO;

  return Nil unless $pio.r;

  do gather for $pio.slurp.lines.grep( *.contains('use' | 'need') ) {
    next if .starts-with('#');
    next if .starts-with('use' | 'need').not;

    my $m = .subst(/^ [ 'use' | 'need' ]/, '');
    $m.chomp if .ends-with(';');
    $m .= trim;
    if $m ~~ m/':' <[a..z\<\>0..9]>+ ';'? $$ / -> $match {
      $m.substr-rw( $match.from, $match.to - $match.from ) = '';
    }
    next if $m ~~ /'v6.' <[c..z]> /;
    take $m;
  }
}

sub get-manifest ($p) {
  my @m = get-modules($p);

  while ($_ = @m.shift) {
    # cw: Oh yeah.... THIS is why I procratinated...
    if get-modules($_) -> $more {
      @m.append: $more;
    }
  }

  @m.unique.sort.say;
}


sub MAIN ($program) {
  # cw: The driver for this loop should be all of the -I directives
  for $*REPO.repo-chain.grep( CompUnit::Repository::FileSystem ) {
    CATCH {
      default { say "WTF? { .message }"; next }
    }

    my $df = .Str.IO.parent.add('META6.json');
    next unless $df.r;

    my %project-modules = from-json($df.slurp);
    my $provides = %project-modules<provides>;

    next unless $provides;

    .value = $df.parent.absolute ~ '/' ~ .value for $provides.pairs;

    %existing-modules.append: $provides.pairs;
  }
  %existing-modules.gist.say;

  get-manifest($program);
}
