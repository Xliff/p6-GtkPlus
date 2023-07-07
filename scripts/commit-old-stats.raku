#!p6gtkexec
use v6;

#"stats".IO.dir.grep({ my $p = run("git ls-files --error-unmatch { .absolute }"); $p.exitcode == 1 }).sort( *.basename )
my $tot = 0;
for %*ENV<PROJECTS>.split(/\s+/) {
  my $P = $*HOME.add('Projects');

  my $stats-dir;
  unless ($stats-dir = $P.add("p6-{ $_ }") ).d {
  	$stats-dir = $P.add("raku-{ $_ }");
  }
  $stats-dir .= add("stats");

  die "Could not find stats directory '{ $stats-dir.absolute }'" 
    unless $stats-dir.d;

  chdir $stats-dir.absolute;

  my %d;
  my @f = $stats-dir.IO.dir.grep(
    sub ($_) { 
      my $m = .absolute ~~ /(\d+) $/; 
      return False unless $m; 
      $m .= Int if $m; 

      my $contents = .slurp;
      my $rakuver = if $contents ~~ / ( 'Raku' .+? ) $$/ -> $m {
        $m[0];
      } elsif $contents ~~ / ('Rakudo' .+? ) 'on'/ -> $m {
        $m[0];
      } else {
        return False;
      }
      %d{ $m } = $rakuver;
      $m >= 20220328.pred
    }
  );

  my %versions;
  for @f {
    my $m  = .absolute ~~ /(\d+) $/; 
    my $rv = %d{$m} // $d{$m - 1} // $d{$m + 1}; 
    
    next unless $rv;
	
    qqx«git add { .absolute }»;
    qqx«git commit -m 'Build statatistics for { $rv }'»;

    say "Added { .absolute } to repository";
  }

  $tot += +@f;
}

say "{ $tot } uncommitted statistics files.";
