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
  my @equals = (
    # Expected      # Actual

    # star makes everything else go away
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

sub test-subtract {
  my @subtractions = (
    # subtracts everything

    # Attributes        # Subtract   # Result
    [ '*',              '*',         Nil ],
    [ 'a::*',           '*',         Nil ],
    [ 'a::b',           '*',         Nil ],
    [ 'a::b,a::c',      '*',         Nil ],
    [ 'a::*,b::*',      '*',         Nil ],
    [ 'a::*,b::c',      '*',         Nil ],
    [ 'a::b,b::*',      '*',         Nil ],
    [ 'a::b,b::c',      '*',         Nil ],
    [ 'a::b,a::c,b::*', '*',         Nil ],
    [ 'a::b,a::c,b::c', '*',         Nil ],

    # a::* subtracts all a's
    [ '*',              'a::*',      '*'    ],
    [ 'a::*',           'a::*',      Nil    ],
    [ 'a::b',           'a::*',      Nil    ],
    [ 'a::b,a::c',      'a::*',      Nil    ],
    [ 'a::*,b::*',      'a::*',      'b::*' ],
    [ 'a::*,b::c',      'a::*',      'b::c' ],
    [ 'a::b,b::*',      'a::*',      'b::*' ],
    [ 'a::b,b::c',      'a::*',      'b::c' ],
    [ 'a::b,a::c,b::*', 'a::*',      'b::*' ],
    [ 'a::b,a::c,b::c', 'a::*',      'b::c' ],

    # a::b subtracts exactly that
    [ '*',              'a::b',      '*'         ],
    [ 'a::*',           'a::b',      'a::*'      ],
    [ 'a::b',           'a::b',      Nil         ],
    [ 'a::b,a::c',      'a::b',      'a::c'      ],
    [ 'a::*,b::*',      'a::b',      'a::*,b::*' ],
    [ 'a::*,b::c',      'a::b',      'a::*,b::c' ],
    [ 'a::b,b::*',      'a::b',      'b::*'      ],
    [ 'a::b,b::c',      'a::b',      'b::c'      ],
    [ 'a::b,a::c,b::*', 'a::b',      'a::c,b::*' ],
    [ 'a::b,a::c,b::c', 'a::b',      'a::c,b::c' ],

    # a::b,b::* subtracts both of those
    [ '*',              'a::b,b::*', '*'    ],
    [ 'a::*',           'a::b,b::*', 'a::*' ],
    [ 'a::b',           'a::b,b::*', Nil    ],
    [ 'a::b,a::c',      'a::b,b::*', 'a::c' ],
    [ 'a::*,b::*',      'a::b,b::*', 'a::*' ],
    [ 'a::*,b::c',      'a::b,b::*', 'a::*' ],
    [ 'a::b,b::*',      'a::b,b::*',  Nil   ],
    [ 'a::b,b::c',      'a::b,b::*',  Nil   ],
    [ 'a::b,a::c,b::*', 'a::b,b::*', 'a::c' ],
    [ 'a::b,a::c,b::c', 'a::b,b::*', 'a::c' ],

    # a::b,b::c should work, too
    [ '*',              'a::b,b::c', '*'         ],
    [ 'a::*',           'a::b,b::c', 'a::*'      ],
    [ 'a::b',           'a::b,b::c', Nil         ],
    [ 'a::b,a::c',      'a::b,b::c', 'a::c'      ],
    [ 'a::*,b::*',      'a::b,b::c', 'a::*,b::*' ],
    [ 'a::*,b::c',      'a::b,b::c', 'a::*'      ],
    [ 'a::b,b::*',      'a::b,b::c', 'b::*'      ],
    [ 'a::b,b::c',      'a::b,b::c', Nil         ],
    [ 'a::b,a::c,b::*', 'a::b,b::c', 'a::c,b::*' ],
    [ 'a::b,a::c,b::c', 'a::b,b::c', 'a::c'      ]
  );

  for @subtractions {
    my ($m, $s) = .[0,1]».&{ GIO::FileAttributeMatcher.new($_) };
    my $r = $m.subtract($s);

    if .[2] {
      is  ~$r, .[2],  " FAM('{~$m}') - FAM('{~$s}') = FAM('{~$r}')";
    } else {
      nok  ~$r,       " FAM('{~$m}') - FAM('{~$s}') = Nil";
    }
  }
}

plan 69;

test-exact;
test-equality;
test-subtract;
