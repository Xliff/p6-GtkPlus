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
  # star makes everything else go away
  my @equals = (
    # Expected      # Actual
    '*'         =>  '*,*',
    '*'         =>  '*,a::*',
    '*'         =>  '*,a::b',
    '*'         =>  'a::*,*',
    '*'         =>  'a::b,*',
    '*'         =>  'a::b,*,a::*',
    # a::* makes a::<anything> go away
    'a::*'      => 'a::*,a::*',
    'a::*'      => 'a::*,a::b',
    'a::*'      => 'a::b,a::*',
    'a::*'      => 'a::b,a::*,a::c',
    # a::b does not allow duplicates
    'a::b'      => 'a::b,a::b',
    'a::b,a::c' => 'a::b,a::c,a::b',
    # stuff gets ordered in registration order
    'a::b,a::c' => 'a::c,a::b',
    'a::*,b::*' => 'b::*,a::*',
  );

  for @equals {
    my $matcher = GIO::FileAttributeMatcher.new(.value);

    is  ~$matcher, .key,
        "Stringified FileAttributeMatcher '{.value}' matches '{.key}";
  }
}

test-exact;
test-equality;
