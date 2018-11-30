use GTK::Widget;

die "Can't find 'BuildList' file!\n" unless 'BuildList'.IO.e;

my $mro;
for 'BuildList'.IO.open.slurp.lines {
  my @r;
  require ::($_);
  next if $_.^name ~~ /^ [ 'GTK::Raw::' | 'GTK::Roles::' | 'GTK::Compat' ] /;
  if ::($_) ~~ GTK::Widget {
    my $k = 0;
    my @o = ::($_).^mro;
    @r = @o;
    for @o {
      @r.splice($k, 0, $_.^roles);
      $k += $_.^roles.elems + 1;
    }
    # Note: Reusing $k
    $k = $_;
    $mro ~= (my $newline = "'{ $k }' => ({
      @r.map({ "'{ $_.^name }'" })
        .grep({ $_ ne "'$k'" })
        .reverse.unique.reverse
        .join(', ')
    }),\n");
    $newline.say;
  }
}

my $filename = 'lib/GTK/Builder/MRO.pm6';
if $filename.IO.e {
  my $fp = $filename.IO;
  my $f = $fp.open.slurp;
  my $mro_pre = '%mro is export =';
  # Regex with balanced syntax: s[S] = "R"
  $_ = $f;
  s❰ { $mro_pre } \s* '(' ~ ')' <-[)]>+ ❱ = "{ $mro_pre } (\n{ $mro }\n);";
  $fp.rename("{ $filename }.bak");
  my $fh = $filename.IO.open(:w);
  $fh.say($f);
  $fh.close;

  say "Replacement { $filename } was created successfully";
}
