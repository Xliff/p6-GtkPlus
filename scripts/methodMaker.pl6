use v6.c;

sub MAIN ($filename, :$classname, :$attrname, :$acname) {
  die "Could not find {$filename}." unless $filename.IO.e;

  my $at = $attrname // '$!w';
  my $ac = $acname   // '$!ac';

  my $contents = $filename.IO.open.slurp-rest;

  my @methods;

  my $match = False;
  for $contents.lines -> $l {
    if $match {
      my rule attr_def {
        'has OpaquePointer'
        '$.' :!s $<attr>=(\w <[\w \d _ -]>+) \s+ ';' \s+
        '#' \s*
        '('
           [
              $<type>=\w+ \s+
              $<var>=[ ':'? '$' \w [ <[\w \d _ -]>+ ]? ]
           ]+ % [ ',' \s* ]
           [ \s+ '-->' \s+ \w+ ]?
        ');'
      }

      if $l ~~ /<attr_def>/ {
          my @params;
          @params.push: [ $/<attr_def><type>[$_].Str, $/<attr_def><var>[$_].Str ]
            for (^$/<attr_def><type>.elems);
          @methods.push: [ $/<attr_def><attr>.Str, @params ];
      }
    } else {
      my rule class_def {
        'class' ([\w+]+ % '::') "is repr('CStruct') \{"
      };
      $match = ($l ~~ /<class_def>/).Bool;
      if $match {
        $match.gist.say;
        if $classname {
            $match = $/<class_def>[0].trim eq $classname;
        }
      }
    }
  }

  if !$match {
    die "No class definition matching $classname" if $classname;
    die "No class definition found";
  }

  for @methods -> $m {
    next unless $m[1].elems;
    my @m_params = $m[1].clone;
    @m_params.shift;
    my $signature = '(' ~ @m_params.map({ "$_[0] $_[1]" }).join(', ') ~ ')';
    my $call = @m_params.map({
      $_[1] ~~ s/^ ':'? ('$' \w <[\w \d _ -]>+)/$0/;
      $_[1];
    }).join(', ');

    say "    method $m[0] $signature \{";
    say "      { $ac }.{ $m[0] }\({ $at }{ $call ?? ", $call" !! '' }\)";
    say "    \}\n";
  }
}
