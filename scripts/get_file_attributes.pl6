#!/usr/bin/env perl6
use v6;

my rule  trait { 'is' .+? <[\<\(]>.+?<[\>\)]>  }
my token params { '('
<.ws>* [ <-[\)]>+ % <.ws>*','<.ws>* ] <.ws>* ')' }

sub MAIN ($filename, :aliases(:$with-aliases) = False ) {
  my $c = $filename.IO.slurp;
  my (@get, @set, %param-count);

  my $m = $c ~~ m:g/
    'method ' ( 'get' | 'set' ) '_' (.+?) \s* [ <trait> \s* ]?
    <[({]> <params>?
  /;

  my $e = $c ~~ m:g /
    'method ' (.+?) \s* [ <trait> \s* ]+?
    <[({]> <params>?
  /;

  my %e;
  $e .= grep({
    do if .<trait> {
      my $t = .<trait>.Str;
      do if $t.contains('is rw') && $t.contains('::').not {
        %e{ .[0].words.head } = 1;
        True;
      } else {
        False
      }
    } else {
      False
    }
  });

  for $m.Array -> $me {
    given $me[0].Str {
      when 'get' { @get.push: $me[1].Str }
      when 'set' { @set.push: $me[1].Str;
                   %param-count{ $me[1] } = $me<params>.elems }
    }
  }

  my @getset = do gather for @get.unique {
    # Also when %param-count<get>{<method>} is 0
    #  AND when %param-count<set>{<method>} is 1
    # ...Counts only apply to positionals. Regex isn't that smart, yet.
    take .Str if $_ eq @set.any;
  };

  for @getset.sort {
    next if $_ eq %e.keys.any;

    my $wa = do if $with-aliases && $_.contains('_' | '-') {
      my $a = $_;
      $a ~~ tr/-_/_-/;
      " is also<{ $a }>";
    } else {
      ''
    }

    say qq:to/ATTRIB/ ;
      method { $_ } is rw{$wa} is g-pseudo-property \{
        Proxy.new:
          FETCH => -> \$     \{ self.get_{ $_ }    \},
          STORE => -> \$, \\v \{ self.set_{ $_ }(v) \}
      \}
      ATTRIB
  }
}
