#!/usr/bin/env raku

sub MAIN (
  :$log = 'LastBuildResults'
) {

  my $max-chars = %*ENV<PROJECTS>.words.map( *.chars ).max;

  for %*ENV<PROJECTS>.words {
    my $pio = "{ $*HOME }/Projects".IO;
    my $lbr = do { 
	my $io = $pio.add("p6-{ $_ }");
	if $io.d {
		$io .= add($log);
	} elsif ( $io = $pio.add("raku-{ $_ }") ).d {
		$io .= add($log)
	} 
	$io
    }
    unless $lbr.r {
      say "No build results for { $_ }. Skipping...";
      next;
    }

    my $errors = $lbr.slurp ~~
      #m:g/'SORRY!' .+?"\n"(.+)"\n" /;
      m:g/'SORRY!'/;

    print .fmt("%-{ $max-chars + 2 }s");
    print " - { $errors.elems }" if $errors;
    print "\n";
  }
}
