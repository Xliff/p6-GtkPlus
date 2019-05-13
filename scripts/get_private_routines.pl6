#!/usr/bin/env perl6
use v6.c;

my ($fd, $la, %subs);

grammar CFunc {
  rule TOP {
    <returns>
    # $<sub>=[ \w+ ]
    # [
    #   '(void)'
    #   |
    #   '(' [ <type> <var> ]+ % [ \s* ',' \s* ] ')'
    # ]
    # (\s* (<[A..Z]>+)+ %% '_')?';'
  }
  
  rule returns { :!s 'static '? 'const '? <t> \s* <p>? }
  token      p { '*'+ }
  token      t { <[\w _]>+ }
  rule    type { 'const'? $<n>=\w+ <p>? }
  rule     var { <t> }
}

sub MAIN ($dir) {
  die "'{ $dir }' is not a directory" unless $dir.IO.d;
  
  for $dir.IO.dir( test => *.ends-with('.h') ) -> $cf {
    my $contents = $cf.slurp;
    
    # Post process for bland
    $contents ~~ s:g/ '/*' ~ '*/' (.+?)//; # Comments
    $contents ~~ s:g/^^ '#' .+? \n//;      # Preprocessor
    
    my ($i, $parsed, @detected) = (1, False);
    for $contents.lines -> $l {
      if not $la {
        $la = True;
        $fd ~= $l.chomp;
        next;
      }
      if $la {
        $fd ~= ' ' ~ $l.chomp;
      }
  
      next unless $fd ~~ /';' \s* $$/;
      my $m = CFunc.parse($fd);
      $parsed = True;
      if $m {
        my @p;
        my $orig = $m<sub>.Str.trim;
        if not $orig.starts-with('_') {
          say "Skipping non-local sub '{ $orig }'" if %*ENV<P6_GTK_DEBUG>;
          next;
        }
        %subs{$orig} = {
          returns => $m,
          type    => $m<type>,
          vars    => $m<vars>
        };
        
      } else {
        say "Could not parse: «\n{ $fd }»";
      }
      
      NEXT { 
        ($fd, $la, $parsed) = ('', False, False) if $parsed;
      }
      
    }
  }
  
  %subs.keys.say;
}
