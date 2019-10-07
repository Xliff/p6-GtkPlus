use v6.c;

use Test;

use GTK::Compat::Types;

use GIO::FileAttributeMatcher;

sub test-exact {
  my @exact-matches = <
    *
    a::*
    a::*,b::*
    a::a,a::b
    a::a,a::b,b::*
  >;

  for @exact-matches {
    my $matcher = GIO::FileAttributeMatcher.new($_);

    is  ~$matcher, $_,  "Stringified FileAttributeMatcher matches '{$_}'";
  }
}

sub test-equality {
}

test-exact;
