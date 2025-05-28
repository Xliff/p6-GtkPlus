use v6.c;

use JSON::Fast;

my (%existing-modules, %buildlists);

sub get-modules ($p is copy) {
  state %processed;

  return if %processed{$p};
  %processed{$p} = True;

  say "Checking for { $p } ...";
  $p = %existing-modules{ $p }<location> if $p.contains('/').not;
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
    if $m ~~ m/':' <[a..z\<\>0..9]>+ ';'? $/ -> $match {
      $m.substr-rw( $match.from, $match.to - $match.from ) = '';
    }
    next if $m ~~ /'v6.' <[c..z]> /;
    take $m;
  }
}

sub get-manifest ($p) {
  my @m = get-modules($p);

  # cw: Don't use your input as a return... DOOFUS!
  my @return;
  while ($_ = @m.shift) {
    # cw: Oh yeah.... THIS is why I procratinated...
    @return.push: $_;
    if get-modules($_) -> $more  {
      for $more[] -> $mod is copy {
        $mod .= chop if $mod.ends-with(';');
        next if $mod eq <NativeCall v6 nqp>.any;
        say "Adding { $mod }...";
        @m.push: $mod;
      }
    }
  }

  @return.unique.sort[];
}


sub MAIN ($program) {
  # cw: The driver for this loop should be all of the -I directives
  for $*REPO.repo-chain.grep(
    CompUnit::Repository::FileSystem
  ).kv -> $k, $v {
    CATCH {
      default { say "WTF? { .message }"; next }
    }

    my $p = $v.Str.IO.parent;
    my $df = $p.add('META6.json');
    next unless $df.r;

    my %project-modules = from-json($df.slurp);
    my $provides = %project-modules<provides>;

    unless %buildlists{$v}.defined {
      my $bl = $p.add('BuildList');
      if $bl.r {
        %buildlists{$v} = $bl.slurp.lines.Array;
      } else {
        %buildlists{$v} = False;
      }
    }

    next unless $provides;

    for $provides.pairs {
      .value = $df.parent.absolute ~ '/' ~ .value;
      %existing-modules{ .key } = %(
        location   => .value,
        order      => $k * 1000 + ( %buildlists{$v}.first( .key, :k ) // 0 )
      );
    }
  }

  my @manifest = get-manifest($program);
  .say for @manifest.sort({
    do with %existing-modules{ $_ } -> $e {
      ( $e<order>, $_ )
    } else {
      ( 0, $_ );
    }
  })[];
  $*ERR.say: "{ @manifest.elems } modules found in { now - INIT now }s";
}
