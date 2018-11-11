use GTK::Widget;

die "Can't find 'BuildList' file!\n" unless 'BuildList'.IO.e;

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
    say "'{ $k }'" => "({
      @r.map({ "'{ $_.^name }'" })
        .grep({ $_ ne "'$k'" })
        .reverse.unique.reverse
        .join(', ')
    }),";
  }
}
