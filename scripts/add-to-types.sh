#!/usr/bin/env raku

sub MAIN ($new-compunit) {
  my $dirs = `$*HOME/bin/get-project-dirs.sh`;

  for $dirs {
    chdir($dirs);
    {
      use GTKScripts;

      my $type-io   = "lib/{ %config<prefix> }/Raw/Types.pm6".IO;
      my $type-file = $type-io.slurp;

      $type-file ~~ m:g/ ^^ 'need' .+? $$/;

      $type-file.substr-rw(0, $/.tail.to) ~= qq:to/ADDEDNEED/;

         need { $new-compunit };
         ADDEDNEED

      $type-io.rename( $type-io.absolute ~ '.added-need-bak' );
      $type-io.spurt: $type-file;
    }
  }
