use v6.c;

use File::Find;

my (%resolved-check, @resolved, %nodes);

use Data::Dump::Tree;

sub resolve($n, $l, $seen = {}) {
  # I hate special casing, but this begs for it.
  return if $n eq 'GTK';
  die "No node information for $n" unless %nodes{$n}:exists;

  my $i = "\t" x $l;
  sub mark-resolved($rn) {
    return if %resolved-check{$rn};
    say "{ $i }Resolved: { $rn }";
    @resolved.push: $rn;
    %resolved-check{$rn} = True;
    $seen{$rn}:delete;
  }

  say "{ $i }{ $n }";
  $seen{$n} = True;
  for %nodes{$n}<edges>.List {
    unless %resolved-check{$_} {
      my $level = $l;
      die "Circular dependency detected: { $n } -> { $_ }" if $seen{$_};
      resolve($_, ++$level, $seen);
    }
    LAST {
      mark-resolved($_);
    }
  }
  mark-resolved($n);
}

my @files = find
  dir => 'lib',
  name => /'.pm6' $/,
  exclude => / 'lib/GTK.pm6' | 'lib/GTK/Compat/GFile.pm6' /;

my @modules = @files
  .map( *.path )
  .map({ my $mn = $_; [ $mn, S/ '.pm6' // ] })
  .map({ $_[1] = $_[1].split('/').Array[1..*].join('::'); $_ })
  .sort( *[1] );

%nodes{$_[1]} = ( filename => $_[0], edges => [] ).Hash for @modules;

my @others;
for %nodes.pairs.sort( *.key ) -> $p {
  say "Processing requirements for module { $p.key }...";

  my $f = $p.value<filename>;
  my $m = $f.IO.open.slurp-rest ~~ m:g/'use' \s+ $<m>=((\w+)+ % '::') \s* ';'/;
  for $m.list -> $mm {
    my $mn = $mm;
    $mn ~~ s/'use' \s+//;
    $mn ~~ s/';' $//;
    unless $mn ~~ /^ 'GTK'/ {
      @others.push: $mn;
      next;
    }
    %nodes{$p.key}<edges>.push: $mn;
  }
}

say "\nA resolution order is:\n";

my %unresolved = %nodes.pairs.map( *.key => True );
while (my @unresolved = %unresolved.keys.sort).elems {
  my $l = 0;
  my $seen = {}
  resolve(@unresolved[0], $l, $seen);
  %unresolved{$_}:delete for $seen.keys;
  %unresolved{@unresolved[0]}:delete;
}

say "\nOther dependencies are:\n";
say @others.unique.sort.join("\n");
